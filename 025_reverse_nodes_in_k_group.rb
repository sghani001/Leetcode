# Definition for singly-linked list.
class ListNode
  attr_accessor :val, :next
  def initialize(val = 0, _next = nil)
    @val = val
    @next = _next
  end
end

# @param {ListNode} head
# @param {Integer} k
# @return {ListNode}
def reverse_k_group(head, k)
  return head if head.nil? || k == 1

  # Use a dummy node to simplify head processing
  dummy = ListNode.new(0)
  dummy.next = head
  
  prev_group_end = dummy
  
  loop do
    # 1. Find the end of the current group
    group_end = prev_group_end
    k.times do
      group_end = group_end.next
      break if group_end.nil?
    end
    
    # If we don't have k nodes left, we are done
    break if group_end.nil?
    
    # 2. Reversing the group
    next_group_start = group_end.next
    current = prev_group_end.next
    prev = next_group_start
    
    # Temporary pointers to manage the reversal
    node_to_reverse = current
    k.times do
      nxt = node_to_reverse.next
      node_to_reverse.next = prev
      prev = node_to_reverse
      node_to_reverse = nxt
    end
    
    # 3. Connect the reversed group back to the list
    new_group_end = prev_group_end.next
    prev_group_end.next = prev
    prev_group_end = new_group_end
  end
  
  dummy.next
end

# Helper functions for testing
def array_to_list(arr)
  return nil if arr.empty?
  head = ListNode.new(arr[0])
  current = head
  arr[1..-1].each do |val|
    current.next = ListNode.new(val)
    current = current.next
  end
  head
end

def list_to_array(node)
  arr = []
  while node
    arr << node.val
    node = node.next
  end
  arr
end

# Test Cases
puts "Test Case 1: head = [1,2,3,4,5], k = 2"
l1 = array_to_list([1, 2, 3, 4, 5])
result1 = reverse_k_group(l1, 2)
puts "Result: #{list_to_array(result1).inspect}" # Output: [2, 1, 4, 3, 5]

puts "\nTest Case 2: head = [1,2,3,4,5], k = 3"
l2 = array_to_list([1, 2, 3, 4, 5])
result2 = reverse_k_group(l2, 3)
puts "Result: #{list_to_array(result2).inspect}" # Output: [3, 2, 1, 4, 5]
