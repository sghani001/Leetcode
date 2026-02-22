# @param {String} s
# @param {Integer} num_rows
# @return {String}
def convert(s, num_rows)
  # Base case: if num_rows is 1 or string length is less than num_rows, no zigzag possible
  return s if num_rows == 1 || s.length <= num_rows

  # Initialize an array of strings, one for each row
  rows = Array.new([num_rows, s.length].min) { "" }
  current_row = 0
  going_down = false

  s.each_char do |char|
    rows[current_row] << char
    
    # Change direction when we reach the top or bottom row
    if current_row == 0 || current_row == num_rows - 1
      going_down = !going_down
    end
    
    current_row += going_down ? 1 : -1
  end

  # Join all rows to get the final result
  rows.join
end

# Test Cases
puts "Test Case 1: s = \"PAYPALISHIRING\", num_rows = 3"
puts "Result: #{convert("PAYPALISHIRING", 3)}" # Output: "PAHNAPLSIIGYIR"

puts "\nTest Case 2: s = \"PAYPALISHIRING\", num_rows = 4"
puts "Result: #{convert("PAYPALISHIRING", 4)}" # Output: "PINALSIGYAHRPI"

puts "\nTest Case 3: s = \"A\", num_rows = 1"
puts "Result: #{convert("A", 1)}" # Output: "A"

puts "\nTest Case 4: s = \"AB\", num_rows = 1"
puts "Result: #{convert("AB", 1)}" # Output: "AB"
