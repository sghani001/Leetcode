def total_waviness(num1, num2)
  count_up_to(num2) - count_up_to(num1 - 1)
end

private

def count_up_to(n)
  return 0 if n < 100

  digits = n.to_s.chars.map(&:to_i)
  @memo = {}
  @suffix_memo = {}
  
  # State variables:
  # idx             -> Current digit position we are filling
  # is_tight        -> True if matching the upper bound prefix of n
  # is_leading_zero -> True if we haven't started placing non-zero digits yet
  # prev_digit      -> The digit placed right before this one
  # prev_trend      -> 0 = flat/none, 1 = increasing (\nearrow), 2 = decreasing (\searrow)
  solve(digits, 0, true, true, -1, 0)
end

def solve(digits, idx, is_tight, is_leading_zero, prev_digit, prev_trend)
  # Base Case: processed all digits
  return 0 if idx == digits.length

  memo_key = [idx, is_tight, is_leading_zero, prev_digit, prev_trend]
  return @memo[memo_key] if @memo.key?(memo_key)

  limit = is_tight ? digits[idx] : 9
  total_waviness = 0

  (0..limit).each do |d|
    next_tight = is_tight && (d == limit)
    
    if is_leading_zero && d == 0
      # Keep skipping leading zeros safely
      total_waviness += solve(digits, idx + 1, next_tight, true, -1, 0)
    else
      wave_contribution = 0
      next_trend = 0

      unless is_leading_zero
        if d > prev_digit
          next_trend = 1 
          # Turned upward after going down -> Valley detected at prev_digit
          wave_contribution = 1 if prev_trend == 2
        elsif d < prev_digit
          next_trend = 2 
          # Turned downward after going up -> Peak detected at prev_digit
          wave_contribution = 1 if prev_trend == 1
        else
          next_trend = 0 # Plateau breaks the wavy property
        end
      end

      # 1. Fetch waves generated deeper in the recursion tree
      future_waves = solve(digits, idx + 1, next_tight, false, d, next_trend)
      
      # 2. Add current wave contribution multiplied by remaining choices
      if wave_contribution > 0
        suffixes = count_valid_suffixes(digits, idx + 1, next_tight)
        total_waviness += (wave_contribution * suffixes)
      end
      
      total_waviness += future_waves
    end
  end

  @memo[memo_key] = total_waviness
end

# Fast math count of how many suffixes can be completed from this branch
def count_valid_suffixes(digits, idx, is_tight)
  return 1 if idx == digits.length
  
  key = [idx, is_tight]
  return @suffix_memo[key] if @suffix_memo.key?(key)

  limit = is_tight ? digits[idx] : 9
  count = 0
  (0..limit).each do |d|
    count += count_valid_suffixes(digits, idx + 1, is_tight && (d == limit))
  end
  
  @suffix_memo[key] = count
end
