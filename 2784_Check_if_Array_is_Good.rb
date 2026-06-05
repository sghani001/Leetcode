# @param {Integer[]} nums
# @return {Boolean}
def is_good(nums)
  # Deduced value of n based on the array length constraint
  n = nums.length - 1
  return false if n < 1

  # Sort the array in-place to achieve O(1) auxiliary space complexity
  nums.sort!

  # Validate the first n elements (indices 0 to n-1)
  (0...n).each do |i|
    # Sorted base[n] should match the sequence 1, 2, 3... at index i
    return false if nums[i] != (i + 1)
  end

  # The very last element (index n) must match the second occurrence of n
  # =========================================================================
  #                           EXPLANATION
  # =========================================================================
  #
  # THE SORTING STRATEGY (O(1) SPACE OPTIMIZATION):
  # In the previous approach, we used a Frequency Hash map. While fast, it required 
  # O(N) extra memory to keep track of counts. We can eliminate this memory overhead 
  # entirely by sorting the array first.
  #
  # If an array is a valid permutation of base[n], sorting it will transform it 
  # into a perfectly predictable, sequential pattern:
  #
  # Example: 
  # Unsorted Good Array:  [1, 3, 3, 2]  (Length = 4, so n = 3)
  # Sorted Good Array:    [1, 2, 3, 3]
  # Corresponding Indices: 0  1  2  3
  #
  # HOW THE IN-PLACE VALIDATION WORKS:
  # Once `nums` is sorted, we can verify its structure mathematically using 
  # loop indexes without needing any temporary storage:
  #
  # 1. SCANNING THE SEQUENCE (0...n):
  #    We loop through all positions up to the second-to-last element. At any index `i`, 
  #    the value sitting there must be exactly equal to `i + 1`. 
  #    * At index 0, the value must be 1.
  #    * At index 1, the value must be 2, and so on.
  #    If any number deviates from this strict arithmetic progression, we can instantly 
  #    return `false`.
  #
  # 2. CHECKING THE DUPLICATE PEAK:
  #    After checking the first `n` elements, we look at the very last slot: `nums[n]`. 
  #    According to the problem's rule, the maximum value `n` must appear exactly 
  #    twice. Since the array is sorted, both copies of `n` will sit side-by-side at 
  #    the very end. We check if `nums[n] == n`.
  #
  # COMPLEXITY BREAKDOWN:
  # * Time Complexity: O(N log N) because sorting an array of size N takes logarithmic 
  #   linear time. The subsequent validation loop runs in linear O(N) time, which means 
  #   the overall speed is dominated by the sorting step.
  # * Space Complexity: O(1) auxiliary space (or O(N) internal space depending on the 
  #   sorting algorithm implementation), as we modify the input array in-place and 
  #   avoid allocating extra hash maps or storage sets.
  # =========================================================================
  nums[n] == n
end
