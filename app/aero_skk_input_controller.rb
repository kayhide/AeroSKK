class AeroSKKInputController < IMKInputController
  def write_log string
    @file ||= File.expand_path('~/aero_skk.log')
    open(@file, 'a+') do |io|
      io << "[#{Time.now}] #{string}\n"
    end
  end

  def initWithServer server, delegate: delegate, client: client
    self.write_log 'initWithServer'
    super
  end

  def inputText string, client: sender
    charset = NSCharacterSet.characterSetWithCharactersInString(('a'..'z').to_a.join)
    scanner = NSScanner.scannerWithString(string)
    isLatinChar = scanner.scanCharactersFromSet(charset, intoString: nil)
    if (isLatinChar)
      sender.insertText(string.upcase, replacementRange: [].nsrange)
      true
    else
      false
    end
  end

  def handleEvent event, client: sender
    eventString = event.characters
    keyCode = event.keyCode
    modifierFlags = event.modifierFlags
    self.write_log "#{eventString}, #{keyCode}, #{modifierFlags}"
    if self.inputText eventString, client: sender
      true
    else
      super
    end
  end
end
