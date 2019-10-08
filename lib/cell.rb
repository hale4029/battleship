#require './lib/ship'

class Cell
  attr_accessor :coordinate, :cell_state, ship_instance

  def initialize(coordinate)
    @coordinate = coordinate
    @cell_state = "."
    @ship_instance = nil
  end

  def place_ship(ship_instance)
    @ship_instance = ship_instance
    @cell_state = "S"
  end

  def ship
    @ship_instance
  end

  def empty?
    if @cell_state == "."
      true
    else
      false
    end
  end

  def fired_upon
    if @cell_state == "."
      @cell_state = "M"
    elsif @ship_instance.sunk == true
      @cell_state = "X"
    else
      @cell_state = "H"
    end
  end

  def fired_upon?
    if @cell_state != "."
      true
    else
      false
    end
  end

  def render
    @cell_state
  end

end
