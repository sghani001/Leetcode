class Solution:
    def minimumCost(self, cost: List[int]) -> int:
        # 1. Sort descending to group the most expensive candies together
        cost.sort(reverse=True)
        
        # 2. cost[2::3] slices every 3rd element starting from index 2 (2, 5, 8...)
        #    Because it's sorted descending, these are always the free candies.
        # 3. Subtract the sum of free candies from the total sum.
        return sum(cost) - sum(cost[2::3])
