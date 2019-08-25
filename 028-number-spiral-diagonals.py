def corner_sum(n):
    m = (n - 1)/2
    return 16 * m**2 + 4 * m + 4

def diag(n):
    m = (n - 1)/2
    sum = 1
    for i in range(m):
        sum += corner_sum(2 * (i + 1) + 1)
    return sum

print diag(1001)
