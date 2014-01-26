describe Processor::Anvil do
  before do
    @processor = Processor::Anvil.new
  end

  describe '#to_s' do
    it 'blocks after wedge opened' do
      @processor << 'a' << :wedge << 'e' << 'r' << 'o'
      @processor.to_s.should == 'a'
    end

    it 'returns string after wedge closed' do
      @processor << 'a' << :wedge << 'e' << :wedge << 'r' << 'o'
      @processor.to_s.should == 'aero'
    end

    it 'neglects hammer before wedge opened' do
      @processor << 'a' << :hammer << 'e' << 'r' << 'o'
      @processor.to_s.should == 'aero'
    end

    it 'neglects just after hammer' do
      @processor << 'a' << :wedge << 'e' << :hammer << ' ' << 'r' << 'o'
      @processor.to_s.should == 'aero'
    end
  end

  describe '#echo' do
    it 'returns string after wedge opened' do
      @processor << 'a' << :wedge << 'e' << 'r' << 'o'
      @processor.echo.should == 'ero'
    end

    it 'returns cache string' do
      @processor << 'r'
      @processor.echo.should == ''
    end
  end

  describe '#clear' do
    it 'sets status nil' do
      @processor << 'a' << :wedge << 'e' << 'r' << 'o'
      @processor.clear
      @processor.status.should == nil
    end
  end
end
