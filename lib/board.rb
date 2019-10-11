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

  def duplicate_entry(ship_name, coordinates_array)
    coordinates_array.uniq.size == coordinates_array.length
  end

  def valid_numbers(ship_name, coordinates_array)
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

  def valid_letters(ship_name, coordinates_array)
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

  def diagonal?(ship_name, coordinates_array)
    test_array = coordinates_array.map do |x|
      x.delete("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    end
    test = test_array.pop.to_i
    test_1 = test_array.pop.to_i
    if test_array.empty?
      numbers = test - 1 == test_1
    else
      test_2 = test_array.pop.to_i
      numbers = test - 1 == test_1 && test_1 - 1 == test_2
    end

    letters_array = coordinates_array.map do |x|
      x.delete("1234567890")
    end
    ordinals_array = letters_array.map do |letter|
      letter.ord
    end
    test = ordinals_array.pop.to_i
    test_1 = ordinals_array.pop.to_i
    if ordinals_array.empty?
      letters = test - 1 == test_1
    else
      test_2 = ordinals_array.pop.to_i
      letters = test - 1 == test_1 && test_1 - 1 == test_2
    end
    !(letters && numbers)
  end

  def valid_placement?(ship_name, coordinates_array)
    valid_letters(ship_name, coordinates_array) &&
    valid_numbers(ship_name, coordinates_array) &&
    coordinates_array.length == ship_name.length &&
    diagonal?(ship_name, coordinates_array) &&
    duplicate_entry(ship_name, coordinates_array)
  end

  def ship_does_not_exist_on_cell(coordinates_array)
    array = coordinates_array.find_all do |coord|
      @cells[coord].ship != nil
    end
    if array.empty?
      true
    else
      false
    end
  end

  def place(ship_name, coordinates_array)
    if (valid_placement?(ship_name, coordinates_array) == true) && ship_does_not_exist_on_cell(coordinates_array) == true
      coordinates_array.each do |coord|
        @cells[coord].place_ship(ship_name)
      end
    else
      nil
    end
  end

 def render(player = false)
   if player == false
     render_array = @cells.values.map do |cell|
       cell.render + " "
    end
    x = ["1 ", "2 ", "3 ", "4 "]
    flat_array = render_array.unshift(x).flatten
    array_2 = flat_array.each_slice(4).to_a.map { |slice| slice << "\n"}
    array = [["  "], ["A "], ["B "], ["C "], ["D "]]
    output = array.map { |slice| slice << array_2.shift }.flatten.join
    output
   else
     render_array = @cells.values.map do |cell|
       cell.render(true) + " "
    end
    x = ["1 ", "2 ", "3 ", "4 "]
    flat_array = render_array.unshift(x).flatten
    array_2 = flat_array.each_slice(4).to_a.map { |slice| slice << "\n"}
    array = [["  "], ["A "], ["B "], ["C "], ["D "]]
    output = array.map { |slice| slice << array_2.shift }.flatten.join
    output
   end
 end

end
