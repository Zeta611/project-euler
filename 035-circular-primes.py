from collections import deque


def prime_eratosthenes(n):
    sieve = [1] * n
    sieve[0] = 0
    primes = set()
    for p in range(2, n + 1):
        if sieve[p - 1]:
            primes.add(p)
            for i in range(p ** 2, n + 1, p):
                sieve[i - 1] = 0
    return primes


def circular(n):
    n_deq = deque(str(n))
    m = len(n_deq)
    res = [n] + [None] * (m - 1)
    for i in range(1, m):
        n_deq.appendleft(n_deq.pop())
        res[i] = int("".join(n_deq))
    return res


res = set()
sieve = prime_eratosthenes(1000000)
for prime in sieve:
    circular_prime = True
    for num in circular(prime):
        if num not in sieve:
            circular_prime = False
            break
    if circular_prime:
        res.add(prime)
n = len(res)
print(n)
