# @param {String} s
# @return {String}
def longest_palindrome(s)
  return "" if s.nil? || s.length < 1
  
  start = 0
  max_len = 0
  
  (0...s.length).each do |i|
    # Check for odd length palindromes (e.g., "aba")
    len1 = expand_around_center(s, i, i)
    # Check for even length palindromes (e.g., "bb")
    len2 = expand_around_center(s, i, i + 1)
    
    current_max = [len1, len2].max
    
    if current_max > max_len
      max_len = current_max
      # Calculate the start index of the palindrome
      # If current_max is 3 (odd): start = i - (3-1)/2 = i - 1
      # If current_max is 2 (even): start = i - (2-1)/2 = i - 0 = i
      start = i - (current_max - 1) / 2
    end
  end
  
  s[start, max_len]
end

def expand_around_center(s, left, right)
  while left >= 0 && right < s.length && s[left] == s[right]
    left -= 1
    right += 1
  end
  # Length is (right - 1) - (left + 1) + 1 = right - left - 1
  right - left - 1
end

# Test Cases
puts "Test Case 1: s = \"babad\""
puts "Result: #{longest_palindrome("babad")}" # Output: "bab" or "aba"

puts "\nTest Case 2: s = \"cbbd\""
puts "Result: #{longest_palindrome("cbbd")}" # Output: "bb"

puts "\nTest Case 3: s = \"a\""
puts "Result: #{longest_palindrome("a")}" # Output: "a"

puts "\nTest Case 4: s = \"ac\""
puts "Result: #{longest_palindrome("ac")}" # Output: "a" or "c"

puts "\nTest Case 5: s = \"racecar\""
puts "Result: #{longest_palindrome("racecar")}" # Output: "racecar"
