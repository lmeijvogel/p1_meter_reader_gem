def kWh(value)
  if value.is_a? Kwh
    value
  else
    Kwh.new(Float(value))
  end
end

class Kwh
  def initialize(value)
    self.value = value
  end

  def ==(other)
    if other.is_a?(Kwh)
      return (self - other).value.abs < 0.001
    end

    false
  end

  def -(other)
    kWh(self.value - other.value)
  end

  def inspect
    "#{value}kWh"
  end

  def to_s
    inspect
  end

  def to_f
    value
  end

  protected
  attr_accessor :value
end
