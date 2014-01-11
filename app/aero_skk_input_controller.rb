class AeroSKKInputController < IMKInputController
  def createEngine
    engine = Engine.new
    engine.register :wedge_cielo
    engine.register :cielo_roma
    engine.register :roma_hiragana

    engine.register Processor::Anvil.new
    engine.register Processor::Delegator.new.tap{|p|
      p.delegate do |elm|
        Logger.write "insertText #{elm}"

        @client.insertText(elm, replacementRange: [].nsrange)
        nil
      end
    }
    engine
  end

  def initWithServer server, delegate: delegate, client: client
    Logger.write 'initWithServer'
    @ignoring_key_codes ||= [
      KeyCode::JISRomanModeKey,
      KeyCode::JISKanaModeKey,
    ]
    @client = client
    @engine = self.createEngine
    super
  end

  def inputText string, key: keyCode, modifiers: flags, client: sender
    Logger.write "#{string}, #{keyCode}, #{flags}"
    unless @ignoring_key_codes.include? keyCode
      @client = sender
      unless string == "\b" && @engine.pop
        @engine << string
      end
      self.update_echo @engine.echo
    end
    true
  end

  def update_echo str
    if str != @last_echo
      @client.setMarkedText(str.underline,
        selectionRange: [str.length, 0].nsrange,
        replacementRange: [].nsrange)
    end
    @last_echo = str
  end
end
