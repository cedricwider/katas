
class Cell
  
  attr_accessor :x, :y
  
  def initialize(_x=0, _y=0, x: _x, y: _y)
    @x=x
    @y=y
    @alive=true
  end
  
  def alive?
    @alive
  end
  
  def alive=(val)
    @alive=val
  end
  
end