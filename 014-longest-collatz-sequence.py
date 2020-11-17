import time


def Collatz(n):
    cnt = 0
    N = n
    while n > 1:
        if n % 2 == 0:
            n /= 2
        else:
            n = 3 * n + 1
        cnt += 1
    return cnt


def compareCollatz():
    Col = []
    for n in range(1, 1000000):
        Col.append(Collatz(n))
    Max = max(Col)
    N = Col.index(Max) + 1
    return N


start = time.time()
print compareCollatz()
end = time.time()
print end - start
