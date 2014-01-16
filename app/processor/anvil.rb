module Processor
  class Anvil < Base
    include Stackable

    def convert &proc
      @proc = proc
    end

    def initialize
      @status = nil
      @proc = proc{|base, tail| "#{base}#{tail}" }
    end

    def process elm
      Logger.write "status #{@status}"
      case @status
      when :opened
        self.push elm
        nil
      when :closed
        @status = nil
        @proc.call [self.fetch, elm]
      when :hammered
        @status = nil
        @proc.call [self.fetch, nil]
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

    def pop
      super.tap do
        unless self.stacked?
          @status = nil
        end
      end
    end
  end
end
