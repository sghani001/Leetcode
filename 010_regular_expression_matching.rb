# @param {String} s
# @param {String} p
# @return {Boolean}
def is_match(s, p)
  m, n = s.length, p.length
  # dp[i][j] will be true if s[0...i] matches p[0...j]
  dp = Array.new(m + 1) { Array.new(n + 1, false) }
  
  # Base case: empty string matches empty pattern
  dp[0][0] = true
  
  # Handle patterns like a*, a*b*, a*b*c* which can match an empty string
  (1..n).each do |j|
    if p[j - 1] == '*'
      dp[0][j] = dp[0][j - 2]
    end
  end
  
  (1..m).each do |i|
    (1..n).each do |j|
      if p[j - 1] == s[i - 1] || p[j - 1] == '.'
        dp[i][j] = dp[i - 1][j - 1]
      elsif p[j - 1] == '*'
        # Case 1: Match zero occurrences of the preceding element
        # We look at the result of matching p[0...j-2]
        dp[i][j] = dp[i][j - 2]
        
        # Case 2: Match one or more occurrences of the preceding element
        # If the preceding element in p matches current character in s
        if p[j - 2] == s[i - 1] || p[j - 2] == '.'
          dp[i][j] = dp[i][j] || dp[i - 1][j]
        end
      end
    end
  end
  
  dp[m][n]
end

# Test Cases
puts "Test Case 1: s = \"aa\", p = \"a\""
puts "Result: #{is_match("aa", "a")}" # Output: false

puts "\nTest Case 2: s = \"aa\", p = \"a*\""
puts "Result: #{is_match("aa", "a*")}" # Output: true

puts "\nTest Case 3: s = \"ab\", p = \".*\""
puts "Result: #{is_match("ab", ".*")}" # Output: true

puts "\nTest Case 4: s = \"aab\", p = \"c*a*b\""
puts "Result: #{is_match("aab", "c*a*b")}" # Output: true

puts "\nTest Case 5: s = \"mississippi\", p = \"mis*is*p*.\""
puts "Result: #{is_match("mississippi", "mis*is*p*.")}" # Output: false
