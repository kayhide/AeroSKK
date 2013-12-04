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
      if self.processable?(elm)
        self.takeover self.process(elm)
      else
        self.takeover elm
      end
      self
    end

    def takeover elm
      if elm
        if Enumerable === elm
          elm.each do |e|
            self.takeover e
          end
        else
          self.next << elm
        end
      end
    end

    def processable? elm
      false
    end

    def process elm
      elm
    end
  end
end
