require './lib/cell'
require './lib/ship'

ship_1 = Ship.new("Cruiser", 3)
cell_1 = Cell.new("A1")

puts cell_1.render
pp cell_1.ship
puts ship_1.health
puts cell_1.empty?
puts cell_1.fired_upon?
pp cell_1.place_ship(ship_1)
puts cell_1.render
puts cell_1.empty?
cell_1.fired_upon
puts cell_1.fired_upon?
puts cell_1.render
puts ship_1.health
ship_1.hit
puts ship_1.health
puts ship_1.sunk
ship_1.hit
puts ship_1.health
puts ship_1.sunk

cell_1.fired_upon
puts cell_1.render
cell_1.fired_upon
puts cell_1.render
