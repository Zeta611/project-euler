def digitsum(n):
    sum_ = 0
    while n >= 1:
        sum_ += n % 10
        n //= 10
    return sum_


def factorial(n):
    prod = 1
    for k in range(1, n + 1):
        prod *= k
    return prod


print(digitsum(factorial(100)))
