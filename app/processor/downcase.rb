module Processor
  class Downcase < Base
    include StringProcessable

    def process elm
      elm.downcase
    end
  end
end
