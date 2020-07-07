#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#
# https://leetcode.com/problems/asteroid-collision/
#
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

# frozen_string_literal: true

def asteroid_collision(asteroids)
  puts '-' * 43
  puts "asteroid_collision: #{asteroids}"

  return [] if asteroids.empty?

  res = []

  asteroids.each do |ast|
    puts res.to_s

    if res.empty?
      res.push(ast)
      next
    end

    temp = res.pop

    if (temp < 0) && (ast < 0)
      res.push(temp)
      res.push(ast)
      next
    end

    if (temp > 0) && (ast > 0)
      res.push(temp)
      res.push(ast)
      next
    end

    if (temp < 0) && (ast > 0)
      res.push(temp)
      res.push(ast)
      next
    end

    next if (temp**2) == (ast**2)

    if compare(temp, ast) == ast
      redo
    else
      res.push(temp)
    end
  end

  puts " > #{res}"

  res
end

def compare(temp, ast)
  return temp if (temp**2) > (ast**2)

  ast
end

#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#
# Program
#
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

tests = [
  [5, 10, -11],
  [],
  [5, 10, -5],
  [8, -8],
  [10, 2, -5],
  [-2, -1, 1, 2]
]

tests.each { |test| asteroid_collision(test) }
