def factorial(n):
    if n == 0:
        return 1
    P = 1
    for k in range(1, n + 1):
        P *= k
    return P


def Combination(n, k):
    return factorial(n) / (factorial(k) * factorial(n - k))


def Lattice(n, m):
    return Combination(n + m, n)


print Lattice(20, 20)
