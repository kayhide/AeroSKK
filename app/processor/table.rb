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
      if full = @table[@cache]
        @cache = ''
        full
      else
        if @table.keys.each_with_object(@cache).none?(&:start_with?)
          if @cache.length > elm.length
            @cache = ''
            self.process elm
          else
            @cache = ''
            elm
          end
        end
      end
    end
  end
end
