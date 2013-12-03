module Processor
  module StringProcessable
    def processable? elm
      String === elm
    end
  end
end
