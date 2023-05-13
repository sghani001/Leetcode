# Write a function to find the longest common prefix string amongst an array of strings.

# If there is no common prefix, return an empty string "".

 

# Example 1:

# Input: strs = ["flower","flow","flight"]
# Output: "fl"


class Solution:
    def longestCommonPrefix(self, strs: List[str]) -> str:
        prefix=list()
        flag=0
        index=0
        for i in range(len(min(strs, key=len))):
            if len(strs)==1:
                prefix.append(strs[0])
                break
            for j in range(len(strs)-1):
                if strs[j][i]==strs[j+1][i]:
                    flag=1
                    index=j
                else:
                    flag=0
                    break
            if flag==1:
                prefix.append(strs[index][i])
            else:
                break
        return ''.join(prefix)
