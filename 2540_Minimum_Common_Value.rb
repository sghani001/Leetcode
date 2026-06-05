# @param {Integer[]} nums1
# @param {Integer[]} nums2
# @return {Integer}
def get_common(nums1, nums2)
  p1 = 0
  p2 = 0

  while p1 < nums1.length && p2 < nums2.length
    if nums1[p1] == nums2[p2]
      return nums1[p1] 
    elsif nums1[p1] < nums2[p2]
      p1 += 1 
    else
      p2 += 1 
    end
  end

  # =========================================================================
  #                           EXPLANATION
  # =========================================================================
  #
  # THE CORE CONCEPT: TWO-POINTER APPROACH
  # Because both arrays are already sorted in non-decreasing order, we do not 
  # need to compare every element of `nums1` with every element of `nums2` 
  # (which would take a slow O(N * M) time). Instead, we can read both arrays 
  # simultaneously from left to right using two independent indices (`p1` and `p2`).
  #
  # HOW THE POINTER MOVEMENT WORKS:
  # At each step of the loop, we look at the values currently targeted by our pointers:
  #
  # 1. MATCH FOUND (`nums1[p1] == nums2[p2]`):
  #    Since we are scanning from the beginning (the smallest values) toward the end, 
  #    the very first match we find is mathematically guaranteed to be the minimum 
  #    common value. We return it immediately.
  #
  # 2. FIRST VALUE IS SMALLER (`nums1[p1] < nums2[p2]`):
  #    The value at `p1` is too small to match the current value at `p2`. Because 
  #    `nums2` is sorted, all subsequent values in `nums2` will be even larger. 
  #    Therefore, the value at `p1` can never find a match. We discard it by 
  #    incrementing `p1` to hunt for a larger number.
  #
  # 3. SECOND VALUE IS SMALLER (`nums1[p1] > nums2[p2]`):
  #    By the same logic, the value at `p2` is too small to match anything remaining 
  #    in `nums1`. We discard it by incrementing `p2`.
  #
  # LOOP TERMINATION:
  # The loop safely runs as long as both pointers stay within their respective array 
  # bounds (`p1 < nums1.length && p2 < nums2.length`). If either pointer runs out of 
  # bounds, it means we scanned an entire array without hitting a single match. 
  # The function breaks out and returns `-1`.
  #
  # COMPLEXITY:
  # * Time Complexity: O(N + M) where N and M are the lengths of the arrays. In the 
  #   worst-case scenario, we move one pointer forward each step, meaning we traverse 
  #   the arrays linearly.
  # * Space Complexity: O(1) auxiliary space as we only store two integer pointers.
  # =========================================================================
  -1
end
