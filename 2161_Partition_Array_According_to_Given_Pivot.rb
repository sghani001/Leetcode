def pivot_array(nums, pivot)
  less = nums.select { |x| x < pivot }
  equal = nums.select { |x| x == pivot }
  greater = nums.select { |x| x > pivot }
  
  less + equal + greater
end
