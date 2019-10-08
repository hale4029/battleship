

class Ship
  attr_reader :name, :length
  attr_accessor :sunk, :health

  def initialize(name, length)
    @name = name
    @length = length
    @health = length
    @sunk = false
  end

  def hit
    @health -= 1
  end

  def sunk
    if @health == 0
      @sunk = true
    else
      @sunk
    end
  end

end
