def length_of_last_word(s)
    substrings = s.strip.split
    len = substrings.length
    return substrings[len - 1].length
end
