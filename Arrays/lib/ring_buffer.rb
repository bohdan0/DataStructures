require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @store = Array.new(8)
    @capacity = 8
    @length = 0
    @start_idx = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[(@start_idx + index) % @capacity]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    @length += 1 unless @store[index]
    @store[(@start_idx + index) % @capacity] = val
  end

  # O(1)
  def pop
    raise 'index out of bounds' if @length == 0
    @length -= 1
    result = @store[(@start_idx + @length) % @capacity]
    @store[(@start_idx + @length) % @capacity] = nil

    result
  end

  # O(1) ammortized
  def push(val)
    if @length == @capacity
      resize!
      push(val)
    else
      @store[(@start_idx + @length) % @capacity] = val
      @length += 1
    end
  end

  # O(1)
  def shift
    check_index(0)
    @length -= 1
    result = @store[@start_idx]
    @start_idx = (@start_idx + 1) % @capacity

    result
  end

  # O(1) ammortized
  def unshift(val)
    if @length == @capacity
      resize!
      unshift(val)
    else
      @length += 1
      if @store[@start_idx]
        @start_idx = (@start_idx - 1) % @capacity
        @store[@start_idx] = val
      else
        @store[@start_idx] = val
      end
    end
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise 'index out of bounds' if index >= length
  end

  def resize!
    @capacity *= 2
    new_store = Array.new(@capacity)
    new_length = 0

    @length.times do |idx|
      if @store[(@start_idx + idx) % @length]
        new_store[new_length] = @store[(@start_idx + idx) % @length]
        new_length += 1
      end
    end

    @start_idx = 0
    @store = new_store
    @length = new_length
  end
end
