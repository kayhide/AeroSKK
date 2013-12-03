module Processor
  class Table < Base
    include StringProcessable
    attr_reader :table

    def initialize
      @table = {}
      @cache = ''
    end

    def process elm
      elm.each_char.map do |c|
        self.process_char c
      end
    end

    def process_char char
      @cache << char
      if full = @table[@cache]
        @cache = ''
        full
      else
        if @table.keys.each_with_object(@cache).none?(&:start_with?)
          if @cache.length > char.length
            @cache = ''
            self.process_char char
          else
            @cache = ''
            char
          end
        end
      end
    end
  end
end
