require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/computer_board'

class ComputerBoardTest < Minitest::Test

  def setup
    @computer = ComputerBoard.new
  end

  def test_it_exists
    assert_instance_of ComputerBoard, @computer
  end

  def test_board_default_and_dynamic_function
    assert_equal 16, @computer.computer_board.cells.length
    assert_instance_of Cell, @computer.computer_board.cells["A1"]
    assert_nil nil, @computer.computer_board.cells["A10"]
    assert_instance_of Hash, @computer.computer_board.cells

    computer_2 = ComputerBoard.new(10)
    assert_equal 100, computer_2.computer_board.cells.length
    assert_instance_of Cell, computer_2.computer_board.cells["A10"]
    assert_nil nil, computer_2.computer_board.cells["A100"]
    assert_instance_of Hash, computer_2.computer_board.cells
  end

end
