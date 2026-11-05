class Solution:
    def wordBreak(self, s: str, wordDict: list[str]) -> bool:
        n = len(s)
        words = set(wordDict)
        dp = [False] * (n+1)
        # dp[i]: check if first i characters of s can be segmented into space-separated sequence of one or more dictionary words
        dp[0] = True
        for i in range(1, n+1):
            for j in range(i):
                if dp[j] and s[j:i] in words:
                    dp[i] = True
                    break
        return dp[n]


            

        

