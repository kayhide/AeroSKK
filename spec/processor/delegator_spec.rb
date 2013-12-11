describe Processor::Delegator do
  before do
    @processor = Processor::Delegator.new
  end

  it 'calls delegated proc' do
    str = nil
    @processor.delegate do |elm|
      str = elm
    end
    @processor << 'test'
    str.should == 'test'
  end
end
