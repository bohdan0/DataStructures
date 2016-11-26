require 'byebug'

class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @val = nil
    @next.prev = @prev if @next
    @prev.next = @next if @prev
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = nil
    @tail = nil
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head
  end

  def last
    @tail
  end

  def empty?
    @head.nil? && @tail.nil?
  end

  def get(key)
    self.each { |link| return link.val if link.key == key }

    nil
  end

  def include?(key)
    self.each { |link| return true if link.key == key }

    false
  end

  def append(key, val)
    include?(key) ? update(key, val) : create_node(key, val)
  end

  def create_node(key, val)
    node = Link.new(key, val)
    set_up_node(node)
  end

  def set_up_node(node)
    node.prev = @tail
    @tail = node

    if @head
      node.prev.next = node
    else
      @head = node
    end
  end

  def update(key, val)
    each { |link| return link.val = val if link.key == key }
  end

  def remove(key)
    each { |link| return link.remove if link.key == key }
  end

  def each
    curr_link = @head
    until curr_link.nil?
      yield(curr_link)
      curr_link = curr_link.next
    end

    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
