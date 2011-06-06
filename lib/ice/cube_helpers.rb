class Object
  def to_ice
    nil
  end
end

[FalseClass, TrueClass, Numeric, String].each do |cls|
  cls.class_eval do
    def to_ice
      self
    end
  end
end

class Array
  def to_ice
    map &:to_ice
  end
end

class Hash
  def to_ice
    res = {}
    each_pair do |key,value|
      res[key] = value.to_ice
    end
    res
  end
end