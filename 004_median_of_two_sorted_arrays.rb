# @param {Integer[]} nums1
# @param {Integer[]} nums2
# @return {Float}
def find_median_sorted_arrays(nums1, nums2)
  # Ensure nums1 is the smaller array to minimize the binary search range
  if nums1.length > nums2.length
    nums1, nums2 = nums2, nums1
  end

  m, n = nums1.length, nums2.length
  low = 0
  high = m
  half_len = (m + n + 1) / 2

  while low <= high
    i = (low + high) / 2
    j = half_len - i

    if i < m && nums2[j - 1] > nums1[i]
      # i is too small, must increase it
      low = i + 1
    elsif i > 0 && nums1[i - 1] > nums2[j]
      # i is too big, must decrease it
      high = i - 1
    else
      # i is perfect
      max_of_left = 0
      if i == 0
        max_of_left = nums2[j - 1]
      elsif j == 0
        max_of_left = nums1[i - 1]
      else
        max_of_left = [nums1[i - 1], nums2[j - 1]].max
      end

      if (m + n) % 2 == 1
        return max_of_left.to_f
      end

      min_of_right = 0
      if i == m
        min_of_right = nums2[j]
      elsif j == n
        min_of_right = nums1[i]
      else
        min_of_right = [nums1[i], nums2[j]].min
      end

      return (max_of_left + min_of_right) / 2.0
    end
  end

  0.0
end

# Test Cases
puts "Test Case 1: nums1 = [1,3], nums2 = [2]"
puts "Result: #{find_median_sorted_arrays([1, 3], [2])}" # Output: 2.0

puts "\nTest Case 2: nums1 = [1,2], nums2 = [3,4]"
puts "Result: #{find_median_sorted_arrays([1, 2], [3, 4])}" # Output: 2.5

puts "\nTest Case 3: nums1 = [0,0], nums2 = [0,0]"
puts "Result: #{find_median_sorted_arrays([0, 0], [0, 0])}" # Output: 0.0

puts "\nTest Case 4: nums1 = [], nums2 = [1]"
puts "Result: #{find_median_sorted_arrays([], [1])}" # Output: 1.0

puts "\nTest Case 5: nums1 = [2], nums2 = []"
puts "Result: #{find_median_sorted_arrays([2], [])}" # Output: 2.0
