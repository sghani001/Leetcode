# @param {Integer[]} land_start_time
# @param {Integer[]} land_duration
# @param {Integer[]} water_start_time
# @param {Integer[]} water_duration
# @return {Integer}
def earliest_finish_time(land_start_time, land_duration, water_start_time, water_duration)
  # Calculate best finish time for both order variations
  ans1 = solve_ordered(land_start_time, land_duration, water_start_time, water_duration)
  ans2 = solve_ordered(water_start_time, water_duration, land_start_time, land_duration)
  
  [ans1, ans2].min
end

private

# Helper to find the minimum finish time strictly assuming Category 1 -> Category 2
def solve_ordered(start1, dur1, start2, dur2)
  # Pair and sort Category 2 by its start times
  cat2 = start2.zip(dur2).sort_by { |s, d| s }
  n2 = cat2.length

  # prefix_min_dur[i] stores the minimum duration in cat2 from index 0..i
  prefix_min_dur = Array.new(n2)
  curr_min = Float::INFINITY
  cat2.each_with_index do |(s, d), i|
    curr_min = [curr_min, d].min
    prefix_min_dur[i] = curr_min
  end

  # suffix_min_total[i] stores the minimum (start + duration) in cat2 from index i..(n2-1)
  suffix_min_total = Array.new(n2)
  curr_min = Float::INFINITY
  (n2 - 1).downto(0) do |i|
    s, d = cat2[i]
    curr_min = [curr_min, s + d].min
    suffix_min_total[i] = curr_min
  end

  min_overall_finish = Float::INFINITY

  # Evaluate each ride from Category 1
  start1.each_with_index do |s1, i|
    f1 = s1 + dur1[i] # Finish time of the first ride

    # Binary search to find the first ride in cat2 that opens strictly after f1
    # We want to find the first index where cat2[idx][0] > f1
    idx = cat2.bsearch_index { |s2, _| s2 > f1 } || n2

    # Case A: Second ride is already open when we finish ride 1 (index < idx)
    if idx > 0
      best_dur = prefix_min_dur[idx - 1]
      min_overall_finish = [min_overall_finish, f1 + best_dur].min
    end

    # Case B: We have to wait for the second ride to open (index >= idx)
    if idx < n2
      best_total = suffix_min_total[idx]
      min_overall_finish = [min_overall_finish, best_total].min
    end
  end

  min_overall_finish
end
