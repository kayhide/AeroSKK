module PresentExtensions
  module ArrayMethods
    def present?
      self.length > 0
    end

    def blank?
      self.empty?
    end
  end
end

class NilClass
  def present?; false; end
  def empty?;   true;  end
end

class Array
  include PresentExtensions::ArrayMethods
end

class Hash
  include PresentExtensions::ArrayMethods
end

class NSString
  include PresentExtensions::ArrayMethods
end

class NSObject
  def presence
    self.present? ? self : nil
  end
end
