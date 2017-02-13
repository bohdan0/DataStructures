require_relative "heap"

class Array
  def heap_sort!
    heap = BinaryMinHeap.new
    each { |el| heap.push(el) }
    len = count
    idx = 0
    while idx < len
      self[idx] = heap.extract
      idx += 1
    end
  end
end
