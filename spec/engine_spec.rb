describe Engine do
  describe '#<<' do
    before do
      @engine = Engine.new
      @engine.register Processor::Table.new.tap{|p|
        p.table['ka'] = 'KA'
      }
      @engine.register Processor::Table.new.tap{|p|
        p.table['ta'] = 'TA'
      }
    end

    describe 'pushing backspace' do
      it 'passes when not stacked' do
        @engine << "\b"
        @engine.to_a.should == ["\b"]
      end

      it 'pops when stacked' do
        @engine << 't' << 'k' << "\b"
        @engine.echo.should == 't'
      end
    end
  end

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

  describe '#pop' do
    it 'returns nil when no stack existed' do
      @engine = Engine.new
      @engine.register Processor::Base.new
      @engine.pop.should == nil
    end

    it 'returns nil when stacks are all empty' do
      @engine = Engine.new
      @engine.register Processor::Table.new.tap{|p|
        p.table['ka'] = 'KA'
      }
      @engine.register Processor::Table.new.tap{|p|
        p.table['ta'] = 'TA'
      }
      @engine.pop.should == nil
    end

    it 'pops last char from stack' do
      @engine = Engine.new
      @engine.register Processor::Table.new.tap{|p|
        p.table['abc'] = 'ABC'
      }
      @engine << 'a' << 'b'
      @engine.pop
      @engine.echo.should == 'a'
    end

    it 'pops last char on the stack of first processor' do
      @engine = Engine.new
      @engine.register Processor::Table.new.tap{|p|
        p.table['ka'] = 'KA'
      }
      @engine.register Processor::Table.new.tap{|p|
        p.table['ta'] = 'TA'
      }
      @engine << 't' << 'k'
      @engine.pop
      @engine.echo.should == 't'
    end
  end

  describe '#clear' do
    it 'clears stack' do
      @engine = Engine.new
      @engine.register Processor::Table.new.tap{|p|
        p.table['abc'] = 'ABC'
      }
      @engine << 'a' << 'b'
      @engine.clear
      @engine.echo.should == ''
    end

    it 'clears all stacks' do
      @engine = Engine.new
      @engine.register Processor::Table.new.tap{|p|
        p.table['ka'] = 'KA'
      }
      @engine.register Processor::Table.new.tap{|p|
        p.table['ta'] = 'TA'
      }
      @engine << 't' << 'k'
      @engine.clear
      @engine.echo.should == ''
    end
  end
end
