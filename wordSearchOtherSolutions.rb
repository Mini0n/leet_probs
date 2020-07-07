# frozen_string_literal: true

# @param {Character[][]} board
# @param {String} word
# @return {Boolean}
def exist(board, word)
  word = word.chars

  board.each_with_index do |row, i|
    row.each_with_index do |pos, j|
      next unless pos == word.first
      return true if check([i, j], board, word)
    end
  end

  false
end

def check(pos, board, word)
  return true if word.empty?

  if pos.first >= board.size || pos.last >= board.first.size || pos.first < 0 || pos.last < 0
    false

  elsif board[pos.first][pos.last] == word.first
    temp = board[pos.first][pos.last]
    board[pos.first][pos.last] = '#'

    result = check([pos.first + 1, pos.last], board, word.slice(1..-1)) || check([pos.first, pos.last + 1], board, word.slice(1..-1)) || check([pos.first - 1, pos.last], board, word.slice(1..-1)) || check([pos.first, pos.last - 1], board, word.slice(1..-1))

    board[pos.first][pos.last] = temp

    result
  else
    false
  end
end

# @param {Character[][]} board
# @param {String} word
# @return {Boolean}
def exist(board, word)
  nrows = board.size
  ncols = board[0].size
  visited = Array.new(nrows) { Array.new(ncols, false) }

  (0..nrows - 1).each do |r|
    (0..ncols - 1).each do |c|
      return true if board[r][c] == word[0] && dfs(board, visited, r, c, nrows, ncols, word, 0)
    end
  end
  false
end

def dfs(board, visited, r, c, nrows, ncols, word, word_idx)
  return true if word_idx == word.length

  return false if r < 0 || c < 0 || r >= nrows || c >= ncols || visited[r][c] || board[r][c] != word[word_idx]

  visited[r][c] = true

  left = dfs(board, visited, r, c - 1, nrows, ncols, word, word_idx + 1)
  right = dfs(board, visited, r, c + 1, nrows, ncols, word, word_idx + 1)
  top = dfs(board, visited, r - 1, c, nrows, ncols, word, word_idx + 1)
  bottom = dfs(board, visited, r + 1, c, nrows, ncols, word, word_idx + 1)

  if left || right || top || bottom
    true
  else
    visited[r][c] = false
    false
  end
end

# @param {Character[][]} board
# @param {String} word
# @return {Boolean}
def exist(board, word)
  Backtrack.new(board, word).call
end

class Backtrack
  def initialize(board, word)
    @board = board
    @word = word.split('')
    @r_max = board.length - 1
    @c_max = board.first.length - 1
  end

  def call
    first_letter = @word[0]
    (0..@r_max).each do |ri|
      (0..@c_max).each do |ci|
        next unless @board[ri][ci] == first_letter

        @board[ri][ci] = '#'
        return true if find_next(ri: ri, ci: ci)

        @board[ri][ci] = first_letter
      end
    end

    false
  end

  private

  def find_next(found_letters: 1, ri:, ci:)
    return true if found_letters == @word.length

    # puts "found_letters: #{found_letters}, @board: #{@board}"

    ri1 = ri + 1
    ci1 = ci
    ri2 = ri - 1
    ci2 = ci
    ri3 = ri
    ci3 = ci + 1
    ri4 = ri
    ci4 = ci - 1

    if ri1 <= @r_max && @board[ri1][ci1] == @word[found_letters]
      @board[ri1][ci1] = '#'
      return true if find_next(found_letters: found_letters + 1, ri: ri1, ci: ci1)

      @board[ri1][ci1] = @word[found_letters]
    end
    if ri2 >= 0 && @board[ri2][ci2] == @word[found_letters]
      @board[ri2][ci2] = '#'
      return true if find_next(found_letters: found_letters + 1, ri: ri2, ci: ci2)

      @board[ri2][ci2] = @word[found_letters]
    end
    if ci3 <= @c_max && @board[ri3][ci3] == @word[found_letters]
      @board[ri3][ci3] = '#'
      return true if find_next(found_letters: found_letters + 1, ri: ri3, ci: ci3)

      @board[ri3][ci3] = @word[found_letters]
    end
    if ci4 >= 0 && @board[ri4][ci4] == @word[found_letters]
      @board[ri4][ci4] = '#'
      return true if find_next(found_letters: found_letters + 1, ri: ri4, ci: ci4)

      @board[ri4][ci4] = @word[found_letters]
    end

    false
  end
end

# @param {Character[][]} board
# @param {String} word
# @return {Boolean}
def exist(board, word)
  nrows = board.size
  ncols = board[0].size
  visited = Array.new(nrows) { Array.new(ncols, false) }

  (0..nrows - 1).each do |r|
    (0..ncols - 1).each do |c|
      return true if board[r][c] == word[0] && dfs(board, visited, r, c, nrows, ncols, word, 0)
    end
  end
  false
end

def dfs(board, visited, r, c, nrows, ncols, word, word_idx)
  return true if word_idx == word.length

  return false if r < 0 || c < 0 || r >= nrows || c >= ncols || visited[r][c] || board[r][c] != word[word_idx]

  visited[r][c] = true

  left = dfs(board, visited, r, c - 1, nrows, ncols, word, word_idx + 1)
  right = dfs(board, visited, r, c + 1, nrows, ncols, word, word_idx + 1)
  top = dfs(board, visited, r - 1, c, nrows, ncols, word, word_idx + 1)
  bottom = dfs(board, visited, r + 1, c, nrows, ncols, word, word_idx + 1)

  if left || right || top || bottom
    true
  else
    visited[r][c] = false
    false
  end
end
