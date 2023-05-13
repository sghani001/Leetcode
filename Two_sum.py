class Solution:
    def twoSum(self, nums: List[int], target: int):
        t_list=set()
        for i in range(len(nums)):
            for j in range(i+1,len(nums)):
                if(nums[i]+nums[j]==target):
                    t_list.add(i)
                    t_list.add(j)
        return t_list
