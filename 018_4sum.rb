# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer[][]}
def four_sum(nums, target)
  return [] if nums.nil? || nums.length < 4

  nums.sort! 
  n = nums.length
  pair_sums = {}
  unique_quads = {}

  # Step 1: Precompute all pair sums and store their indices
  (0...n).each do |i|
    (i + 1...n).each do |j|
      sum = nums[i] + nums[j]
      pair_sums[sum] ||= []
      pair_sums[sum] << [i, j]
    end
  end

  # Step 2: Find pairs that add up to the target
  (0...n).each do |i|
    next if i > 0 && nums[i] == nums[i - 1] 

    (i + 1...n).each do |j|
      next if j > i + 1 && nums[j] == nums[j - 1]

      current_sum = nums[i] + nums[j]
      complement = target - current_sum

      next unless pair_sums.key?(complement)

      # Step 3: Validate that indices don't overlap
      pair_sums[complement].each do |p1, p2|
        if j < p1
          quad = [nums[i], nums[j], nums[p1], nums[p2]]
          unique_quads[quad] = true
        end
      end
    end
  end

  unique_quads.keys
end

# ==============================================================================
# HOW THIS SOLUTION WORKS (STEP-BY-STEP BREAKDOWN)
# ==============================================================================
# 
# THE OVERALL CONCEPT:
# Instead of looking for 4 individual numbers one by one (which takes 3 to 4 loops), 
# we split the problem in half: Quadruplet = (Pair A) + (Pair B).
# If we know the sum of Pair A, we can instantly look up if a matching Pair B 
# exists in our memory that brings the total sum up to our target.
#
# ------------------------------------------------------------------------------
# STEP 1: BUILDING THE MEMORY (PRECOMPUTING PAIRS)
# ------------------------------------------------------------------------------
# We run a nested loop through the array to find every single possible pair combination.
# For every pair, we calculate its sum and save the indices that made it.
#
# Example Array: nums = [1, 2, 3, 5], target = 11
# - When i=0 (val: 1) and j=1 (val: 2) -> Sum is 3. We save: pair_sums[3] = [[0, 1]]
# - When i=1 (val: 2) and j=2 (val: 3) -> Sum is 5. We save: pair_sums[5] = [[1, 2]]
# - When i=2 (val: 3) and j=3 (val: 5) -> Sum is 8. We save: pair_sums[8] = [[2, 3]]
#
# By the end of Step 1, `pair_sums` is a complete dictionary of every pair sum available.
#
# ------------------------------------------------------------------------------
# STEP 2: SCANNING AND FINDING MATCHES (THE COMPLEMENT LOOKUP)
# ------------------------------------------------------------------------------
# We loop through all pairs a second time. This represents our "Pair A".
# Let's say our current Pair A has a sum of 3. 
# We need our total to equal 11 (target), so we calculate: 11 - 3 = 8.
# 8 is our "complement". We instantly check our dictionary: "Hey, do we have a Pair B 
# that sums up to 8?" 
# Yes we do! `pair_sums[8]` contains the indices `[2, 3]`.
#
# ------------------------------------------------------------------------------
# STEP 3: THE INDICES OVERLAP CHECK (THE CRITICAL GUARDRAIL)
# ------------------------------------------------------------------------------
# A valid quadruplet requires 4 completely DISTINCT numbers from the array. 
# We cannot reuse the same element twice. 
#
# Our current Pair A uses indices [i, j]. Our found Pair B uses indices [p1, p2].
# To ensure there is absolutely zero overlap, we check if `j < p1`.
# Because the array indices are processed in order from left to right, forcing 
# i < j < p1 < p2 guarantees two massive wins:
#   1. No index is shared between the two pairs.
#   2. It naturally prevents duplicate combinations (e.g., if we already processed 
#      indices [0,1] with [2,3], it blocks us from processing [2,3] with [0,1] later).
#
# ------------------------------------------------------------------------------
# STEP 4: CLEANING UP DUPES
# ------------------------------------------------------------------------------
# Since we sorted `nums` at the very beginning:
# 1. We use `next if ... == ...` on the outer loops to skip identical adjacent numbers.
# 2. We store our matching values inside the keys of a hash map (`unique_quads[quad] = true`).
#    Hashes cannot have duplicate keys, so any identical numerical results override 
#    each other, leaving us with a perfectly clean array of unique quadruplets at the end.
# ==============================================================================
