class Solution:
    def letterCombinations(self, digits: str) -> list[str]:
        if not digits:
            return []

        phone_map = {
            "2": "abc",
            "3": "def",
            "4": "ghi",
            "5": "jkl",
            "6": "mno",
            "7": "pqrs",
            "8": "tuv",
            "9": "wxyz",
        }

        res = []

        def backtrack(index: int, path: list[str]) -> None:
            # Base case: current combination matches the length of digits
            if index == len(digits):
                res.append("".join(path))
                return

            # Explore every letter mapped to the current digit
            for letter in phone_map[digits[index]]:
                path.append(letter)
                backtrack(index + 1, path)
                path.pop()  # Backtrack to try the next letter

        backtrack(0, [])
        return res