def is_palindrome(n):
    s = str(n)
    return s == s[::-1]


palindromes = (
    x * y
    for x in range(100, 1000)
    for y in range(x, 1000)
    if is_palindrome(x * y)
)
print(max(palindromes))
