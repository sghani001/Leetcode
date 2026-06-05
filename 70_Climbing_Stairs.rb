def climb_stairs(n)
  # Base cases
  return n if n <= 2

  first = 1  # Ways to reach step 1
  second = 2 # Ways to reach step 2

  (3..n).each do
    current = first + second
    first = second
    second = current
  end

  second
end
