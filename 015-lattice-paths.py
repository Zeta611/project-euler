def factorial(n):
    if n == 0:
        return 1
    result = 1
    for k in range(1, n + 1):
        result *= k
    return result


def choose(n, k):
    return factorial(n) // (factorial(k) * factorial(n - k))


def lattice(n, m):
    return choose(n + m, n)


print(lattice(20, 20))
