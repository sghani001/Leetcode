def check(nums)
  drop_count = 0
  n = nums.length

  (0...n).each do |i|
    if nums[i] > nums[(i + 1) % n]
      drop_count += 1
    end
  end

  # =========================================================================
  #                           EXPLANATION
  # =========================================================================
  # 
  # THE CORE GEOMETRIC CONCEPT:
  # A perfectly sorted array continuously climbs "uphill" from left to right.
  # When you circularly rotate a sorted array, you break it into two climbing 
  # segments separated by a single, sharp drop-off point where the maximum value 
  # of the original array sits right next to the minimum value.
  #
  # Because of this structural property, a valid rotated sorted array can contain 
  # AT MOST ONE element that is strictly greater than the element following it.
  #
  # INTERPRETING THE FINAL `drop_count`:
  #
  # * drop_count == 0: 
  #   Occurs if all elements are identical (e.g., [1, 1, 1]). This is 
  #   technically sorted and valid, so it returns true.
  #
  # * drop_count == 1: 
  #   Occurs in a standard rotated sorted array (e.g., [3, 4, 5, 1, 2], where 
  #   5 > 1 is the single internal drop) OR a perfectly sorted unrotated array 
  #   where the only drop happens when the last element wraps back around to 
  #   the first element (e.g., [1, 2, 3], where the wrap-around checks 3 > 1).
  #   Both are valid, returning true.
  #
  # * drop_count > 1: 
  #   Occurs if the array dips up and down multiple times (e.g., [2, 1, 3, 4] 
  #   drops internally from 2 > 1, and again during the wrap-around check 
  #   when 4 > 2). This signifies an invalid configuration that cannot be 
  #   formed by rotating a sorted array, returning false.
  # =========================================================================
  drop_count <= 1
end
