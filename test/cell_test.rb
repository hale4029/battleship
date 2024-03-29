require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'

class CellTest < Minitest::Test

  def setup
    @cell = Cell.new("B4")
  end

  def test_it_exists
    assert_instance_of Cell, @cell
  end

  def test_it_has_a_coordinate
    assert_equal "B4", @cell.coordinate
  end

  def test_cell_is_empty_until_ship_is_placed_on_it
    assert_equal nil, @cell.ship
    assert_equal true, @cell.empty?

    cruiser = Ship.new("Cruiser", 3)
    @cell.place_ship(cruiser)

    assert_equal cruiser, @cell.ship
    assert_equal false, @cell.empty?
  end

  def test_cell_can_be_fired_upon
    cruiser = Ship.new("Cruiser", 3)
    @cell.place_ship(cruiser)

    assert_equal false, @cell.fired_upon?

    @cell.fire_upon

    assert_equal 2, @cell.ship.health
    assert_equal true, @cell.fired_upon?
  end

  def test_render_is_dynamic_for_miss
    assert_equal ".", @cell.render

    @cell.fire_upon

    assert_equal "M", @cell.render
  end

  def test_render_is_dynamic_for_ship_placement_and_hit
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)

    assert_equal ".", cell_2.render

    cell_2.place_ship(cruiser)
    assert_equal "S", cell_2.render(true)

    cell_2.fire_upon

    assert_equal "H", cell_2.render
  end

  def test_render_is_dynamic_for_sunken_ship
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)
    cell_2.fire_upon
    cruiser.hit

    assert_equal "H", cell_2.render

    cruiser.hit

    assert_equal "X", cell_2.render

  end
end
