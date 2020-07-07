# frozen_string_literal: true

#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#
# https://leetcode.com/problems/number-of-islands/
#
# Ruby: 60ms (96.03%), 13.5MB (53.11%)
#
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

require 'colorize'

# @param {Character[][]} grid
# @return {Integer}
def num_islands(grid)
  return 0 if empty_grid?(grid)

  res = 0
  hei = grid.length
  len = grid.first.length

  grid.each_with_index do |row, y|
    row.each_with_index do |col, x|
      next unless col == '1'

      check_land(x, y, grid, len, hei)
      res += 1
    end
  end

  res
end

def check_land(x, y, grid, len, hei)
  return false if x < 0 || y < 0 || x >= len || y >= hei || grid[y][x] != '1'

  grid[y][x] = '0'

  return true if
    check_land(x - 1, y, grid, len, hei) ||
    check_land(x, y - 1, grid, len, hei) ||
    check_land(x + 1, y, grid, len, hei) ||
    check_land(x, y + 1, grid, len, hei)

  false
end

def empty_grid?(grid)
  grid.empty? || grid.map(&:length).sum.zero?
end

#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#
# Program
#
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

def print_grid(grid)
  puts = '[<empty>]'.yellow if empty_grid?(grid)

  grid.each { |row| puts row.to_s.yellow }

  puts ('-' * 43).to_s.yellow
end

test = []
print_grid(test)
puts "number of islands: #{num_islands(test)}".magenta
puts('-' * 43).to_s.white

#
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#

test = [[]]
print_grid(test)
puts "number of islands: #{num_islands(test)}".magenta
puts('-' * 43).to_s.white

#
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#

test = [
  %w[1 1 1 1 0],
  %w[1 1 0 1 0],
  %w[1 1 0 0 0],
  %w[0 0 0 0 0]
]
print_grid(test)
puts "number of islands: #{num_islands(test)}".magenta
puts('-' * 43).to_s.white

#
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#

test = [
  %w[1 1 0 0 0],
  %w[1 1 0 0 0],
  %w[0 0 1 0 0],
  %w[0 0 0 1 1]
]
print_grid(test)
puts "number of islands: #{num_islands(test)}".magenta

puts('-' * 43).to_s.white

#
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

# RSpec is another very popular library for testing in Ruby. You trigger RSpec in CoderPad by requiring rspec/autorun. The equivalent of the previous example in RSpec would be:
#   require 'rspec/autorun'

#   class Dog
#     def talk!
#       'BARK'
#     end
#   end

#   RSpec.describe Dog do
#     it 'barks when spoken to' do
#       expect(Dog.new.talk!).to eq('BARK')
#     end
#   end
# algorithms is a gem with some useful data structure implementations.

# ActiveSupport extends the Ruby language with a lot of useful features built up by the Rails team over the years.

# - Why is it coded in C++
