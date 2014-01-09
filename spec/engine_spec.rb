describe Engine do
  describe '#to_s' do
    before do
      @engine = Engine.new
      @engine.register Processor::Table.new.tap{|p|
        p.table['+'] = 'E'
        p.table['j'] = 'a'
        p.table['r'] = 'r'
        p.table['k'] = 'o'
      }
      @engine.register Processor::Table.new.tap{|p|
        p.table['E'] = [:wedge, 'e']
      }
      @engine.register Processor::Table.new.tap{|p|
        p.table['e'] = 'E'
        p.table['a'] = 'A'
        p.table['ro'] = 'RO'
      }
    end

    it 'returns processed string' do
      @engine << '+' << 'j' << 'r' << 'k'
      @engine.to_a.should == [:wedge, 'EARO']
    end
  end

  describe '#echo' do
    it 'returns processor echo' do
      @engine = Engine.new
      @engine.register Processor::Table.new.tap{|p|
        p.table['ka'] = 'KA'
      }
      @engine << 'k'
      @engine.echo.should == 'k'
    end

    it 'joins each processor echoes' do
      @engine = Engine.new
      @engine.register Processor::Table.new.tap{|p|
        p.table['ka'] = 'KA'
      }
      @engine.register Processor::Table.new.tap{|p|
        p.table['ta'] = 'TA'
      }
      @engine << 't' << 'k'
      @engine.echo.should == 'tk'
    end

  end
end
