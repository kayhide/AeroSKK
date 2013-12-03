module Processor
  class Bottom < Base
    def next
      @next ||= []
    end

    def to_s
      self.next.join
    end

    def to_a
      self.next
    end
  end
end
