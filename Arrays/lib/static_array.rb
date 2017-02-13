# This class just dumbs down a regular Array to be staticly sized.
class StaticArray
  def initialize(length)
    @store = Array.new(length)
  end

  # O(1)
  def [](index)
    check_range(index)
    store[index]
  end

  # O(1)
  def []=(index, value)
    check_range(index)
    store[index] = value
  end

  protected
  attr_accessor :store

  private

  def check_range(index)
    raise 'Out of range' if index > @store.length - 1
  end
end


