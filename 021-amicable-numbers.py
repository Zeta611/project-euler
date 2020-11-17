import time


def d(n):
    result = 0
    for m in range(1, n):
        if n % m == 0:
            result += m
    return result


def isamicable(n):
    if d(d(n)) == n and n != d(n):
        return True
    return False


def main():
    S = 0
    for n in range(1, 10000):
        if isamicable(n):
            S += n
    return S


start = time.time()
print main()
print time.time() - start
