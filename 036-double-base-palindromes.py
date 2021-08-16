from collections import deque


def is_palindrome(n, base):
    digits = deque()
    copy_n = n
    while copy_n:
        digits.append(copy_n % base)
        copy_n //= base

    rev_n = 0
    while digits:
        rev_n *= base
        rev_n += digits.popleft()
    return n == rev_n


print(
    sum(n for n in range(1, 1000000, 2) if is_palindrome(n, 2) and is_palindrome(n, 10))
)
