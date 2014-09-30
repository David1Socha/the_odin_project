TEST_VALS = [3,4, 8, 903, 6, -234, 29, 0, 184]
class Node
  attr_accessor :value, :left_child, :right_child, :parent, :height

  def initialize(value)
    @value = value
    @height = 0
  end

#note: does not give accurate results unless all children have accurate heights 
  def update_height!
    if @left_child.nil? && @right_child.nil?
      @height = 0
    elsif @left_child.nil?
      @height = @right_child.height + 1
    elsif @right_child.nil?
      @height = @left_child.height + 1
    else
      @height = [@right_child.height, @left_child.height].max + 1
    end
    @height
  end

  def balance_factor
    return 0 if @left_child.nil? && @right_child.nil?
    return @height if @right_child.nil? 
    return - @height if @left_child.nil?
    return @left_child.height - @right_child.height
  end

  def rebalance!
    localroot = self
    if balance_factor == 2
      lc = @left_child
      if lc.balance_factor == -1 #handle left right case
        lc.right_child.rotate_left! #reduce to left left case
        @left_child.rotate_right!
        localroot = @parent
      else
        lc.rotate_right! #handle left left case
        localroot = lc
      end
    else
      rc = @right_child
      if rc.balance_factor == 1 #handle right left case
        rc.left_child.rotate_right! #reduce to right right case
        @right_child.rotate_left!
        localroot = @parent
      else
        rc.rotate_left! #handle right right case
        localroot = rc
      end
    end
  end

#should be called by the pivot node
  def rotate_right!
    root = @parent
    root.left_child = @right_child
    root.left_child.parent = root unless @right_child.nil?
    @right_child = root
    self.parent = right_child.parent
    unless self.parent.nil?
      if self.parent.right_child == right_child
        self.parent.right_child = self 
      else
        self.parent.left_child = self
      end
    end
    right_child.parent = self
    update_heights!(right_child, self)
  end

#should be called by the pivot node
  def rotate_left!
    root = @parent
    root.right_child = @left_child
    root.right_child.parent = root unless @left_child.nil?
    @left_child = root
    self.parent = @left_child.parent
    unless self.parent.nil?
      if self.parent.right_child == @left_child
        self.parent.right_child = self 
      else
        self.parent.left_child = self
      end
    end
    @left_child.parent = self
    update_heights!(left_child, self)
  end

  def update_heights!(*nodes)
    nodes.each do |n|
      n.right_child.update_height! unless n.right_child.nil?
      n.left_child.update_height! unless n.left_child.nil?
      n.update_height!
    end
  end

end

def build_tree(arr)
  root = Node.new(arr.first)
  current_node, parent_node, node_on_left = nil, nil, nil
  arr[1..-1].each do |val|
    current_node, visited = root, []
    until current_node.nil? do
      visited.push current_node
      node_on_left = val < current_node.value
      parent_node = current_node
      if node_on_left
        current_node = current_node.left_child
      else
        current_node = current_node.right_child
      end
    end
    
    current_node = Node.new(val)
    current_node.parent = parent_node
    if node_on_left
      parent_node.left_child = current_node
    else
      parent_node.right_child = current_node
    end

    localroot = nil
    visited.reverse_each do |node|
      node.update_height!
      if node.balance_factor == 2 || node.balance_factor == -2
        localroot = node.rebalance! 
        break
      end
    end
    root = localroot if !localroot.nil? && localroot.height > root.height

  end
  return root
end

def dfs_rec(node)
  dfs_rec(node.left_child) unless node.left_child.nil?
  puts "#{node.value}, #{node.height}"
  dfs_rec(node.right_child) unless node.right_child.nil?
end

root = build_tree(TEST_VALS)
dfs_rec(root)
[3,4, 8, 903, 6, -234, 29, 0, 184]