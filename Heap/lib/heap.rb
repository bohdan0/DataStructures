class BinaryMinHeap
  def initialize(&prc)
    @store = []
    @prc = prc
  end

  def count
    @store.count
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    result = @store.pop
    BinaryMinHeap.heapify_down(@store, 0)
    result
  end

  def peek
    @store[0]
  end

  def push(val)
    @store << val
    BinaryMinHeap.heapify_up(@store, count - 1)
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    [parent_index * 2 + 1, parent_index * 2 + 2].select { |n| n < len }
  end

  def self.parent_index(child_index)
    raise 'root has no parent' if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= proc { |x, y| x <=> y }
    curr_idx = parent_idx
    loop do
      child_idxs = BinaryMinHeap.child_indices(len, curr_idx)
      min_child_idx = nil

      child_idxs.each do |child_idx|
        next if child_idx == min_child_idx
        min_child_idx = child_idx if !min_child_idx || 
                                      prc.call(array[child_idx], array[min_child_idx]) == -1 
      end

      if min_child_idx && 
         prc.call(array[min_child_idx], array[curr_idx]) == -1
           array[curr_idx], array[min_child_idx] = array[min_child_idx], array[curr_idx]
           curr_idx = min_child_idx
      else
        return array
      end
    end


  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= proc { |x, y| x > y }
    curr_idx = child_idx
    loop do
      parent_idx = BinaryMinHeap.parent_index(curr_idx) if curr_idx != 0
      if parent_idx && prc.call(array[parent_idx], array[curr_idx])
        array[curr_idx], array[parent_idx] = array[parent_idx], array[curr_idx]
        curr_idx = parent_idx
      else
        return array
      end
    end
  end
end
