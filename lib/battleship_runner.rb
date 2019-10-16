require './lib/game'
require './lib/board'
require './lib/cell'
require './lib/ship'


game = Game.new

loop do
game.main_menu
until (game.player_cruiser.health + game.player_sub.health == 0) || (game.computer.cruiser.health + game.computer.submarine.health == 0)
game.take_turn
end
game.show_boards
game.game_end
end
