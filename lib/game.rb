require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/computer_board'

class Game
  attr_reader :board,
              :input,
              :player_cruiser,
              :player_sub,
              :computer


  def main_menu
    puts "Welcome to BATTLESHIP"
    puts "To start a new game, enter 'p'. To quit game, enter 'q'."
    print ">"
    input = gets.chomp.downcase
    if input == "p"
      start_game
    elsif input == "q"
      puts "Ok, goodbye."
    else
      puts "Invalid menu input."
      main_menu
    end
  end

  def player_place_ship(ship)
    placement = gets.chomp.gsub(/\s+/, "").upcase.scan(/../)
    if @player_board.place(ship, placement) == nil
      puts "Invalid coordinates. Reminder: a #{ship.name} must be placed using #{ship.length} valid coordinates."
      print ">"
      player_place_ship(ship)
    else
      @player_board.place(ship, placement)
    end
  end

  def place_cruiser
    @player_cruiser = Ship.new("Cruiser", 3)
    puts "Enter the spaces for the cruiser (ex: A1 A2 A3)"
    print ">"
    player_place_ship(@player_cruiser)
  end

  def place_submarine
    @player_sub = Ship.new("Submarine", 2)
    puts "Enter the spaces for the submarine (ex: C1 D1)"
    print ">"
    player_place_ship(@player_sub)
  end

  def show_boards
    puts "Computer's Board"
    print @computer.computer_board.render
    puts "=========="
    puts "Your Board"
    print @player_board.render(true)
  end

  def start_game
      @computer = ComputerBoard.new
      @computer.place_cruiser
      @computer.place_submarine
      @computer_available_shots = @computer.computer_board.cells.keys
      @player_board = Board.new
      show_boards
      puts "You will need to lay out your ships on the board"
      puts "The cruiser is 3 units long and the submarine is 2 units long."
      place_cruiser
      show_boards
      place_submarine
  end

  def computer_shot
    @comp_shot = @computer_available_shots.sample
    @computer_available_shots.delete(@comp_shot)
    @player_board.cells[@comp_shot].fire_upon
  end

  def get_shot_input_from_user
    @shot_coordinate = gets.chomp.gsub(/\s+/, "").upcase
  end

  def take_turn
    show_boards
    puts "What coordinate would you like to fire on?"
    print ">"
    get_shot_input_from_user
    shot_coordinate_validation(@shot_coordinate)
    computer_shot
    shot_feedback(@computer.computer_board, @shot_coordinate, "Your")
    shot_feedback(@player_board, @comp_shot, "The computer's")
  end

  def shot_feedback(board, shot_coordinate, player)
    if board.cells[shot_coordinate].render == "M"
      shot = "miss"
    elsif board.cells[shot_coordinate].render == "H"
      shot = "hit"
    elsif board.cells[shot_coordinate].render == "X"
      puts "#{player} shot on #{shot_coordinate} sunk the #{board.cells[shot_coordinate].ship.name}."
      return
    end
    puts "#{player} shot on #{shot_coordinate} was a #{shot}."
  end

  def shot_coordinate_validation(shot)
    if @computer.computer_board.cells.keys.include?(shot) == true && @computer.computer_board.cells[shot].fired_upon? == false
      @computer.computer_board.cells[shot].fire_upon
    else
      puts "Please input a valid coordinate."
      print ">"
      get_shot_input_from_user
      shot_coordinate_validation(@shot_coordinate)
    end
  end

  def game_end
    if @computer.submarine.health + @computer.cruiser.health == 0
      puts "~~~~You won!~~~~"
    elsif @player_sub.health + @player_cruiser.health == 0
      puts ":( :( :( The computer wins. :( :( :("
    end
    puts "Returning to main menu..."
    main_menu
  end
end
