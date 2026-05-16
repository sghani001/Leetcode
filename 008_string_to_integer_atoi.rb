# @param {String} s
# @return {Integer}
def my_atoi(s)
  return 0 if s.nil? || s.empty?

  i = 0
  n = s.length
  
  # 1. Ignore leading whitespace
  while i < n && s[i] == ' '
    i += 1
  end

  return 0 if i == n

  # 2. Check for sign
  sign = 1
  if s[i] == '+'
    sign = 1
    i += 1
  elsif s[i] == '-'
    sign = -1
    i += 1
  end

  # 3. Read digits
  res = 0
  while i < n && s[i] >= '0' && s[i] <= '9'
    digit = s[i].to_i
    res = res * 10 + digit
    i += 1
  end

  res *= sign

  # 4. Rounding (Clamping to 32-bit signed integer range)
  min_val = -2**31
  max_val = 2**31 - 1

  if res < min_val
    return min_val
  elsif res > max_val
    return max_val
  end

  res
end

# Test Cases
puts "Test Case 1: s = \"42\""
puts "Result: #{my_atoi("42")}" # Output: 42

puts "\nTest Case 2: s = \"   -042\""
puts "Result: #{my_atoi("   -042")}" # Output: -42

puts "\nTest Case 3: s = \"1337c0d3\""
puts "Result: #{my_atoi("1337c0d3")}" # Output: 1337

puts "\nTest Case 4: s = \"0-1\""
puts "Result: #{my_atoi("0-1")}" # Output: 0

puts "\nTest Case 5: s = \"words and 987\""
puts "Result: #{my_atoi("words and 987")}" # Output: 0

puts "\nTest Case 6: Out of range"
puts "Result: #{my_atoi("-91283472332")}" # Output: -2147483648
