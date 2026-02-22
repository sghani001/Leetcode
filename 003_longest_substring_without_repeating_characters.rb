# @param {String} s
# @return {Integer}
def length_of_longest_substring(s)
  char_map = {} # stores the last index of each character
  max_length = 0
  start_index = 0

  s.each_char.with_index do |char, index|
    # If the character is already in the map and its index is within the current window
    if char_map.key?(char) && char_map[char] >= start_index
      # Move the start_index to one position after the previous occurrence
      start_index = char_map[char] + 1
    end

    # Update the last seen index of the character
    char_map[char] = index
    # Calculate the current window length and update max_length
    max_length = [max_length, index - start_index + 1].max
  end

  max_length
end

# Test cases
puts "Test Case 1: s = \"abcabcbb\""
puts "Result: #{length_of_longest_substring("abcabcbb")}" # Output: 3

puts "\nTest Case 2: s = \"bbbbb\""
puts "Result: #{length_of_longest_substring("bbbbb")}" # Output: 1

puts "\nTest Case 3: s = \"pwwkew\""
puts "Result: #{length_of_longest_substring("pwwkew")}" # Output: 3

puts "\nTest Case 4: s = \"\""
puts "Result: #{length_of_longest_substring("")}" # Output: 0

puts "\nTest Case 5: s = \" \""
puts "Result: #{length_of_longest_substring(" ")}" # Output: 1
