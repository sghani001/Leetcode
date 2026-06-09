def max_total_value(nums, k)
  return 0 if nums.empty?

  # Find the absolute min and max in a single pass
  min_val, max_val = nums.minmax

  # Multiply the maximum single subarray value by k
  k * (max_val - min_val)
end
