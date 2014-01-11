describe Processor::Base do
  describe '#to_s' do
    it 'concats' do
      processor = Processor::Base.new
      processor << 'a' << 'e' << 'ro'
      processor.to_s.should == 'aero'
    end
  end

  describe '#to_a' do
    it 'concats strings' do
      processor = Processor::Base.new
      processor << 'a' << 'e' << :x << 'ro'
      processor.to_a.should == ['ae', :x, 'ro']
    end
  end

  describe 'next' do
    class Succ < Processor::Base
      def process elm; elm.succ; end
    end

    class Upcase < Processor::Base
      def process elm; elm.upcase; end
    end

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
