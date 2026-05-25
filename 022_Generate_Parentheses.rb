# @param {Integer} n
# @return {String[]}
def generate_parenthesis(n)
  result = []
  backtrack(result, "", 0, 0, n)
  result
end

private

def backtrack(result, current, open_count, close_count, max)
  # Base Case: If the string is complete, save it and stop
  if current.length == max * 2
    result << current
    return
  end

  # Rule 1: We can always add an opening bracket if we have some left
  backtrack(result, current + "(", open_count + 1, close_count, max) if open_count < max

  # Rule 2: We can only add a closing bracket if it pairs with an open one
  backtrack(result, current + ")", open_count, close_count + 1, max) if close_count < open_count
end

# ==============================================================================
# EXPLANATION
# ==============================================================================
# Why this is simpler and easy to grasp:
#
# 1. No Complex Syntax:
#    Instead of dealing with nested blocks or lambda variables (`.call`), we use 
#    a clean, standard private helper method. This makes the flow easy to read 
#    from top to bottom.
#
# 2. Ruby's Inline 'if' Modifiers:
#    Using inline `if` statements turns the core logic into just two elegant lines:
#    - Add "(" IF we haven't hit the max limit.
#    - Add ")" IF we have more opening brackets than closing ones.
#
# 3. How the Optimization Works (Decision Tree):
#    Instead of generating ALL possible combinations of brackets and then checking 
#    if they are valid (which is incredibly slow), this approach builds the tree 
#    safely. If a branch violates a rule, the code never runs that line—effectively 
#    "pruning" dead ends instantly.
#
# Complexity:
# - Time Complexity: O(4^n / sqrt(n)) - This is bounded by the Catalan number. 
#   It is theoretically impossible to go faster because this is exactly how many 
#   valid combinations exist; we spend zero time on invalid ones.
# - Space Complexity: O(n) - The max depth of the call stack matches the length 
#   of the string sequence.