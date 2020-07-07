# frozen_string_literal: true

#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#
# https://leetcode.com/problems/word-search/
#
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

require 'awesome_print'
require 'colorize'

# @param {Character[][]} board
# @param {String} word
# @return {Boolean}
def exist(board, word)
  # puts '-' * 43
  # puts "> Searching for #{word}"
  # print_board(board)

  return true if word.empty? # true if word is empty

  return false if board_empty?(board) # false if board is empty

  ctr = control_board(board) # availability board
  hei = board.length #  rows number

  board.each_with_index do |row, y|
    row.each_with_index do |_col, x|
      ctr = control_board(board) # availability board
      len = row.length # row length
      res = true # result

      next unless check_char(x, y, len, hei, board, ctr, word[0]) # next if 1st char not found

      return true if check_chars(x, y, len, hei, board, ctr, word, 1) # word check!
    end
  end

  false
end

# check for the word char by char with each found char neighboors
def check_chars(x, y, len, hei, board, control, word, index)
  return true if index == word.length # if the index == length we've found the word

  # check if the searched character is in one the neighboors
  # if it is, move to that cell and check for the next one until all are found
  # or the character doesn't appear in any of the neighboors

  if check_char(x - 1, y, len, hei, board, control, word[index])
    return true if check_chars(x - 1, y, len, hei, board, control, word, index + 1)

    control[y][x - 1] = true
  end

  if check_char(x + 1, y, len, hei, board, control, word[index])
    return true if check_chars(x + 1, y, len, hei, board, control, word, index + 1)

    control[y][x + 1] = true
  end

  if check_char(x, y - 1, len, hei, board, control, word[index])
    return true if check_chars(x, y - 1, len, hei, board, control, word, index + 1)

    control[y - 1][x] = true
  end

  if check_char(x, y + 1, len, hei, board, control, word[index])
    return true if check_chars(x, y + 1, len, hei, board, control, word, index + 1)

    control[y + 1][x] = true
  end

  false
end

# check if cell has the looked char and mark as used if it does
def check_char(x, y, len, hei, board, control, char)
  return false unless safe(x, y, len, hei, control)

  # puts " - searching: #{char} in [#{x}, #{y}]  --> #{board[y][x]}"

  if board[y][x] == char
    # puts "  - found letter #{char}"
    control[y][x] = false
    true
  end
end

# check if the board is empty
def board_empty?(board)
  board.empty? || board.map(&:length).sum.zero?
end

# creates a control board to track available cells
def control_board(board)
  Array.new(board.length) do |el|
    Array.new(board[el].length) { true }
  end
end

# check if cell in the board boundaries & available
def safe(x, y, length, height, control)
  return false if (x < 0 || x >= length) || (y < 0 || y >= height)

  control[y][x]
end

#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#
# Program
#
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
def print_board(board)
  puts "\n[ Board ]".yellow

  if board_empty?(board)
    puts "#{'=' * 11}\n[ <empty> ]\n#{'=' * 11}"
  else

    board.each { |row| puts row.to_s }

  end
end

def searches(board, words)
  print_board(board)

  words.each do |word|
    res = exist(board, word.first)
    pic = res == word.last ? 'PASS'.green : 'FAIL'.red
    res = res == true ? 'true'.blue : 'false'.red
    fun = 'exist'.light_blue
    wrd = "\"#{word.first}\"".cyan

    puts "-[#{pic}] #{fun}(#{'board'.yellow}, #{wrd}) #{'.' * (43 - word.first.length)} : #{res}"
  end
end

#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
board = []

words = [['ABC', false]]

searches(board, words)

#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
board = [[], [], []]

words = [['ABC', false]]

searches(board, words)

#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
board =
  [
    %w[A B C E],
    %w[S F],
    %w[A D E E]
  ]

words = [
  ['', true],
  ['BFDE', true],
  ['ASFD', true],
  ['ABCF', false],
  ['ABSF', false]
]

searches(board, words)

#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
board =
  [
    %w[A B C E],
    %w[S F C S],
    %w[A D E E]
  ]

words = [
  ['SEE', true],
  ['SAB', true],
  ['CFD', true],
  ['CFS', true],

  ['CSA', false],
  ['SFE', false],
  ['ABCB', false],
  ['SFCCC', false],
  ['ABCCED', true],

  ['SADEESECBA', true],
  ['SADEESECBAS', false],
  ['ABCESEEDASFCS', false]
]

searches(board, words)
