# Given an integer x, return true if x is a 
# palindrome
# , and false otherwise.



# Input: x = 121
# Output: true
# Explanation: 121 reads as 121 from left to right and from right to left.

class Solution:
    def isPalindrome(self, x: int) -> bool:
        x=str(x)
        y=x[::-1]
        if x==y:
            return True
        else:
            return False
