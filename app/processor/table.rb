module Processor
  class Table < Base
    extend TableCreate
    include Stackable
    attr_reader :table

    def initialize
      @table = {}
    end

    def process elm
      self.push elm
      val = nil
      pairs = @table.select do |k, v|
        val = v if k == self.peek
        k.start_with? self.peek
      end
      if pairs.one? && val
        self.clear
        val
      elsif pairs.blank?
        if self.stack.length > elm.length
          last_cache = self.fetch[0...-elm.length]
          if full = @table[last_cache]
            [full, self.process(elm)].flatten
          else
            self.process elm
          end
        else
          self.clear
          elm
        end
      end
    end
  end
end
