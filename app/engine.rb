class Engine
  attr_reader :processors

  def initialize
    @processors = []
  end

  def register processor
    if @processors.any?
      @processors.last.next = processor
    end
    @processors << processor
  end

  def << elm
    @processors.first << elm
    self
  end

  def to_s
    @processors.first.to_s
  end

  def to_a
    @processors.first.to_a
  end
end
