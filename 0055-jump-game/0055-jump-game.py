class Solution:
    def canJump(self, nums: list[int]) -> bool:
        n = len(nums)
        dp = [False] * n
        # dp[i]: There is a way from position i to reach the last index
        # dp[n-1] = True
        # for i in range(n-2,-1, -1):
        #     if nums[i] >= n-1-i:
        #         dp[i] = True
        #     else:
        #         for j in range(nums[i]+1):
        #             if dp[i+j]:
        #                 dp[i] = True
        #                 break
        # return dp[0]
        
        dp[n-1] = True
        for i in range(n-2, -1, -1):
            for j in range(1, nums[i]+1):
                if dp[i+j] or dp[(i+j)%n]:
                    dp[i] = True
                    break
        return dp[0]
    


        