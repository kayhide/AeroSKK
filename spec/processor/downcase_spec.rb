describe Processor::Downcase do
  before do
    @processor = Processor::Downcase.new
  end

  describe '#to_s' do
    it 'passes lower case chars' do
      @processor << 'aero'
      @processor.to_s.should == 'aero'
    end

    it 'converts upper case chars' do
      @processor << 'AeRO'
      @processor.to_s.should == 'aero'
    end
  end
end
