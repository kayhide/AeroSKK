module Processor
  class Delegator < Base
    def delegate &proc
      @proc = proc
    end

    def processable? elm
      true
    end

    def process elm
      @proc.call elm
    end
  end
end
