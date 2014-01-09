describe Processor::TableCreate do
  extend Facon::SpecHelpers

  class TableMock
    extend Processor::TableCreate
    def table; @table ||= {}; end
  end

  describe '.create' do
    it 'reads table file' do
      @mock = TableMock.create :roma_hiragana
      @mock.table.present?.should == true
    end
  end

  describe '.parse_line' do
    it 'returns array as key value pair' do
      TableMock.parse_line('a b').should == ['a', 'b']
    end

    it 'returns array value for multiple chars' do
      key, value = TableMock.parse_line('a xyz')
      value.should == %w(x y z)
    end

    it 'replaces special chars' do
      key, value = TableMock.parse_line('a <<space>>x<<return>>y<<tab>>z')
      value.should == [' ', 'x', "\n", 'y', "\t", 'z']
    end

    it 'replaces lt and gt' do
      key, value = TableMock.parse_line('a <<lt>><<lt>><<gt>><<gt>>')
      value.should == %w(< < > >)
    end

    it 'replaces wedge and hammer' do
      key, value = TableMock.parse_line('a <<wedge>>x<<hammer>>')
      value.should == [:wedge, 'x', :hammer]
    end
  end
end
