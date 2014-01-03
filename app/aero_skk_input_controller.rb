# -*- coding: utf-8 -*-
class AeroSKKInputController < IMKInputController
  def createEngine
    engine = Engine.new
    engine.register Processor::Table.new.tap{|p|
      p.table['E'] = ['_', 'e']
    }
    engine.register :cielo_roma
    engine.register :roma_hiragana

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
      102, # kVirtual_JISRomanModeKey
      104, # kVirtual_JISKanaModeKey
    ]
    @client = client
    @engine = self.createEngine
    super
  end

  def inputText string, key: keyCode, modifiers: flags, client: sender
    Logger.write "#{string}, #{keyCode}, #{flags}"
    unless @ignoring_key_codes.include? keyCode
      @client = sender
      @engine << string
    end
    true
  end
end
