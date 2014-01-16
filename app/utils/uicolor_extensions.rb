# from sugarcube-uikit/symbol.rb
# required by sugarcube-attributedstring
# replacing UIColor by NSColor
module UIColorExtensions
  module SymbolMethods
    def uicolor(alpha=nil)
      if Symbol.uicolors.has_key? self
        # iOS colors
        color = NSColor.send(SugarCube.look_in(self, Symbol.uicolors, Symbol.uicolors__deprecated))

        if not alpha.nil?
          color = color.colorWithAlphaComponent(alpha.to_f)
        end
      elsif Symbol.css_colors_cache.has_key? self
        color = Symbol.css_colors_cache[self]
      else
        # css colors
        color = SugarCube.look_in(self, Symbol.css_colors).uicolor
        Symbol.css_colors_cache[self] = color
      end

      if alpha
        color = color.uicolor(alpha)
      end

      color
    end
  end

  module SymbolClassMethods
    def uicolors__deprecated
      @uicolors__deprecated ||= {
        darkgray: :dark_gray,
        lightgray: :light_gray,
      }
    end

    def uicolors
      @uicolors ||= {
        black:     :blackColor,
        blue:      :blueColor,
        brown:     :brownColor,
        cyan:      :cyanColor,
        dark_gray:  :darkGrayColor,
        gray:      :grayColor,
        green:     :greenColor,
        light_gray: :lightGrayColor,
        magenta:   :magentaColor,
        orange:    :orangeColor,
        purple:    :purpleColor,
        red:       :redColor,
        yellow:    :yellowColor,
        white:     :whiteColor,
        clear:     :clearColor,

        light_text: :lightTextColor,
        dark_text:  :darkTextColor,

        table_view:  :groupTableViewBackgroundColor,
        scroll_view: :scrollViewTexturedBackgroundColor,
        flipside:    :viewFlipsideBackgroundColor,
        under_page:  :underPageBackgroundColor,
      }
    end

    def css_colors_cache
      @css_colors_cache ||= {}
    end

    def css_colors
      @css_colors ||= {
        # for css_name to pick up on these colors, they need to be defined here
        black:     0x000000,
        blue:      0x0000ff,
        brown:     0x996633,
        cyan:      0x00ffff,
        dark_gray:  0x555555,
        gray:      0x808080,
        green:     0x00ff00,
        light_gray: 0xaaaaaa,
        magenta:   0xff00ff,
        orange:    0xff8000,
        purple:    0x800080,
        red:       0xff0000,
        yellow:    0xffff00,
        white:     0xffffff,

        # uikit colors
        placeholder: 0xb2b2b2,  # UITextField placeholder color

        # unlike other places, these do not use snake_case, because they are from
        # the CSS standard names
        aliceblue:            0xf0f8ff,
        antiquewhite:         0xfaebd7,
        aqua:                 0x00ffff,
        aquamarine:           0x7fffd4,
        azure:                0xf0ffff,
        babygray:             0x576077,
        beige:                0xf5f5dc,
        bisque:               0xffe4c4,
        blanchedalmond:       0xffebcd,
        blueviolet:           0x8a2be2,
        burlywood:            0xdeb887,
        cadetblue:            0x5f9ea0,
        chartreuse:           0x7fff00,
        chocolate:            0xd2691e,
        colingray:            0x526691,
        coral:                0xff7f50,
        cornflowerblue:       0x6495ed,
        cornsilk:             0xfff8dc,
        crimson:              0xdc143c,
        darkblue:             0x00008b,
        darkcyan:             0x008b8b,
        darkgoldenrod:        0xb8860b,
        darkgreen:            0x006400,
        darkkhaki:            0xbdb76b,
        darkmagenta:          0x8b008b,
        darkolivegreen:       0x556b2f,
        darkorange:           0xff8c00,
        darkorchid:           0x9932cc,
        darkred:              0x8b0000,
        darksalmon:           0xe9967a,
        darkseagreen:         0x8fbc8f,
        darkslateblue:        0x483d8b,
        darkslategray:        0x2f4f4f,
        darkturquoise:        0x00ced1,
        darkviolet:           0x9400d3,
        deeppink:             0xff1493,
        deepskyblue:          0x00bfff,
        dimgray:              0x696969,
        dodgerblue:           0x1e90ff,
        firebrick:            0xb22222,
        floralwhite:          0xfffaf0,
        forestgreen:          0x228b22,
        fuchsia:              0xff00ff,
        gainsboro:            0xdcdcdc,
        ghostwhite:           0xf8f8ff,
        gold:                 0xffd700,
        goldenrod:            0xdaa520,
        greenyellow:          0xadff2f,
        honeydew:             0xf0fff0,
        hotpink:              0xff69b4,
        indianred:            0xcd5c5c,
        indigo:               0x4b0082,
        ivory:                0xfffff0,
        khaki:                0xf0e68c,
        lavender:             0xe6e6fa,
        lavenderblush:        0xfff0f5,
        lawngreen:            0x7cfc00,
        lemonchiffon:         0xfffacd,
        lightblue:            0xadd8e6,
        lightcoral:           0xf08080,
        lightcyan:            0xe0ffff,
        lightgoldenrodyellow: 0xfafad2,
        lightgreen:           0x90ee90,
        lightpink:            0xffb6c1,
        lightsalmon:          0xffa07a,
        lightseagreen:        0x20b2aa,
        lightskyblue:         0x87cefa,
        lightslategray:       0x778899,
        lightsteelblue:       0xb0c4de,
        lightyellow:          0xffffe0,
        lime:                 0x00ff00,
        limegreen:            0x32cd32,
        linen:                0xfaf0e6,
        maroon:               0x800000,
        mediumaquamarine:     0x66cdaa,
        mediumblue:           0x0000cd,
        mediumorchid:         0xba55d3,
        mediumpurple:         0x9370d8,
        mediumseagreen:       0x3cb371,
        mediumslateblue:      0x7b68ee,
        mediumspringgreen:    0x00fa9a,
        mediumturquoise:      0x48d1cc,
        mediumvioletred:      0xc71585,
        midnightblue:         0x191970,
        mintcream:            0xf5fffa,
        mistyrose:            0xffe4e1,
        moccasin:             0xffe4b5,
        navajowhite:          0xffdead,
        navy:                 0x000080,
        oldlace:              0xfdf5e6,
        olive:                0x808000,
        olivedrab:            0x6b8e23,
        orangered:            0xff4500,
        orchid:               0xda70d6,
        palegoldenrod:        0xeee8aa,
        palegreen:            0x98fb98,
        paleturquoise:        0xafeeee,
        palevioletred:        0xd87093,
        papayawhip:           0xffefd5,
        peachpuff:            0xffdab9,
        peru:                 0xcd853f,
        pink:                 0xffc0cb,
        plum:                 0xdda0dd,
        powderblue:           0xb0e0e6,
        rosybrown:            0xbc8f8f,
        royalblue:            0x4169e1,
        saddlebrown:          0x8b4513,
        salmon:               0xfa8072,
        sandybrown:           0xf4a460,
        seagreen:             0x2e8b57,
        seashell:             0xfff5ee,
        sienna:               0xa0522d,
        silver:               0xc0c0c0,
        skyblue:              0x87ceeb,
        slateblue:            0x6a5acd,
        slategray:            0x708090,
        snow:                 0xfffafa,
        springgreen:          0x00ff7f,
        steelblue:            0x4682b4,
        tan:                  0xd2b48c,
        teal:                 0x008080,
        thistle:              0xd8bfd8,
        tomato:               0xff6347,
        torygray:             0x5c5a5d,
        turquoise:            0x40e0d0,
        violet:               0xee82ee,
        wheat:                0xf5deb3,
        whitesmoke:           0xf5f5f5,
        yellowgreen:          0x9acd32,
      }
    end
  end
end

class Symbol
  include UIColorExtensions::SymbolMethods
  extend UIColorExtensions::SymbolClassMethods
end
