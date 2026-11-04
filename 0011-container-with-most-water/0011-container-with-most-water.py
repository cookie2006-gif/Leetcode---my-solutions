class Solution:
    def maxArea(self, height: List[int]) -> int:
        n = len(height)
        max_water = float('-inf')
        i = 0
        j = n - 1
        while i < j:
            curr_water = (j-i)*min(height[i], height[j])
            max_water = max(max_water, curr_water)
            if height[i] < height[j]:
                i += 1
            else: 
                j -= 1
        return max_water
        
