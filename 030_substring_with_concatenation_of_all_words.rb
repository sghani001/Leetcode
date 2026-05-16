# @param {String} s
# @param {String[]} words
# @return {Integer[]}
def find_substring(s, words)
  return [] if s.empty? || words.empty?
  
  word_len = words[0].length
  num_words = words.length
  total_len = word_len * num_words
  s_len = s.length
  
  # Frequency map of words
  word_counts = Hash.new(0)
  words.each { |w| word_counts[w] += 1 }
  
  result = []
  
  # We only need to check from 0 to word_len - 1 as starting offsets
  # for the sliding window to cover all possible word boundaries.
  (0...word_len).each do |offset|
    left = offset
    right = offset
    current_counts = Hash.new(0)
    words_used = 0
    
    while right + word_len <= s_len
      word = s[right, word_len]
      right += word_len
      
      if word_counts.key?(word)
        current_counts[word] += 1
        words_used += 1
        
        # If we used more of 'word' than available, slide left until valid
        while current_counts[word] > word_counts[word]
          left_word = s[left, word_len]
          current_counts[left_word] -= 1
          words_used -= 1
          left += word_len
        end
        
        # If we have all words, we found a match
        if words_used == num_words
          result << left
        end
      else
        # Not a valid word, reset everything
        current_counts.clear
        words_used = 0
        left = right
      end
    end
  end
  
  result
end

# Test Cases
puts "Test Case 1: s = 'barfoothefoobarman', words = ['foo','bar']"
puts "Result: #{find_substring('barfoothefoobarman', ['foo', 'bar']).sort.inspect}" 
# Output: [0, 9]

puts "\nTest Case 2: s = 'wordgoodgoodgoodbestword', words = ['word','good','best','word']"
puts "Result: #{find_substring('wordgoodgoodgoodbestword', ['word', 'good', 'best', 'word']).inspect}" 
# Output: []

puts "\nTest Case 3: s = 'barfoofoobarthefoobarman', words = ['bar','foo','the']"
puts "Result: #{find_substring('barfoofoobarthefoobarman', ['bar', 'foo', 'the']).sort.inspect}" 
# Output: [6, 9, 12]
