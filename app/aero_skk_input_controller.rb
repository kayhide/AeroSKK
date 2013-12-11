# -*- coding: utf-8 -*-
class AeroSKKInputController < IMKInputController
  def write_log string
    @file ||= File.expand_path('~/aero_skk.log')
    open(@file, 'a+') do |io|
      io << "[#{Time.now}] #{string}\n"
    end
  end

  def createEngine
    engine = Engine.new
    engine.register Processor::Table.new.tap{|p|
      p.table['+'] = 'E'
      p.table['j'] = 'a'
      p.table['r'] = 'r'
      p.table['k'] = 'o'
    }
    engine.register Processor::Table.new.tap{|p|
      p.table['E'] = ['_', 'e']
    }
    engine.register Processor::Table.new.tap{|p|
      p.table['e'] = 'E'
      p.table['a'] = 'A'
      p.table['ro'] = 'RO'
    }
    engine.register Processor::Delegator.new.tap{|p|
      p.delegate do |elm|
        @client.insertText(elm, replacementRange: [].nsrange)
        nil
      end
    }
    engine
  end

  def initWithServer server, delegate: delegate, client: client
    self.write_log 'initWithServer'
    @ignoring_key_codes ||= [
      102, # kVirtual_JISRomanModeKey
      104, # kVirtual_JISKanaModeKey
    ]
    @client = client
    @engine = self.createEngine
    super
  end

  def inputText string, key: keyCode, modifiers: flags, client: sender
    self.write_log "#{string}, #{keyCode}, #{flags}"
    unless @ignoring_key_codes.include? keyCode
      @client = sender
      @engine << string
    end
    true
  end
end
