#require './lib/ship'

class Cell
  attr_accessor :coordinate, :cell_state, :ship_instance

  def initialize(coordinate)
    @coordinate = coordinate
    @cell_state = "."
    @ship_instance = nil
  end

  def place_ship(ship_name)
    @cell_state = "S"
    @ship_instance = ship_name
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

  def fire_upon
    if @cell_state == "."
      @cell_state = "M"
    elsif @cell_state == "S"
      @cell_state = "H"
      @ship_instance.hit
    elsif @ship_instance.sunk == true
      @cell_state = "X"
    else @cell_state == "H" || "M"
      "Cell already hit."
    end
  end

  def fired_upon?
    if @cell_state != "."
      true
    else
      false
    end
  end

  def render(player = true)
    if player == true
      @cell_state
    elsif player == false && @cell_state == "S"
      "."
    else
      @cell_state
    end
  end

end
