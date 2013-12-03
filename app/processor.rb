class Processor
  attr_accessor :table
  attr_reader :cache

  def initialize
    @table = {}
    @chars = []
    @cache = ''
  end

  def to_s
    @chars.join
  end

  def << str
    str.each_char do |c|
      @chars << self.process(c)
    end
    self
  end

  def process char
    @cache << char
    fulls, partials = self.hits @cache

    if fulls.count == 1
      @cache = ''
      fulls.first.last
    elsif partials.count == 0
      if @cache.length > char.length
        @cache = ''
        self.process char
      else
        char
      end
    else
      ''
    end
  end

  def hits str
    @table.select do |k, v|
      k.start_with? str
    end.partition do |k, v|
      k == str
    end
  end

  def uncache
    cache = @cache
    @cache = ''
    cache
  end
end
