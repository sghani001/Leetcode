def earliest_finish_time(land_start_time, land_duration, water_start_time, water_duration)
  best_first_land_finish = Float::INFINITY
  land_start_time.each_with_index do |start, i|
    finish = start + land_duration[i]
    best_first_land_finish = finish if finish < best_first_land_finish
  end

  ans1 = Float::INFINITY
  water_start_time.each_with_index do |start, j|
    water_start = [best_first_land_finish, start].max
    final_finish = water_start + water_duration[j]
    ans1 = final_finish if final_finish < ans1
  end

  best_first_water_finish = Float::INFINITY
  water_start_time.each_with_index do |start, j|
    finish = start + water_duration[j]
    best_first_water_finish = finish if finish < best_first_water_finish
  end

  ans2 = Float::INFINITY
  land_start_time.each_with_index do |start, i|
    land_start = [best_first_water_finish, start].max
    final_finish = land_start + land_duration[i]
    ans2 = final_finish if final_finish < ans2
  end

  [ans1, ans2].min
end

# =============================================================================
# EXPLANATION OF THE CODE ABOVE:
# =============================================================================
#
# 1. THE GREEDY APPROACH (O(N + M) Complexity)
#    Instead of running a nested loop to check every single combination of land
#    and water rides—which takes O(N * M) time—this solution splits the problem 
#    into two linear, sequential passes. 
#
#    The underlying insight is that to minimize the total time, the first ride 
#    you take should finish as early as possible. This leaves the widest 
#    possible window open to complete the second ride.
#
# 2. SCENARIO 1: LAND RIDE FIRST -> THEN WATER RIDE
#    - First, we iterate through the land rides array to compute `start + duration` 
#      for each option. We capture the absolute minimum finish time out of all of 
#      them and store it in `best_first_land_finish`.
#    - Next, we iterate through the water rides array. The time you can actually 
#      board a given water ride is determined by `[best_first_land_finish, start].max`. 
#      This handles cases where the water ride is either already open (so you start 
#      immediately at `best_first_land_finish`) or hasn't opened yet (forcing you to 
#      wait until `start`).
#    - We track the lowest final finish time for this order in `ans1`.
#
# 3. SCENARIO 2: WATER RIDE FIRST -> THEN LAND RIDE
#    - We mirror the exact same logic for the opposite sequence. We look through all 
#      water rides to find the single one that clears out the earliest, storing that 
#      timestamp in `best_first_water_finish`.
#    - Then, we loop through the land rides array to determine the earliest possible 
#      boarding time for each option based on `[best_first_water_finish, start].max`.
#    - We track the lowest final finish time for this sequence in `ans2`.
#
# 4. FINAL SELECTION
#    - At the very last line, the method compares `ans1` and `ans2` using `[ans1, ans2].min`. 
#      This returns the absolute best finish time achieved between both sequence tracks.
#
# =============================================================================
