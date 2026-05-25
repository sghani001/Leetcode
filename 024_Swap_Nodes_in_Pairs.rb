# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val = 0, _next = nil)
#         # @val = val
#         # @next = _next
#     end
# end
# @param {ListNode} head
# @return {ListNode}
def swap_pairs(head)
  # 1. Initialize dummy node to handle head-swapping seamlessly
  dummy = ListNode.new(0, head)
  prev = dummy
  
  # 2. Loop runs only if there is a pair (two nodes) left to swap
  while !prev.next.nil? && !prev.next.next.nil?
    # Identify the two nodes to be swapped
    first = prev.next
    second = first.next
    
    # The 3-Step Pointer Dance:
    first.next = second.next   # Step A: Link first node to the rest of the list
    second.next = first        # Step B: Turn second node around to point to first
    prev.next = second         # Step C: Connect the previous part to the new pair head
    
    # 3. Move 'prev' two nodes ahead to prepare for the next pair
    prev = first
  end
  
  # 4. Return the new head of the list
  dummy.next
end

# ==============================================================================
# EXPLANATION OF THE POINTER DANCE
# ==============================================================================
# Let's trace one single swap operation for a list segment: ... prev -> 1 -> 2 -> 3 ...
# Initially: 'first' is 1, 'second' is 2.
#
# STEP A: first.next = second.next
# Before: 1 -> 2 -> 3
# After:  1 ------> 3   (Node 1 temporarily bypasses Node 2 and links directly to 3)
#         2 -> 3
#
# STEP B: second.next = first
# Before: 2 -> 3
# After:  2 -> 1        (Node 2 now points backward to Node 1)
# 
# STEP C: prev.next = second
# Before: prev -> 1
# After:  prev -> 2     (The incoming link from the previous group now fastens to Node 2)
#
# Putting Steps A, B, and C together, the segment beautifully transforms into:
# ... prev -> 2 -> 1 -> 3 ...
#
# Finally, 'prev = first' updates our tracking anchor. Since 'first' (Node 1) is 
# now physically located after Node 2, making it the new 'prev' sets us up 
# perfectly to process the next pair starting at Node 3.
#
# Complexity:
# - Time Complexity: O(N) where N is the total number of nodes in the linked list. 
#   We traverse the entire list exactly once.
# - Space Complexity: O(1) as we only re-map physical pointers in memory without 
#   generating new nodes or utilizing additional data structures.