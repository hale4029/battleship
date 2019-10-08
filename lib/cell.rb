class Cell
  attr_reader :coordinate

  attr_accessor :ship,
                :fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    # @empty = true # may not need this (if ship = nil, empty is implied, if ship = nil && fired_upon = true, render should be "M")
    @fired_upon = false
  end

  def empty?
    if @ship == nil
      true
    else
      false
    end
  end

  def place_ship(ship_name)
    @ship = ship_name
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    if @ship != nil
    @ship.health -= 1
    end
    @fired_upon = true
  end

  def render(player = false)
    if player == true && @ship != nil && @fired_upon == false
        "S"
    elsif @ship == nil && @fired_upon == false
        "."
    elsif @ship == nil && @fired_upon == true
        "M"
    elsif @ship != nil && @fired_upon == true && @ship.health <= 0
        "X"
    elsif @ship != nil && @fired_upon == true
        "H"
    else
      "."
    end
  end
end
