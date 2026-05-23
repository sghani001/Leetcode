# @param {Integer} num
# @return {String}
def int_to_roman(num)
  roman_mapping = [
    [1000, 'M'],
    [900,  'CM'],
    [500,  'D'],
    [400,  'CD'],
    [100,  'C'],
    [90,   'XC'],
    [50,   'L'],
    [40,   'XL'],
    [10,   'X'],
    [9,    'IX'],
    [5,    'V'],
    [4,    'IV'],
    [1,    'I']
  ]

  result = ""

  roman_mapping.each do |value, symbol|
    while num >= value
      result << symbol
      num -= value
    end

    break if num == 0
  end

  result
end

# Explanation:
# Convert an integer to a Roman numeral by using a value-symbol mapping from
# largest to smallest. Repeatedly subtract the greatest value that fits into
# num and append the corresponding Roman symbol until the number reaches zero.
