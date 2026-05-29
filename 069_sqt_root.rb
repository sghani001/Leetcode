def my_sqrt(x)
  return x if x < 2

  low = 0
  high = x
  ans = 0

  while low <= high
    # Find the middle point between low and high bounds
    mid = (low + high) / 2
    mid_squared = mid * mid

    if mid_squared == x
      return mid # Perfect square root found
    elsif mid_squared < x
      ans = mid       # mid is a valid candidate so far (rounded down)
      low = mid + 1   # Tighten the search area to look for a larger valid integer
    else
      high = mid - 1  # mid is too big, discard the upper half
    end
  end

  ans
end

=begin
================================================================================
EXPLANATION OF THE BINARY SEARCH APPROACH
================================================================================

1. Guard Clause:
   If x is 0 or 1, its square root is itself. Returning early saves processing.

2. Defining the Search Space:
   The square root of any number 'x' (where x >= 2) will always fall within the 
   range of 0 to x. Instead of checking every number one by one (Linear Search), 
   we use Binary Search to cut the search space in half with each iteration.

3. The Loop Mechanism:
   - We calculate 'mid', the middle integer of our current range.
   - We check 'mid * mid' (mid_squared) against our target 'x'.

4. Shifting Bounds:
   - Match: If 'mid_squared == x', we found the exact root and return it.
   - Too Small: If 'mid_squared < x', 'mid' is a potential answer because the 
     problem requires us to round down to the nearest integer. We save 'mid' in 
     our 'ans' variable and move 'low = mid + 1' to see if a larger valid 
     integer exists.
   - Too Large: If 'mid_squared > x', 'mid' is too big. We adjust our upper 
     bound by moving 'high = mid - 1'.

5. Termination:
   Once 'low' crosses 'high', the loop terminates, and 'ans' holds the largest 
   integer whose square is less than or equal to 'x'.
================================================================================
=end
