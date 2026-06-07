def create_binary_tree(descriptions)
  # Automatically instantiate a new TreeNode if the key doesn't exist
  nodes = Hash.new { |hash, key| hash[key] = TreeNode.new(key) }
  children = Set.new

  # Step 1: Build the tree structures and map the values
  descriptions.each do |parent_val, child_val, is_left|
    parent_node = nodes[parent_val]
    child_node = nodes[child_val]

    if is_left == 1
      parent_node.left = child_node
    else
      parent_node.right = child_node
    end

    children.add(child_val)
  end

  # Step 2: Find the root (the node that is never a child)
  descriptions.each do |parent_val, _, _|
    return nodes[parent_val] unless children.include?(parent_val)
  end

  nil
end
