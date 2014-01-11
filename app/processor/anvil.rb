module Processor
  class Anvil < Base
    include Stackable

    def initialize
      @status = nil
    end

    def process elm
      case @status
      when :opened
        self.push elm
        nil
      when :closed
        @status = nil
        self.fetch + elm
      when :hammered
        @status = nil
        self.fetch
      else
        elm
      end
    end

    def wedge
      if self.stacked?
        @status = :closed
      else
        @status = :opened
      end
      nil
    end

    def hammer
      if self.stacked?
        @status = :hammered
      end
      nil
    end
  end
end
