# frozen_string_literal: true

#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#
# https://leetcode.com/problems/lru-cache/
#
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

class LRUCache
  # :type capacity: Integer
  def initialize(capacity)
    @size = capacity
    @data = {}
  end

  # type key: Integer
  # rtype: Integer
  def get(key)
    res = @data[key]

    return -1 if res.nil?

    put(key, res)

    res
  end

  # :type key: Integer
  # :type value: Integer
  # :rtype: Void
  def put(key, value)
    res = { key => value }

    @data.delete(key)
    @data.merge!(res)

    @data.shift if @data.length > @size

    res
  end

  def print
    puts @data
  end
end

# Your LRUCache object will be instantiated and called as such:
# obj = LRUCache.new(capacity)
# param_1 = obj.get(key)
# obj.put(key, value)

#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
#
# Program
#
#==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

cache = LRUCache.new(2)
cache.print

cache.put(1, 1)
cache.print

cache.put(2, 2)
cache.print

puts cache.get(1)       # returns 1
cache.print

cache.put(3, 3)         # evicts key 2
cache.print

puts cache.get(2)       # returns -1 (not found)
cache.print

cache.put(4, 4)         # evicts key 1
cache.print

puts cache.get(1)       # returns -1 (not found)
cache.print

puts cache.get(3)       # returns 3
cache.print

puts cache.get(4)       # returns 4
cache.print

puts '-' * 43

cache = LRUCache.new(2)
cache.print

cache.put(2, 1)
cache.print

cache.put(1, 1)
cache.print

cache.put(2, 3)
cache.print

cache.put(4, 1)
cache.print

puts cache.get(1)       # returns 1
cache.print

puts cache.get(2)       # returns -1 (not found)
cache.print
