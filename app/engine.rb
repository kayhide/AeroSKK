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
    ary = @processors.first.to_a
    ary.inject [] do |a, elm|
      if (String === a.last) && (String === elm)
        a.last << elm
      else
        a << elm
      end
      a
    end
  end
end
