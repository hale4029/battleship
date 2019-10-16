require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/computer_board'

class ComputerBoardTest < Minitest::Test

  def setup
    @computer = ComputerBoard.new
    @computer.computer_board.create_cells
  end

  def test_it_exists
    assert_instance_of ComputerBoard, @computer
  end

  def test_placement_of_ships
    @computer.place_ships
    print @computer.computer_board.render(true)

  end

end
