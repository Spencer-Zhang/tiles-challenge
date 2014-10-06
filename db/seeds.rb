# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Tile.collection.drop

Tile.create(name: "**error**!") # Raises an error if clicked on

bandnames = []

File.open('db/bandnames.txt') do |f|
  f.lines.each { |line| bandnames << line.strip }
end

bandnames.shuffle!

63.times do
  Tile.create(name: bandnames.pop)
end