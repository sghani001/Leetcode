# Definition for singly-linked list.
class ListNode
  attr_accessor :val, :next
  def initialize(val = 0, _next = nil)
    @val = val
    @next = _next
  end
end

# @param {ListNode[]} lists
# @return {ListNode}
def merge_k_lists(lists)
  return nil if lists.nil? || lists.empty?
  
  # Filter out nil entries
  lists = lists.reject(&:nil?)
  return nil if lists.empty?

  # Use Divide and Conquer approach
  # Time Complexity: O(N log k) where N is total nodes and k is number of lists
  interval = 1
  while interval < lists.length
    (0...(lists.length - interval)).step(interval * 2) do |i|
      lists[i] = merge_two_lists(lists[i], lists[i + interval])
    end
    interval *= 2
  end
  
  lists[0]
end

def merge_two_lists(l1, l2)
  dummy = ListNode.new(0)
  current = dummy
  
  while l1 && l2
    if l1.val < l2.val
      current.next = l1
      l1 = l1.next
    else
      current.next = l2
      l2 = l2.next
    end
    current = current.next
  end
  
  current.next = l1 || l2
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
puts "Test Case 1: lists = [[1,4,5],[1,3,4],[2,6]]"
l1 = array_to_list([1, 4, 5])
l2 = array_to_list([1, 3, 4])
l3 = array_to_list([2, 6])
result = merge_k_lists([l1, l2, l3])
puts "Result: #{list_to_array(result).inspect}" # Output: [1, 1, 2, 3, 4, 4, 5, 6]

puts "\nTest Case 2: lists = []"
puts "Result: #{merge_k_lists([]).inspect}" # Output: nil

puts "\nTest Case 3: lists = [[]]"
puts "Result: #{merge_k_lists([nil]).inspect}" # Output: nil
