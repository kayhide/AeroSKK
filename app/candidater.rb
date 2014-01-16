class Candidater
  attr_accessor :source

  def candidates
    [@source.join, @source.join + '1', @source.join + '2']
  end

  def echo
    @source && @source.join
  end

  def take str
    @source = nil
  end
end
