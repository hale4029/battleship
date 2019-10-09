require './lib/cell'
require './lib/ship'

class Board
  attr_reader :cells

  def initialize
    @spaces = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    @cells = {}
    @spaces.each do |space|
      @cells[space] = Cell.new(space)
    end
    @cells
  end

  def valid_coordinate?(coord)
    @spaces.include?(coord.to_s.upcase) #if we need to revisit, change to hash potentially
  end

  def valid_columns(ship_name, coordinates_array)
    test_array = coordinates_array.map do |x|
      x.delete("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    end
    if test_array.uniq.size == 1 #checks if numerical portion of cell is same
      true
    elsif # if not, are the numbers consecutive
      test = test_array.pop.to_i
      test_1 = test_array.pop.to_i
      if test_array.empty?
        test - 1 == test_1
      else
        test_2 = test_array.pop.to_i
        test - 1 == test_1 && test_1 - 1 == test_2
      end
    end
  end

  def valid_rows(ship_name, coordinates_array)
    test_array = coordinates_array.map do |x|
      x.delete("1234567890")
    end
    ordinals_array = test_array.map do |letter|
      letter.ord
    end
    if ordinals_array.uniq.size == 1
      true
    elsif
      test = ordinals_array.pop.to_i
      test_1 = ordinals_array.pop.to_i
      if ordinals_array.empty?
        test - 1 == test_1
      else
        test_2 = ordinals_array.pop.to_i
        test - 1 == test_1 && test_1 - 1 == test_2
      end
    end
  end

  def valid_placement?(ship_name, coordinates_array)
    valid_rows(ship_name, coordinates_array) && valid_columns(ship_name, coordinates_array) && coordinates_array.length == ship_name.length
  end
end
