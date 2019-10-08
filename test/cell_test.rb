require 'minitest/autorun'
require 'minitest/pride'

class CellTest < Minitest::Test

  def setup
    cell = Cell.new("B4")
  end

  def test_it_exists
    assert_instance_of Cell, cell
  end

  def def_it_has_a_coordinate
    assert_equal "B4", cell.coordinate
  end

  def
