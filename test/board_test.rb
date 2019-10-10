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

  def test_if_letters_are_consecutive_or_same
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal true, @board.valid_letters(cruiser, ["A3", "A4"])
    assert_equal true, @board.valid_letters(submarine, ["A2", "B3", "C4"])
    assert_equal false, @board.valid_letters(cruiser, ["A2", "B3", "A4"])
    assert_equal false, @board.valid_letters(cruiser, ["A2", "B3", "D4"])
    assert_equal false, @board.valid_letters(submarine, [])
    assert_equal true, @board.valid_letters(submarine, ["E5", "F17"])
    assert_equal true, @board.valid_letters(cruiser, ["B2", "C2", "D2"])
    assert_equal false, @board.valid_letters(cruiser, ["B2", "C2", "D2", "D2", "A4"])
  end

  def test_if_numbers_are_consecutive_or_same
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal true, @board.valid_numbers(cruiser, ["A3", "A4"])
    assert_equal true, @board.valid_numbers(submarine, ["A2", "B3", "C4"])
    assert_equal true, @board.valid_numbers(cruiser, ["A2", "B3", "A4"])
    assert_equal true, @board.valid_numbers(cruiser, ["A2", "B3", "D4"])
    assert_equal false, @board.valid_numbers(submarine, [])
    assert_equal false, @board.valid_numbers(submarine, ["E5", "F17"])
    assert_equal true, @board.valid_numbers(cruiser, ["B2", "C2", "D2"])
    assert_equal false, @board.valid_numbers(cruiser, ["B2", "C2", "D2", "D2", "A4"])
  end

  def test_valid_placement
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, @board.valid_placement?(cruiser, ["A3", "A4"])
    assert_equal false, @board.valid_placement?(submarine, ["A2", "B3", "C4"])
    assert_equal false, @board.valid_placement?(cruiser, ["A2", "B3", "A4"])
    assert_equal false, @board.valid_placement?(cruiser, ["A2", "B3", "D4"])
    assert_equal false, @board.valid_placement?(submarine, [])
    assert_equal false, @board.valid_placement?(submarine, ["E5", "F17"])
    assert_equal true, @board.valid_placement?(cruiser, ["B2", "C2", "D2"])
    assert_equal true, @board.valid_placement?(submarine, ["B2", "B3"])
    assert_equal false, @board.valid_placement?(cruiser, ["B2", "C2", "D2", "D2", "A4"])
    assert_equal false, @board.valid_placement?(cruiser, ["A1", "A1", "A1"])
    assert_equal false, @board.valid_placement?(cruiser, ["C2", "C2", "C3"])
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

    #sad path -- cells aready hold a ship
    submarine = Ship.new("Submarine", 2)
    actual = @board.place(submarine, ["A1", "A2"])

    assert_equal "Cruiser", @board.cells["A1"].ship.name
    assert_nil nil, actual
  end

  def test_board_renders_for_computer
    cruiser = Ship.new("Cruiser", 3)
    @board.place(cruiser, ["A1", "A2", "A3"])

    assert_equal "  1 2 3 4 \n" +
    "A . . . . \n" +
    "B . . . . \n" +
    "C . . . . \n" +
    "D . . . . \n" +, @board.render
  end

  def test_board_renders_for_player
    cruiser = Ship.new("Cruiser", 3)
    @board.place(cruiser, ["A1", "A2", "A3"])

    assert_equal "  1 2 3 4 \n" +
    "A S S S . \n" +
    "B . . . . \n" +
    "C . . . . \n" +
    "D . . . . \n" +, @board.render(true)
  end
end
