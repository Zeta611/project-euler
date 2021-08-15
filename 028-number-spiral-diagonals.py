def corner_sum(n):
    m = (n - 1) // 2
    return 16 * m ** 2 + 4 * m + 4


def diag(n):
    m = (n - 1) // 2
    return 1 + sum(corner_sum(2 * i + 3) for i in range(m))


print(diag(1001))
