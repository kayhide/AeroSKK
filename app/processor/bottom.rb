module Processor
  class Bottom < Array
    def to_s
      self.join
    end

    def to_a
      self.inject [] do |ary, elm|
        if (String === ary.last) && (String === elm)
          ary.last << elm
        else
          ary << elm
        end
        ary
      end
    end
  end
end
