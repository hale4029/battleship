require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require './lib/board'

class BoardTest < Minitest::Test

  def setup
    @board = Board.new
  end

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_board_has_16_cells
    assert_equal 16, @board.cells.length
    assert_instance_of Cell, @board.cells["A1"]
    assert_instance_of Hash, @board.cells
  end

  def test_if_coordinate_is_valid
    assert_equal true, @board.valid_coordinate?("A1")
    assert_equal false, @board.valid_coordinate?("D5")
    assert_equal false, @board.valid_coordinate?("A 1")
    assert_equal false, @board.valid_coordinate?("A22")
    assert_equal false, @board.valid_coordinate?(1)
  end

  def test_if_row_placement_is_valid
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal true, @board.valid_rows(cruiser, ["A3", "A4"])
    assert_equal true, @board.valid_rows(submarine, ["A2", "B3", "C4"])
    assert_equal false, @board.valid_rows(submarine, ["A2", "B3", "A4"])
    assert_equal false, @board.valid_rows(submarine, ["A2", "B3", "D4"])
  end

  def test_if_ship_placement_is_valid
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, @board.valid_placement?(cruiser, ["A3", "A4"])
    assert_equal false, @board.valid_placement?(submarine, ["A2", "A3", "A4"])
    assert_equal true, @board.valid_placement?(cruiser, ["A1", "A2","A3"])
    assert_equal true, @board.valid_placement?(submarine, ["A2", "A3"])
    assert_equal true, @board.valid_placement?(cruiser, ["A1", "B1", "C1"])
    assert_equal false, @board.valid_placement?(cruiser, ["A1", "B2", "C1"])
    assert_equal false, @board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    assert_equal true, @board.valid_placement?(submarine, ["A2", "B2"])
    assert_equal true, @board.valid_placement?(cruiser, ["B2", "C2", "D2"])
  end

  def test_placement_of_ship
    cruiser = Ship.new("Cruiser", 3)
    @board.place(cruiser, ["A1", "A2", "A3"])
    cell_1 = @board.cells["A1"]
    cell_2 = @board.cells["A2"]
    cell_3 = @board.cells["A3"]

    #happy path
    assert_equal cell_1.ship, @board.cells["A1"].ship
    assert_equal cell_1.ship, @board.cells["A2"].ship
    assert_equal cell_1.ship, @board.cells["A3"].ship

    #sad path w/ invalid placement
    cruiser = Ship.new("Cruiser", 3)
    actual = @board.place(cruiser, ["B1", "B3", "B4"])

    assert_nil nil, actual
    assert_nil nil, @board.cells["B1"].ship

    #
    submarine = Ship.new("Submarine", 2)
    actual = @board.place(submarine, ["A1", "A2"])

    assert_equal "Cruiser", @board.cells["A1"].ship.name
    assert_nil nil, actual


  end

end
