class BSTNode
  attr_accessor :left, :right
  attr_reader :value

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

class BinarySearchTree
  def initialize
    @root = nil
  end

  def insert(value)
    if @root
      BinarySearchTree.insert!(@root, value)
    else
      @root = BSTNode.new(value)
    end
  end

  def find(value)
    BinarySearchTree.find!(@root, value)
  end

  def inorder
    BinarySearchTree.inorder!(@root)
  end

  def postorder
    BinarySearchTree.postorder!(@root)
  end

  def preorder
    BinarySearchTree.preorder!(@root)
  end

  def height
    BinarySearchTree.height!(@root)
  end

  def min
    BinarySearchTree.min(@root)
  end

  def max
    BinarySearchTree.max(@root)
  end

  def delete(value)
    BinarySearchTree.delete!(@root, value)
  end

  def self.insert!(node, value)
    return BSTNode.new(value) unless node

    if node.value < value
      node.right = insert!(node.right, value)
    else
      node.left = insert!(node.left, value)
    end

    node
  end

  def self.find!(node, value)
    return nil unless node
    return node if node.value == value

    if node.value < value
      find!(node.right, value)
    else
      find!(node.left, value)
    end
  end

  def self.preorder!(node)
    return [] unless node
    [node.value] + preorder!(node.left) + preorder!(node.right)
  end

  def self.inorder!(node)
    return [] unless node
    inorder!(node.left) + [node.value] + inorder!(node.right)
  end

  def self.postorder!(node)
    return [] unless node
    postorder!(node.left) + postorder!(node.right) + [node.value]
  end

  def self.height!(node, ctr = 0)
    return -1 unless node
    return ctr unless node.left || node.right
    [height!(node.left, ctr + 1), height!(node.right, ctr + 1)].max
  end

  def self.max(node)
    return nil unless node
    return node unless node.right
    max(node.right)
  end

  def self.min(node)
    return nil unless node
    return node unless node.left
    min(node.left)
  end

  def self.delete_min!(node)
    return nil unless node

    if node.left
      node.left = delete_min!(node.left)
    else
      node.right 
    end
  end

  def self.delete!(node, value)
    return nil unless node

    if node.value == value
      return node.left unless node.right
      return node.right unless node.left

      temp = node
      node = temp.right.min
      node.right = BinarySearchTree.delete_min!(temp.right)
      node.left = temp.left
    else
      if node.value < value
        node.right = delete!(node.right, value)
      else
        node.left = delete!(node.left, value)
      end
    end
  end
end