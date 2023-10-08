class UInt24
  @value : UInt32

  def initialize(@value : UInt32)
    raise ArgumentError.new("Value out of range for UInt24") if @value > 0xFFFFFF_u32
  end

  def self.from(value : UInt32)
    new(value)
  end

  def to_u32
    @value
  end

  def +(other : self)
    self.class.from(to_u32 + other.to_u32)
  end

  def -(other : self)
    self.class.from(to_u32 - other.to_u32)
  end

  # Define other operations as needed...
end
