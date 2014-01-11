module Processor
  module Stackable
    def stack
      @stack ||= []
    end

    def push elm
      @peek = nil
      self.stack.push elm
    end

    def pop
      @peek = nil
      self.stack.pop
    end

    def clear
      @peek = nil
      self.stack.clear
    end

    def fetch
      str = self.peek
      self.clear
      str
    end

    def peek
      @peek ||= self.stack.join
    end

    def stacked?
      self.stack.present?
    end

    def echo
      self.peek
    end
  end
end
