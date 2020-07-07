# frozen_string_literal: true

#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#
# https://leetcode.com/problems/range-sum-query-2d-immutable/
#
#
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

require 'colorize'

class NumMatrix
  #     :type matrix: Integer[][]

  def initialize(matrix)
    return if matrix.empty? || matrix.first.empty?

    @matrix = matrix
    @mem_matrix = fill_mem_matrix(@matrix)
  end

  def mem_matrix(matrix)
    Array.new(matrix.length) { Array.new(matrix.first.length) { nil } }
  end

  def fill_mem_matrix(matrix)
    @mem_matrix = mem_matrix(matrix)

    matrix.each_with_index do |row, y|
      row.each_with_index do |_col, x|
        sum_x = x - 1 >= 0 ? @mem_matrix[y][x - 1] : 0
        sum_y = y - 1 >= 0 ? @mem_matrix[y - 1][x] : 0
        sum_xy = y - 1 >= 0 && x - 1 >= 0 ? @mem_matrix[y - 1][x - 1] : 0

        @mem_matrix[y][x] = @matrix[y][x] + sum_x + sum_y - sum_xy
      end
    end

    # print_matrix(@mem_matrix)
    @mem_matrix
  end

  #     :type row1: Integer
  #     :type col1: Integer
  #     :type row2: Integer
  #     :type col2: Integer
  #     :rtype: Integer
  def sum_region(row1, col1, row2, col2)
    # puts "sum_region for (#{row1}, #{col1}) -> (#{row2}, #{col2})".light_magenta

    return unless is_safe?(row1, col1, row2, col2)

    sum_row = row1 - 1 >= 0 ? @mem_matrix[row1 - 1][col2] : 0
    sum_col = col1 - 1 >= 0 ? @mem_matrix[row2][col1 - 1] : 0
    sum_xy = row1 - 1 >= 0 && col1 - 1 >= 0 ? @mem_matrix[row1 - 1][col1 - 1] : 0

    @mem_matrix[row2][col2] - sum_row - sum_col + sum_xy
  end
end

def is_safe?(row1, col1, row2, col2)
  return false if (row1 > row2) || (col1 > col2)

  return false if row1 < 0 || col1 < 0 || row2 < 0 || col2 < 0

  height = @matrix.length
  length = @matrix.first.length

  return false if row1 >= height || col1 >= length || row2 >= height || col2 >= length

  true
end

# Your NumMatrix object will be instantiated and called as such:
# obj = NumMatrix.new(matrix)
# param_1 = obj.sum_region(row1, col1, row2, col2)

#-==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#
# Program
#
#-==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

def print_matrix(matrix)
  puts separator = '-' * matrix.first.length * 6 + '--'

  matrix.each do |row|
    line = ''
    row.each do |col|
      line += col.to_s.rjust(3).ljust(6)
    end
    puts "|#{line}|".yellow
  end

  puts separator
end

def run_tests(matrix, tests)
  print_matrix(matrix)

  obj = NumMatrix.new(matrix)

  tests.each do |test|
    sum = obj.sum_region(test[0], test[1], test[2], test[3])
    res = sum == test.last ? 'PASS'.green : 'FAIL'.red

    str = "- #{test.to_s.light_yellow} = #{sum.to_s.light_blue} ".ljust(80, '.')

    puts str += " [#{res}]"
  end
end

#
#-==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#

matrix = [
  [3, 0, 1, 4, 2],
  [5, 6, 3, 2, 1],
  [1, 2, 0, 1, 5],
  [4, 1, 0, 1, 7],
  [1, 0, 3, 0, 5]
]

tests = [
  [2, 1, 4, 3, 8],
  [1, 1, 2, 2, 11],
  [1, 2, 2, 4, 12]
]

run_tests(matrix, tests)

# sumRegion(2, 1, 4, 3) -> 8
# sumRegion(1, 1, 2, 2) -> 11
# sumRegion(1, 2, 2, 4) -> 12

#
#-==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#

# mem_list_sol = [
#   [1,  3,  3,  3, 4],
#   [1,  6,  7, 10, 13],
#   [3,  8, 11, 16, 22],
#   [4, 11, 17, 23, 33]
# ]

matrix = [
  [1, 2, 0, 0, 1],
  [0, 3, 1, 3, 2],
  [2, 0, 2, 2, 3],
  [1, 2, 3, 1, 4]
]

tests = [
  [1, 1, 2, 2, 6],
  [2, 3, 3, 4, 10],
  [1, 1, 2, 3, 11],
  [1, 0, 2, 2, 8],

  [0, 0, 1, 1, 6],
  [0, 0, 2, 2, 11]

]

run_tests(matrix, tests)

# puts box_sum(1, 1, 2, 3) # -> 11

#-==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#-==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

# matrix = [
#   [1, 2, 0, 0, 1],
#   [0, 3, 1, 3, 2],
#   [2, 0, 2, 2, 3],
#   [1, 2, 3, 1, 4]
# ]

# n = nil

# mem_list_sol = [
#   [1, 3, 3, 3, 4],
#   [n, n, n, n, n],
#   [n, n, n, n, n],
#   [n, n, n, n, n]
# ]

# mem_list_sol = [
#   [1,  3,  3,  3, 4],
#   [1,  6,  7, 10, 13],
#   [3,  8, 11, 16, 22],
#   [4, 11, 17, 23, 33]
# ]

# def build_mem_list(matrix)
#   mem_list = mem_array(matrix)

#   matrix.each_with_index do |row, y|
#     row.each_with_index do |_col, x|
#       box_sum_mem(0, 0, y, x, matrix, mem_list)
#     end
#   end

#   mem_list
# end

# def mem_array(matrix)
#   Array.new(matrix.length) { Array.new(matrix.first.length) { nil } }
# end

# def box_sum_mem(_row0, _col0, row1, col1, matrix, mem_list)
#   # puts "Calculating..[#{row0}][#{col0}], [#{row1}][#{col1}]".light_magenta

#   return mem_list[0][0] = matrix[0][0] if row1 == 0 && col1 == 0

#   sum_x = col1 > 0 ? mem_list[row1][col1 - 1] : 0
#   sum_y = row1 > 0 ? mem_list[row1 - 1][col1] : 0
#   sum_xy = col1 > 0 && row1 > 0 ? mem_list[row1 - 1][col1 - 1] : 0

#   solution = sum_x + sum_y - sum_xy + matrix[row1][col1]

#   mem_list[row1][col1] = solution
# end

# @solutions_matrix = build_mem_list(matrix)

# def box_sum(_row0, _col0, row1, col1)
#   start = @solutions_matrix[row1][col1]
#   min_x = @solutions_matrix[0][col1]
#   min_y = @solutions_matrix[row1][0]

#   start - min_x - min_y + @solutions_matrix[0][0]
# end

#
#
#
#
#
#
#
#
#
#
#
#
#
#
#-==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

class NumMatrix
  #     :type matrix: Integer[][]
  def initialize(matrix)
    @matrix = matrix
    matrix.length.times do |i|
      matrix[0].length.times do |j|
        sum = 0
        sum += matrix[i][j - 1] if j > 0
        sum += matrix[i - 1][j] if i > 0
        sum -= matrix[i - 1][j - 1] if i > 0 && j > 0
        sum += matrix[i][j]
        @matrix[i][j] = sum
      end
    end
  end

  #     :type row1: Integer
  #     :type col1: Integer
  #     :type row2: Integer
  #     :type col2: Integer
  #     :rtype: Integer
  def sum_region(row1, col1, row2, col2)
    sum = @matrix[row2][col2]
    sum -= @matrix[row2][col1 - 1] if col1 > 0
    sum -= @matrix[row1 - 1][col2] if row1 > 0
    sum += @matrix[row1 - 1][col1 - 1] if row1 > 0 && col1 > 0
    sum
  end
end

# Your NumMatrix object will be instantiated and called as such:
# obj = NumMatrix.new(matrix)
# param_1 = obj.sum_region(row1, col1, row2, col2)

#
#
#
#
#
#
#
#
#
#
#
#
#
#
#-==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

class NumMatrix
  #     :type matrix: Integer[][]
  def initialize(matrix)
    return if matrix.empty? || matrix[0].empty?

    @sums = Array.new(matrix.length + 1) { Array.new(matrix[0].length + 1, 0) }
    (0...matrix.length).each do |i|
      (0...matrix[0].length).each do |j|
        @sums[i + 1][j + 1] = @sums[i][j + 1] + @sums[i + 1][j] - @sums[i][j] + matrix[i][j]
      end
    end
  end

  #     :type row1: Integer
  #     :type col1: Integer
  #     :type row2: Integer
  #     :type col2: Integer
  #     :rtype: Integer
  def sum_region(row1, col1, row2, col2)
    @sums[row2 + 1][col2 + 1] - @sums[row1][col2 + 1] - @sums[row2 + 1][col1] + @sums[row1][col1]
  end
end

# Your NumMatrix object will be instantiated and called as such:
# obj = NumMatrix.new(matrix)
# param_1 = obj.sum_region(row1, col1, row2, col2)
