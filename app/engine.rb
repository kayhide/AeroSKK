class Engine
  attr_accessor :server
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
    case elm
    when "\b"
      unless self.pop
        @processors.first << elm
      end
    else
      @processors.first << elm
    end
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
    @processors.find do |p|
      p.respond_to?(:pop) && p.pop
    end
  end

  def clear
    @processors.each do |p|
      p.respond_to?(:clear) && p.clear
    end
  end
end
