module Processor
  class Anvil < Base
    include Stackable
    attr_reader :status

    def convert &proc
      @proc = proc
    end

    def initialize
      @status = nil
      @proc = proc{|base, tail| "#{base}#{tail}" }
      self.load_hiragana_katakana
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

    def katakanize
      @status = nil
      if self.stacked?
        self.fetch.each_char.map do |c|
          @hiragana_katakana[c] || c
        end
      else
        nil
      end
    end

    def pop
      super.tap do
        unless self.stacked?
          @status = nil
        end
      end
    end

    def clear
      super.tap do
        @status = nil
      end
    end

    def load_hiragana_katakana
      file = Dir[File.join('tables', 'hiragana_katakana').resource + '.*'].first
      text = open(file).read
      @hiragana_katakana = Hash[text.each_line.map(&:chomp).map{|line| line.split.map(&:strip)}]
    end
  end
end
