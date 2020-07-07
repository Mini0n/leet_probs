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
  return false if board_empty?(board)

  return true if word.empty?

  control = control_board(board)

  board.each_with_index do |row, y|
    row.each_with_index do |char, x|
      next unless char == word[0]

      return true if find_word(x, y, board, control, word, 0)
    end
  end
  false
end

def find_word(x, y, board, control, word, char_index)
  return true if word.length == char_index

  return false unless cell_safe?(x, y, board, control, word, char_index)

  control[y][x] = false

  if find_word(x - 1, y, board, control, word, char_index + 1) ||
     find_word(x + 1, y, board, control, word, char_index + 1) ||
     find_word(x, y - 1, board, control, word, char_index + 1) ||
     find_word(x, y + 1, board, control, word, char_index + 1)

    return true
  end

  control[y][x] = true
  false
end

def cell_safe?(x, y, board, control, word, char_index)
  return false if y < 0 || y >= board.length

  return false if x < 0 || x >= board[y].length

  (board[y][x] == word[char_index]) && control[y][x]
end

# Create control board
def control_board(board)
  board.map(&:length).map { |len| Array.new(len) { true } }
end

# Check if board is empty
def board_empty?(board)
  board.empty? || board.map(&:length).sum.zero?
end

#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#
# Program
#
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
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
    res = exist(board, word.first) ? 'true'.blue : 'false'.red

    ans = res.uncolorize == word.last.to_s ? 'PASS'.green : 'FAIL'.red
    fun = 'exist'.light_blue
    wrd = "\"#{word.first}\"".cyan

    puts "-[#{ans}] #{fun}(#{'board'.yellow}, #{wrd}) #{'.' * (43 - word.first.length)} : #{res}"
  end
end
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
    %w[S F E],
    %w[A D E A]
  ]

words = [
  ['', true],
  ['CEE', true],
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
