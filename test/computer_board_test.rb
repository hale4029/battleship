require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/computer'

class ComputerBoardTest < Minitest::Test

  def setup
    @computer = ComputerBoard.new
  end

  def test_it_exists
    assert_instance_of ComputerBoard, @computer
  end

  def test_placement_of_ships
    @computer.place_cruiser

    print @computer.computer_board.cells.values.include?(ship)
    # print @computer.computer_board.render
    # print @computer.computer_board.render(true)

    #@computer.place_submarine

    #assert_equal
  end

end
