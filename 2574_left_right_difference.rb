def left_right_difference(nums)
  right_sum = nums.sum
  left_sum = 0
  
  # Map transforms each element into the calculated absolute difference
  nums.map do |num|
    # Current number is no longer to the right
    right_sum -= num
    
    # Calculate absolute difference
    difference = (left_sum - right_sum).abs
    
    # Current number is now to the left of the next elements
    left_sum += num
    
    difference
  end
end
