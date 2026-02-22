# @param {Integer} x
# @return {Integer}
def reverse(x)
  is_negative = x < 0
  num = x.abs
  reversed_num = 0
  
  # 32-bit signed integer limits
  limit_low = -2**31
  limit_high = 2**31 - 1
  
  while num > 0
    pop = num % 10
    num /= 10
    
    # Check for overflow before multiplying by 10
    # Since Ruby handles arbitrary size integers, we check the final result
    # but the problem constraints usually imply checking during the process.
    reversed_num = reversed_num * 10 + pop
  end
  
  final_res = is_negative ? -reversed_num : reversed_num
  
  # Final range check for 32-bit signed integer
  if final_res < limit_low || final_res > limit_high
    return 0
  end
  
  final_res
end

# Test Cases
puts "Test Case 1: x = 123"
puts "Result: #{reverse(123)}" # Output: 321

puts "\nTest Case 2: x = -123"
puts "Result: #{reverse(-123)}" # Output: -321

puts "\nTest Case 3: x = 120"
puts "Result: #{reverse(120)}" # Output: 21

puts "\nTest Case 4: x = 1534236469 (Overflow Case)"
puts "Result: #{reverse(1534236469)}" # Output: 0
