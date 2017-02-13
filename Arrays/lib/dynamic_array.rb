require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @store = Array.new(8)
    @capacity = 8
    @length = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    @length += 1 unless @store[index]
    @store[index] = value
  end

  # O(1)
  def pop
    check_index(0)
    @length -= 1
    @store[@length]
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    if @length >= @capacity
      resize!
      push(val)
    else
      @store[length] = val
      @length += 1
    end
  end

  # O(n): has to shift over all the elements.
  def shift
    check_index(0)
    result = @store[0]
    (0...@length).to_a.each do |i|
      @store[i] = @store[i + 1]
    end
    @length -= 1

    result
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    if @lenth == @capacity
      resize!
      unshift(val)
    else
    
      i = @length
      while i > 0
        @store[i] = @store[i - 1]
        i -= 1
      end
      @length += 1
      @store[0] = val
    end
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    raise 'index out of bounds' if index >= length
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity *= 2
    new_store = Array.new(@capacity)
    new_length = 0

    @store.each do |el|
      if el
        new_store[new_length] = el
        new_length += 1
      end
    end

    @store = new_store
    @length = new_length
  end
end
