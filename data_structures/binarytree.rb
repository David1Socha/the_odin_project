TEST_VALS = [3,4, 8, 903, 6, -234, 29, 0, 184]
class Node
  attr_accessor :value, :left_child, :right_child, :parent, :height

  def initialize(value)
    @value = value
    @height = 0
  end

#note: does not give accurate results unless all children have accurate heights 
  def update_height
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

    until visited.empty? do
      visited.pop.update_height
    end
  end
  return root
end

def dfs(node)
  dfs(node.left_child) unless node.left_child.nil?
  puts "#{node.value}, #{node.height}"
  dfs(node.right_child) unless node.right_child.nil?
end

root = build_tree(TEST_VALS)
dfs(root)