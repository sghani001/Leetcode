# @param {Integer[]} nums
# @return {Integer[]}
def separate_digits(nums)
  nums.flat_map do |num|
    num.to_s.chars.map(&:to_i)
  end
  # =========================================================================
  #                           EXPLANATION
  # =========================================================================
  #
  # HOW THE ENUMERABLE METHODS WORK TOGETHER:
  # Ruby provides highly powerful built-in methods that allow us to transform 
  # and restructure data smoothly without tracking index loops manually.
  #
  # 1. `flat_map`:
  #    This method acts like a combination of `.map` and `.flatten`. It loops 
  #    through each number in `nums`, executes the block, and then automatically 
  #    merges the resulting sub-arrays into a single flat array.
  #
  # 2. `num.to_s.chars`:
  #    Inside the block, we first convert the integer to a string using `.to_s` 
  #    (e.g., 13 becomes "13"). Then, `.chars` splits that string into an array 
  #    of individual string characters (e.g., ["1", "3"]).
  #
  # 3. `.map(&:to_i)`:
  #    This converts each string character back into an actual integer type 
  #    (e.g., ["1", "3"] becomes [1, 3]).
  #
  # TRACING EXAMPLE 1: `nums = [13, 25]`
  # * Processing 13 -> converted to "13" -> chars ["1", "3"] -> integers [1, 3]
  # * Processing 25 -> converted to "25" -> chars ["2", "5"] -> integers [2, 5]
  # * `flat_map` merges [1, 3] and [2, 5] into the final answer: [1, 3, 2, 5]
  #
  # COMPLEXITY:
  # * Time Complexity: O(D) where D is the total number of digits across all 
  #   integers in the array. Converting and iterating through characters scales 
  #   linearly with the total digit count.
  # * Space Complexity: O(D) memory to store and output the collection of digits.
  # =========================================================================
end
