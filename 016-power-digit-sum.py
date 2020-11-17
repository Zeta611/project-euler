import time


def digitsum(n):
    S = 0
    while n >= 1:
        S += n % 10
        n /= 10
    return S


start = time.time()
print digitsum(2 ** 1000)
print time.time() - start
