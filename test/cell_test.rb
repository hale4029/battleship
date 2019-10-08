require 'minitest/autorun'
require 'minitest/pride'

class CellTest < Minitest::Test

  def setup
    cell = Cell.new("B4")
  end

  def test_it_exists
    assert_instance_of Cell, cell
  end

  def test_it_has_a_coordinate
    assert_equal "B4", cell.coordinate
  end

  def test_cell_is_empty
    assert_equal nil, cell.ship
    assert_equal true, cell.empty?
  end

  def test_a_ship_can_be_placed_on_cell
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

    assert_equal cruiser, cell.ship
    assert_equal false, cell.empty?
  end
