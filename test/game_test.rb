require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/game'

class GameTest < Minitest::Test

  def setup
    @board = Board.new
    @game = Game.new
  end

  def test_game_exists
    assert_instance_of Game, @game
  end

  def test_game_initializes_with_menu

  end

  def user_can_place_ship

  end
end
