class Engine
  attr_reader :processors

  def initialize
    @processors = []
  end

  def register processor
    if Symbol === processor
      processor = Processor::Table.create(processor)
    end
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

  def echo
    @processors.reverse.map(&:echo).join
  end

  def pop
    @processors.select do |p|
      p.respond_to? :pop
    end.find do |p|
      p.pop
    end
  end
end
