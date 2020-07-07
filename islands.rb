# frozen_string_literal: true

#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#
# https://leetcode.com/problems/number-of-islands/
#
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

require 'awesome_print'

# @param {Character[][]} grid
# @return {Integer}
def num_islands(grid)
  return 0 if empty_grid?(grid)

  len = grid.first.length
  hei = grid.length

  control = control_grid(len, hei)

  res = 0

  grid.each_with_index do |row, y|
    row.each_with_index do |_col, x|
      next unless safe(x, y, len, hei, grid, control)

      visit_nodes(x, y, len, hei, grid, control)
      res += 1
    end
  end

  res
end

def visit_nodes(x, y, len, hei, grid, control)
  control[y][x] = true

  moves_x = [-1, 1]
  moves_y = [-1, 1]
  stack = []

  moves_x.each do |mov|
    stack.push([x + mov, y]) if safe(x + mov, y, len, hei, grid, control)
  end

  moves_y.each do |mov|
    stack.push([x, y + mov]) if safe(x, y + mov, len, hei, grid, control)
  end

  stack.each do |point|
    visit_nodes(point.first, point.last, len, hei, grid, control)
  end
end

def control_grid(length, height)
  Array.new(height) { Array.new(length) { false } }
end

def empty_grid?(grid)
  grid.empty? || grid.first.empty?
end

def safe(x, y, len, hei, grid, ctrl)
  return false unless x >= 0 && x < len && y >= 0 && y < hei

  return false unless grid[y][x] == '1' && ctrl[y][x] == false

  true
end

def print_grid(grid)
  grid.each do |row|
    puts row.to_s
  end
end

#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#
# Program
#
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

tests = [
  [],

  [%w[]],

  [%w[1 1 1 1 0],
   %w[1 1 0 1 0],
   %w[1 1 0 0 0],
   %w[0 0 0 0 0]],

  [%w[1 1 0 0 0],
   %w[1 1 0 0 0],
   %w[0 0 1 0 0],
   %w[0 0 0 1 1]]

]

tests.each { |test| ap num_islands(test).to_s }

#   00 01 02 03 04    05 06 07 08 09    10 11 12 13 14    15 16 17 18 19
#   00 01 02 03 04    00 01 02 03 04    00 01 02 03 04    00 01 02 03 04
#  | a  b  c  d  e  |  f  g  h  i  j  |  k  l  m  n  o  |  p  q  r  s  t
# a| 0  1  0  0  0  |  1  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0
# b| 1  0  1  0  0  |  0  1  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0
# c| 0  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0
# d| 0  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0
# e| 0  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0
# -|                |                 |                 |
# f| 1  0  0  0  0  |  0  1  0  0  0  |  1  0  0  0  0  |  0  0  0  0  0
# g| 0  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0
# h| 0  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0
# i| 0  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0
# j| 0  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0
# -|                |                 |                 |
# k| 0  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0
# l| 0  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0
# m| 0  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0
# n| 0  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0
# o| 0  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0
# -|                |                 |                 |
# p| 0  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0
# q| 0  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0
# r| 0  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0
# s| 0  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0
# t| 0  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0  |  0  0  0  0  0

#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

# # @param {Character[][]} grid
# # @return {Integer}
# def dfs(grid, i, j, height, width)
#   return 0 if i < 0 || i >= height || j < 0 || j >= width
#   return 0 if grid[i][j] == "0"

#   grid[i][j] = "0"
#   dfs(grid, i + 1, j, height, width)
#   dfs(grid, i - 1, j, height, width)
#   dfs(grid, i, j + 1, height, width)
#   dfs(grid, i, j - 1, height, width)
#   return 1
# end

# def num_islands(grid)
#   return 0 if grid.nil? || grid.length == 0

#   height = grid.length
#   width = grid[0].length

#   num_islands = 0

#   i = 0

#   while i < height
#     j = 0
#     while j < width
#       if grid[i][j] == "1"
#         num_islands += dfs(grid, i, j, height, width)
#       end
#       j += 1
#     end
#     i += 1
#   end

#   return num_islands

# end

#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

# # @param {Character[][]} grid
# # @return {Integer}
# def num_islands(grid)
#     $matrix = grid
#     count = 0
#     grid.each_with_index do |row, level|
#         row.each_with_index  do |element, column|

#             count += dp(level, column)

#         end
#     end
#     count
# end

# def dp(level, column)

#    return 0 if level < 0 or column < 0 or level >= $matrix.length or column >= $matrix[level].length
#    return 0 if  $matrix[level][column] == "0"

#     $matrix[level][column] = "0"

#     #go down
#     dp(level + 1, column)
#    #go left
#     dp(level, column - 1)
#    #go right
#     dp(level, column + 1)
#    #go up
#     dp(level - 1, column)

#     return 1
# end

#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

# # @param {Character[][]} grid
# # @return {Integer}
# def num_islands(grid)
#   islands_count = 0
#   i = 0
#   # iterate over rows
#   while i < grid.length
#     # iterate each column in that row
#     j = 0
#     while j < grid[0].length
#       # found land
#       if grid[i][j] == "1"
#         # increment islands count
#         islands_count += 1
#         mark_island(i, j, grid)
#       end
#       j += 1
#     end
#     i += 1
#   end

#   islands_count
# end

# def mark_island(i, j, grid)
#   # dps to mark island as water
#   return if i < 0 || i > grid.length - 1
#   return if j < 0 || j > grid[0].length - 1
#   return if grid[i][j] == "0"

#   # mark current land as water
#   grid[i][j] = "0"
#   # dps
#   mark_island(i + 1, j, grid)
#   mark_island(i - 1, j, grid)
#   mark_island(i, j - 1, grid)
#   mark_island(i, j + 1, grid)
# end
