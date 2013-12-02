class AeroSKKInputController < IMKInputController
  def inputText string, client: sender
    @file ||= File.expand_path('~/aero_skk.log')
    open(@file, 'a+') do |io|
      io << "[#{Time.now}] #{string}\n"
    end
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
end
