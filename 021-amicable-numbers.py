def d(n):
    result = 0
    for m in range(1, n):
        if n % m == 0:
            result += m
    return result


def isamicable(n):
    return d(d(n)) == n and n != d(n)


print(sum(n for n in range(1, 10000) if isamicable(n)))
