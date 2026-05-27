# @param {String} word
# @return {Integer}
def number_of_special_chars(word)
  # 1. Initialize bit-tracking arrays for 26 English alphabet slots
  seen_lower = Array.new(26, false)
  seen_upper = Array.new(26, false)
  invalid = Array.new(26, false)

  # 2. Process characters sequentially left-to-right
  word.each_char do |char|
    if char == char.downcase
      # Map lowercase character ('a'-'z') to alphabet slot index (0-25)
      idx = char.ord - 'a'.ord
      seen_lower[idx] = true

      # The Rule Violation Trap:
      # If we spot a lowercase letter AFTER we have already recorded its
      # uppercase counterpart, this letter permanently breaks sequence rules.
      if seen_upper[idx]
        invalid[idx] = true
      end
    else
      # Map uppercase character ('A'-'Z') to alphabet slot index (0-25)
      idx = char.ord - 'A'.ord
      seen_upper[idx] = true
    end
  end

  # 3. Final Evaluation Pass
  count = 0
  0.upto(25) do |i|
    # A letter is strictly special if it appeared in both forms 
    # and managed to avoid triggering the chronological violation trap.
    count += 1 if seen_lower[i] && seen_upper[i] && !invalid[i]
  end

  # 4. Return total accumulated score
  count
end

# ==============================================================================
# EXPLANATION OF THE STATE TRACKING STRATEGY
# ==============================================================================
# Let's trace one single validation run for a problem segment: word = "aAa"
# Initially: All 26 slots inside seen_lower, seen_upper, and invalid are false.
#
# CHARACTER STREAM PROCESSING:
# Step 1: Inspecting index 0 ('a')
#        - It maps to index 0 of our tracking system.
#        - seen_lower[0] flips to true.
#        - Code checks seen_upper[0], which is currently false. Nothing breaks.
#
# Step 2: Inspecting index 1 ('A')
#        - It maps to index 0 of our tracking system.
#        - seen_upper[0] flips to true.
#
# Step 3: Inspecting index 2 ('a')
#        - It maps to index 0 of our tracking system.
#        - seen_lower[0] remains true.
#        - THE TRAP TRIGGERS: The code checks seen_upper[0]. Because it was 
#          turned true in Step 2, this lowercase letter has appeared AFTER 
#          its uppercase version.
#        - invalid[0] permanently flips to true.
#
# FINAL AUDIT PASS:
# The algorithm executes an independent loop from index 0 to 25 evaluating 
# the tracking state of each letter:
# - For letter index 0 ('a'/'A'), it checks: 
#   seen_lower[0] (True) && seen_upper[0] (True) && !invalid[0] (False).
# - Since invalid[0] is true, this letter fails the logic check and the 
#   total counter remains 0.
#
# Complexity:
# - Time Complexity: O(N) where N is the total length of the string 'word'.
#   The program evaluates each character in the string exactly once, followed 
#   by a fixed constant lookup loop of 26 steps.
# - Space Complexity: O(1) constant overhead. The solution stores precisely 
#   3 fixed arrays of 26 booleans each, ensuring it scales cleanly regardless 
#   of input sizing.



# Another way to do it.

def number_of_special_chars(word)
  # Find all characters that exist in both lowercase and uppercase
  lowers = word.scan(/[a-z]/).uniq
  uppers = word.scan(/[A-Z]/).uniq
  
  # The intersection gives us characters present in both forms
  candidates = lowers & uppers.map(&:downcase)

  candidates.count do |char|
    # Reject the character if the word contains the Uppercase followed 
    # by any characters and then the Lowercase.
    # e.g., /A.*a/
    regex = /#{char.upcase}.*#{char}/
    
    !word.match?(regex)
  end
end