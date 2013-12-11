module Processor
  class Table < Base
    include StringProcessable
    attr_reader :table

    def initialize
      @table = {}
      @cache = ''
    end

    def process elm
      @cache << elm
      val = nil
      pairs = @table.select do |k, v|
        val = v if k == @cache
        k.start_with? @cache
      end
      if pairs.length == 1 && val
        @cache = ''
        val
      elsif pairs.length == 0
        if @cache.length > elm.length
          last_cache = @cache[0...-elm.length]
          @cache = ''
          if full = @table[last_cache]
            [full, self.process(elm)].flatten
          else
            self.process elm
          end
        else
          @cache = ''
          elm
        end
      end
    end


    def self.create name
      file = Dir[File.join('tables', name.to_s).resource + '.*'].first
      text = open(file).read
      hash = Hash[text.each_line.map(&:chomp).map{|line| self.parse_line line}]

      self.new.tap do |p|
        p.table.merge! hash
      end
    end

    def self.parse_line line
      key, value = line.split
      if String === value && value.length > 1
        value = value.each_char.to_a
      end
      [key, value]
    end
  end
end
