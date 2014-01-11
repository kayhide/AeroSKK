module Processor
  class Anvil < Base
    def initialize
      self.clear
    end

    def process elm
      if @hammered
        str = @cache
        self.clear
        str
      elsif @wedge_closed
        str = @cache + elm
        self.clear
        str
      elsif @wedge_opened
        @cache << elm
        nil
      else
        elm
      end
    end

    def echo
      @cache
    end

    def wedge
      if @cache.present?
        @wedge_opened = true
        @wedge_closed = true
      else
        @wedge_opened = true
        @wedge_closed = false
      end
      nil
    end

    def hammer
      if @cache.present?
        @hammered = true
      end
      nil
    end

    def clear
      @cache = ''
      @wedge_opened = false
      @wedge_closed = false
      @hammered = false
    end
  end
end
