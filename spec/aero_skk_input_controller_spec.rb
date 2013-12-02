describe AeroSKKInputController do
  extend Facon::SpecHelpers

  before do
    @controller = AeroSKKInputController.new
  end

  describe '#inputText' do
    it 'returns true' do
      obj = Object.new
      obj.should.receive(:insertText).with('TEST', replacementRange: [].nsrange)
      @controller.inputText('test', client: obj)
    end
  end
end
