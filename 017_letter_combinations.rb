def letter_combinations(digits)
  return [] if digits.empty?

  keypad = {
    '2' => ['a', 'b', 'c'], '3' => ['d', 'e', 'f'], '4' => ['g', 'h', 'i'],
    '5' => ['j', 'k', 'l'], '6' => ['m', 'n', 'o'], '7' => ['p', 'q', 'r', 's'],
    '8' => ['t', 'u', 'v'], '9' => ['w', 'x', 'y', 'z']
  }

  # 1. Map digits to their letters
  letter_lists = digits.chars.map { |d| keypad[d] }

  # 2. Build all possible combinations using reduce and Array#product
  raw_combinations = letter_lists.reduce do |built, incoming|
    built.product(incoming)
  end

  # 3. Convert each nested combination into a joined string
  return raw_combinations if raw_combinations.first.is_a?(String)

  raw_combinations.map { |combo| combo.flatten.join }
end

# Explanation:
# Convert each digit into its corresponding keypad letters, then build all
# possible letter sequences by successively taking the Cartesian product of
# letter groups. Finally, flatten each tuple into a string to return all valid
# phone number letter combinations.
