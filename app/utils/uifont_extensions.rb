# from sugarcube-uikit/symbol.rb
# required by sugarcube-attributedstring
# replacing UIFont by NSFont
module UIFontExtensions
  module SymbolMethods
    def uifont size = nil
      size ||= NSFont.systemFontSize
      # system fonts
      if Symbol.uifont.has_key? self
        font = SugarCube.look_in(self, Symbol.uifont)
        if size.is_a?(Symbol)
          size = size.uifontsize
        end
        if font.is_a?(Symbol)
          return NSFont.send(font, size)
        else
          return font.uifont(size)
        end
      else
        if size.is_a?(Symbol)
          size = size.uifontsize
        end
        return NSFont.systemFontOfSize(size)
      end
    end

    def uifontsize
      size = SugarCube.look_in(self, Symbol.uifontsize)
      if size.is_a?(Symbol)
        return UIFont.send(size)
      end
      return size.to_f
    end
  end

  module SymbolClassMethods
    def uifont
      @uifont ||= {
        system: :"systemFontOfSize:",
        bold:   :"boldSystemFontOfSize:",
        italic: :"italicSystemFontOfSize:",
        monospace: 'Courier New',
      }
    end

    def uifontsize
      @uifontsize = {
        label:  :labelFontSize,
        button: :buttonFontSize,
        small:  :smallSystemFontSize,
        system: :systemFontSize,
      }
    end
  end
end

class Symbol
  include UIFontExtensions::SymbolMethods
  extend UIFontExtensions::SymbolClassMethods
end
