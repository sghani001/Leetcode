# @param {Integer[]} nums1
# @param {Integer} m
# @param {Integer[]} nums2
# @param {Integer} n
# @return {Void} Do not return anything, modify nums1 in-place instead.
def merge(nums1, m, nums2, n)
  # Initialize pointers for both arrays and the write position
  p1 = m - 1
  p2 = n - 1
  p  = m + n - 1

  # Loop while there are still elements to compare in both arrays
  while p1 >= 0 && p2 >= 0
    if nums1[p1] > nums2[p2]
      nums1[p] = nums1[p1]
      p1 -= 1
    else
      nums1[p] = nums2[p2]
      p2 -= 1
    end
    p -= 1
  end

  # Edge case: If nums1 elements ran out first, there might still be 
  # elements left over in nums2. Copy them over.
  # (If nums2 ran out first, the remaining elements in nums1 are already in place!)
  while p2 >= 0
    nums1[p] = nums2[p2]
    p2 -= 1
    p -= 1
  end
end

# Test Cases
if __FILE__ == $0
  puts "Running tests..."

  test_cases = [
    { nums1: [1, 2, 3, 0, 0, 0], m: 3, nums2: [2, 5, 6], n: 3, expected: [1, 2, 2, 3, 5, 6] },
    { nums1: [1], m: 1, nums2: [], n: 0, expected: [1] },
    { nums1: [0], m: 0, nums2: [1], n: 1, expected: [1] }
  ]

  test_cases.each_with_index do |tc, idx|
    nums1 = tc[:nums1].dup
    merge(nums1, tc[:m], tc[:nums2], tc[:n])
    if nums1 == tc[:expected]
      puts "Test Case #{idx + 1}: Passed (Result: #{nums1.inspect})"
    else
      puts "Test Case #{idx + 1}: Failed (Expected: #{tc[:expected].inspect}, Got: #{nums1.inspect})"
    end
  end
end
