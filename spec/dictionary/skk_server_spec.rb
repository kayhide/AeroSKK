describe Dictionary::SkkServer do
  extend Facon::SpecHelpers

  before do
    @skk_server = Dictionary::SkkServer.new('localhost', 12345)
  end

  describe '#lookup' do
    it 'runs system call by backticks literal' do
      @skk_server.should.receive(:'`').
        with("echo '1a ' | nc localhost 12345").
        and_return("1/a;a/\n")
      @skk_server.lookup('a')
    end

    describe 'with euc-jp encoding' do
      before do
        @skk_server.encoding = Encoding::EUC_JP
      end

      it 'runs nkf' do
        @skk_server.should.receive(:'`').
          with("echo '1a ' | nkf -W80 -e | nc localhost 12345 | nkf -E -w80").
          and_return("1/a;a/\n")
        @skk_server.lookup('a')
      end
    end
  end

  describe '#parse' do
    it 'splits' do
      @skk_server.parse("1/a/alpha").should == [['a'], ['alpha']]
    end

    it 'returns annotation' do
      @skk_server.parse("1/a;roman/alpha;greek").should == [['a', 'roman'], ['alpha', 'greek']]
    end
  end
end
