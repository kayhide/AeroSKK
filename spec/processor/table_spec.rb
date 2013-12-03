describe Processor::Table do
  before do
    @processor = Processor::Table.new
  end

  describe '#to_s' do
    it 'returns chars' do
      @processor << 'aero'
      @processor.to_s.should == 'aero'
    end

    it 'converts single char' do
      @processor.table['a'] = 'A'
      @processor << 'aero'
      @processor.to_s.should == 'Aero'
    end

    it 'converts many chars' do
      @processor.table['ro'] = 'RO'
      @processor.table['ra'] = 'RA'
      @processor << 'aero'
      @processor.to_s.should == 'aeRO'
    end

    it 'discards overridden char' do
      @processor.table['ro'] = 'RO'
      @processor << 'aerro'
      @processor.to_s.should == 'aeRO'
    end

    it 'processes array' do
      @processor.table['ro'] = 'RO'
      @processor << ['aerro']
      @processor.to_s.should == 'aeRO'
    end
  end
end
