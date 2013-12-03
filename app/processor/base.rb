module Processor
  class Base
    attr_writer :next

    def next
      @next ||= Bottom.new
    end

    def to_s
      self.next.to_s
    end

    def to_a
      self.next.to_a
    end

    def << elm
      if Enumerable === elm
        elm.inject(self, &:<<)
      elsif elm
        elm = self.process(elm) if self.processable?(elm)
        if elm
          self.next << elm
        end
      end
      self
    end

    def processable? elm
      false
    end

    def process elm
      elm
    end
  end
end
