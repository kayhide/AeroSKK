describe Processor::Base do
  class Succ < Processor::Base
    include Processor::StringProcessable
    def process elm; elm.succ; end
  end

  class Upcase < Processor::Base
    include Processor::StringProcessable
    def process elm; elm.upcase; end
  end

  it 'processes array' do
    processor = Processor::Base.new
    processor << [:a, 'b']
    processor.to_a.should == [:a, 'b']
  end

  it 'processes array' do
    processor = Processor::Base.new
    processor << [:a, [:b, 'b']]
    processor.to_a.should == [:a, :b, 'b']
  end

  describe 'next' do
    before do
      @processor = Succ.new
      @processor.next = Upcase.new
    end

    it 'takeovers processed string' do
      @processor << 'aera'
      @processor.to_s.should == 'AERB'
    end
  end
end
