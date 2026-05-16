# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer}
def three_sum_closest(nums, target)
  nums.sort!
  n = nums.length
  closest_sum = nums[0] + nums[1] + nums[2]

  (0..n - 3).each do |i|
    # Optimization: skip duplicates for the first element
    next if i > 0 && nums[i] == nums[i - 1]

    left = i + 1
    right = n - 1

    while left < right
      current_sum = nums[i] + nums[left] + nums[right]

      return current_sum if current_sum == target

      if (current_sum - target).abs < (closest_sum - target).abs
        closest_sum = current_sum
      end

      if current_sum < target
        left += 1
      else
        right -= 1
      end
    end
  end

  closest_sum
end

# Test Cases
if __FILE__ == $0
  puts "Running tests..."

  test_cases = [
    { nums: [-1, 2, 1, -4], target: 1, expected: 2 },
    { nums: [0, 0, 0], target: 1, expected: 0 },
    { nums: [1, 1, 1, 0], target: -100, expected: 2 },
    { nums: [4, 0, 5, -5, 3, 3, 0, -4, -5], target: -2, expected: -2 }
  ]

  test_cases.each_with_index do |tc, idx|
    result = three_sum_closest(tc[:nums], tc[:target])
    if result == tc[:expected]
      puts "Test Case #{idx + 1}: Passed (Result: #{result})"
    else
      puts "Test Case #{idx + 1}: Failed (Expected: #{tc[:expected]}, Got: #{result})"
    end
  end
end
