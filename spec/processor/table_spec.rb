describe Processor::Table do
  before do
    @processor = Processor::Table.new
  end

  describe '#to_s' do
    it 'returns chars' do
      @processor << 'a' << 'e' << 'r' << 'o'
      @processor.to_s.should == 'aero'
    end

    it 'converts single char' do
      @processor.table['a'] = 'A'
      @processor << 'a' << 'e' << 'r' << 'o'
      @processor.to_s.should == 'Aero'
    end

    it 'converts many chars' do
      @processor.table['ro'] = 'RO'
      @processor.table['ra'] = 'RA'
      @processor << 'a' << 'e' << 'r' << 'o'
      @processor.to_s.should == 'aeRO'
    end

    it 'discards overridden char' do
      @processor.table['ro'] = 'RO'
      @processor << 'a' << 'e' << 'r' << 'r' << 'o'
      @processor.to_s.should == 'aeRO'
    end

    it 'suspends full matched char' do
      @processor.table['d'] = 's'
      @processor.table['df'] = 'x'
      @processor << 'd' << 'a' << 'd' << 'f' << 'a'
      @processor.to_s.should == 'saxa'
    end
  end
end
