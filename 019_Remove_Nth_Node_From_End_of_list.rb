# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val = 0, _next = nil)
#         @val = val
#         @next = _next
#     end
# end
# @param {ListNode} head
# @param {Integer} n
# @return {ListNode}
def remove_nth_from_end(head, n)
  dummy = ListNode.new(0, head)
  
  fast = dummy
  slow = dummy
  
  n.times do
    fast = fast.next
  end
  
  while !fast.next.nil?
    fast = fast.next
    slow = slow.next
  end
  
  slow.next = slow.next.next
  
  dummy.next
end

# ==============================================================================
# EXPLANATION
# ==============================================================================
# This problem is solved efficiently in a single pass using the Two-Pointer 
# strategy (Fast and Slow pointers). Here is the breakdown of the mechanics:
#
# 1. The Dummy Anchor:
#    We create a temporary 'dummy' node pointing to 'head'. This provides a 
#    guaranteed node right before the head, shielding our logic from edge cases 
#    like deleting the very first node or handling a list with only 1 element.
#
# 2. Creating the Offset Gap:
#    By advancing the 'fast' pointer forward 'n' times while keeping 'slow' at 
#    the dummy node, we establish a spacing gap of exactly 'n' nodes between them.
#
# 3. Synchronized Walk:
#    We then move both 'fast' and 'slow' forward at the exact same pace. Because 
#    the gap is locked at 'n' nodes, the exact moment 'fast' lands on the final 
#    node of the list, 'slow' will automatically stop exactly one node behind 
#    the target node that needs to be removed.
#
# 4. Snipping the Target Node:
#    To discard the target node, we reassign 'slow.next' to 'slow.next.next'. 
#    This structurally bypasses the target node, removing it from the chain.
#
# 5. Safe Return:
#    Finally, we return 'dummy.next'. Because 'dummy' remains stationary at the 
#    absolute beginning of our operation, 'dummy.next' always points to the true, 
#    updated starting node of the modified list.
#
# Complexity:
# - Time Complexity: O(M) where M is the total number of nodes (Single Pass).
# - Space Complexity: O(1) as we only use pointers and modify references in-place.