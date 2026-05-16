# @param {Integer[]} digits
# @return {Integer[]}
def plus_one(digits)
  # Start from the last index and move backwards down to 0
  (digits.length - 1).downto(0) do |i|
    # If the current digit is less than 9, just add 1 and return early
    if digits[i] < 9
      digits[i] += 1
      return digits
    end
    
    # If the digit is 9, it becomes 0, and the loop continues to carry the 1
    digits[i] = 0
  end
  
  # If the loop finishes, it means the number was all 9s (e.g., [9, 9, 9] -> [0, 0, 0])
  # Prepend a 1 to the front of the array
  digits.unshift(1)
end

# Test Cases
if __FILE__ == $0
  puts "Running tests..."

  test_cases = [
    { digits: [1, 2, 3], expected: [1, 2, 4] },
    { digits: [4, 3, 2, 1], expected: [4, 3, 2, 2] },
    { digits: [9], expected: [1, 0] },
    { digits: [9, 9, 9], expected: [1, 0, 0, 0] }
  ]

  test_cases.each_with_index do |tc, idx|
    # Duplicate input to avoid modifying the original during test comparison if needed
    input = tc[:digits].dup
    result = plus_one(input)
    if result == tc[:expected]
      puts "Test Case #{idx + 1}: Passed (Result: #{result.inspect})"
    else
      puts "Test Case #{idx + 1}: Failed (Expected: #{tc[:expected].inspect}, Got: #{result.inspect})"
    end
  end
end
