class Candidater
  attr_accessor :source
  attr_reader :dictionaries

  def initialize
    @dictionaries = []
  end

  def candidates
    cands = @dictionaries.map do |dict|
      dict.lookup(*@source)
    end.inject(&:+)
    [*cands.map(&:first), @source.join]
  end

  def echo
    @source && @source.join
  end

  def take str
    @source = nil
  end
end
