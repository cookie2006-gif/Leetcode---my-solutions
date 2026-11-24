class Solution:
    def combinationSum(self, candidates: list[int], target: int) -> list[list[int]]:
        res = []
        candidates.sort()  # Sorting enables early pruning when remaining < num

        def backtrack(start: int, path: list[int], remaining: int) -> None:
            if remaining == 0:
                res.append(path.copy())
                return

            for i in range(start, len(candidates)):
                num = candidates[i]
                # Since candidates is sorted, no subsequent number can fit either
                if num > remaining:
                    break

                path.append(num)
                # Pass `i` (not `i + 1`) because the same number can be reused
                backtrack(i, path, remaining - num)
                path.pop()  # Backtrack

        backtrack(0, [], target)
        return res
        