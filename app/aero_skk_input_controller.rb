class AeroSKKInputController < IMKInputController
  def createEngine
    engine = Engine.new
    engine.register :wedge_cielo
    engine.register :cielo_roma
    engine.register :roma_hiragana

    engine.register Processor::Anvil.new.tap{|p|
      p.convert do |base, tail|
        @candidater.source = [base, tail]
        @candidates.updateCandidates
        @candidates.show(KIMKLocateCandidatesBelowHint)
        nil
      end
    }
    engine.register Processor::Delegator.new.tap{|p|
      p.delegate do |elm|
        self.insert elm
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
    @candidates = IMKCandidates.alloc.initWithServer(
      server,
      panelType: KIMKSingleColumnScrollingCandidatePanel
    )
    @candidater = Candidater.new
    super
  end

  def inputText string, key: keyCode, modifiers: flags, client: sender
    Logger.write "#{string}, #{keyCode}, #{flags}"
    unless @ignoring_key_codes.include? keyCode
      @client = sender
      unless string == "\b" && @engine.pop
        @engine << string
      end
      self.update_echo
    end
    true
  end

  def insert str
    Logger.write "insertText #{str.inspect}"
    @client.insertText(str, replacementRange: [].nsrange)
  end

  def update_echo
    str = @engine.echo.to_s.underline + @candidater.echo.to_s.bold
    if str != @last_echo
      @client.setMarkedText(str,
        selectionRange: [str.length, 0].nsrange,
        replacementRange: [].nsrange)
    end
    @last_echo = str
  end


  def candidates sender
    @candidater.candidates
  end

  def candidateSelectionChanged str
    Logger.write "candidateSelectionChanged #{str}"
    self.update_echo
  end

  def candidateSelected str
    Logger.write "candidateSelected #{str}"
    @candidater.take str
    self.insert str
  end
end
