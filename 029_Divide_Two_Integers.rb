# @param {Integer} dividend
# @param {Integer} divisor
# @return {Integer}
def divide(dividend, divisor)
  # 1. Initialize boundary constants for 32-bit signed integers
  max_int = 2**31 - 1
  min_int = -2**31

  # 2. Handle the specific overflow edge case upfront
  return max_int if dividend == min_int && divisor == -1

  # 3. Use XOR to determine if the final result should be negative
  is_negative = (dividend < 0) ^ (divisor < 0)

  # 4. Convert inputs to absolute values to simplify math
  abs_dividend = dividend.abs
  abs_divisor = divisor.abs
  quotient = 0

  # 5. Loop runs only if the remaining dividend can accommodate the divisor
  while abs_dividend >= abs_divisor
    temp_divisor = abs_divisor
    multiple = 1

    # The Exponential Shift Dance:
    # Double the divisor and the multiple chunk as long as it fits
    while abs_dividend >= (temp_divisor << 1)
      temp_divisor <<= 1   # Step A: Shift divisor left (multiply by 2)
      multiple <<= 1       # Step B: Shift multiple left (multiply by 2)
    end

    # 6. Deduct the largest valid doubled chunk from our dividend pool
    abs_dividend -= temp_divisor
    quotient += multiple
  end

  # 7. Apply the sign and anchor the result within legal bounds
  final_result = is_negative ? -quotient : quotient
  [[min_int, final_result].max, max_int].min
end

# ==============================================================================
# EXPLANATION OF THE BIT-SHIFT DANCE
# ==============================================================================
# Let's trace one single reduction cycle for a problem segment: divide(29, 3)
# Initially: 'abs_dividend' is 29, 'abs_divisor' is 3, 'quotient' is 0.
#
# STEP A & B: Doubling phase via bitwise shifting (<< 1)
# Start:       temp_divisor = 3,   multiple = 1
# Shift 1:     temp_divisor = 6,   multiple = 2   (6 <= 29, valid)
# Shift 2:     temp_divisor = 12,  multiple = 4   (12 <= 29, valid)
# Shift 3:     temp_divisor = 24,  multiple = 8   (24 <= 29, valid)
# Next Shift would be 48, which exceeds 29, so the shifting loop halts.
#
# SUBTRACTION & ACCUMULATION:
# abs_dividend -= temp_divisor  =>  29 - 24 = 5   (Remaining dividend pool)
# quotient += multiple          =>   0 +  8 = 8   (Accumulated quotient count)
#
# NEXT OUTER ITERATION:
# Remaining dividend is now 5. 'temp_divisor' resets to 3, 'multiple' resets to 1.
# Since 3 doubled is 6 (which is > 5), the inner shifting loop doesn't execute.
#
# FINAL REDUCTION:
# abs_dividend -= temp_divisor  =>   5 - 3 = 2
# quotient += multiple          =>   8 + 1 = 9
#
# The loop terminates because the remaining dividend (2) is less than abs_divisor (3).
# Resulting quotient is 9.
#
# Complexity:
# - Time Complexity: O((log N)^2) where N is the magnitude of the dividend. 
#   By doubling the divisor chunks, we bypass slow linear subtraction.
# - Space Complexity: O(1) as we purely manipulate standard primitive integer 
#   variables in memory without allocating structural overhead.