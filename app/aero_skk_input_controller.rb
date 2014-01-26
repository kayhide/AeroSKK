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
    @candidater = Candidater.new.tap do |c|
      Dir[File.expand_path('~/.aero_skk/skk_servers')].each do |f|
        Logger.write("read: #{f}")
        open(f) do |io|
          io.each_line do |line|
            line.chomp!
            host, port, encoding = line.split
            begin
              srv = Dictionary::SkkServer.new(host, port.to_i, Encoding.find(encoding))
              c.dictionaries << srv
              Logger.write("server added: #{line}")
            rescue
              Logger.write("failed to add server: #{line}")
            end
          end
        end
      end
    end
    super
  end

  def inputText string, key: keyCode, modifiers: flags, client: sender
    Logger.write "#{string}(#{string.inspect}), #{keyCode}, #{flags}"
    if @candidates.isVisible
      false
    elsif @ignoring_key_codes.include?(keyCode)
      true
    else
      @client = sender
      if @candidate_string
        if string =~ /[\a\e]/
          string = nil
        else
          self.insert @candidate_string
          if string =~ /[\r\n\x03]/
            string = nil
          end
        end
        @candidate_string = nil
      end
      if string == nil
        self.update_echo
        true
      elsif self.acceptable? string
        @engine << string
        self.update_echo
        true
      else
        Logger.write("passing #{string && string.inspect}")
        @engine.clear
        self.update_echo
        false
      end
    end
  end

  def acceptable? char
    (char =~ /[[:ascii:]]/) &&
      (char == "\b" || char =~ /[[:print:]]/)
  end

  def insert str
    Logger.write "insertText #{str.inspect}"
    @client.insertText(str, replacementRange: [].nsrange)
  end

  def update_echo
    str = @candidate_string || @engine.echo.to_s.underline
    if str.to_s != @client.attributedSubstringFromRange(@client.markedRange).to_s
      @client.setMarkedText(str,
        selectionRange: [str.length, 0].nsrange,
        replacementRange: [].nsrange)
    end
  end


  def candidates sender
    @candidater.candidates
  end

  def candidateSelectionChanged str
    Logger.write "candidateSelectionChanged #{str}"
    @candidate_string = str
    self.update_echo
  end

  def candidateSelected str
    Logger.write "candidateSelected #{str}"
    @candidater.take str
    @candidate_string = nil
    self.insert str
  end
end
