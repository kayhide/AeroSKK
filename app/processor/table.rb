module Processor
  class Table < Base
    extend TableCreate
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
      if pairs.one? && val
        @cache = ''
        val
      elsif pairs.blank?
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

    def echo
      @cache
    end
  end
end
