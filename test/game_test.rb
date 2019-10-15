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
    require "pry"; binding.pry
  end

  def test_game_exists
    assert_instance_of Game, @game
  end

  def test_game_initializes_with_menu
    assert_equal "Welcome to BATTLESHIP", @game.main_menu
  end

  def test_game_asks_user_to_place_ships_if_they_enter_p_on_main_menu
    
  end
end
