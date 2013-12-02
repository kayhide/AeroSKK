module NSRangeExtensions
  module ArrayMethods
    def nsrange
      raise 'Too large to make a range' if self.length > 2
      while self.length < 2
        self << NSNotFound
      end
      NSMakeRange(*self)
    end
  end
end

class Array
  include NSRangeExtensions::ArrayMethods
end
