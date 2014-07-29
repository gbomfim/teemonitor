class Tee
  attr_accessor :data
  def initialize()
    @data = Hash.new
  end 
  public
  def setData(key,value)
    @data[key] = value
  end
end

