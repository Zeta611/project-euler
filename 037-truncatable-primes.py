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


def truncatable_prime(p, sieve):
    p_copy = p
    while p_copy:
        if p_copy not in sieve:
            return False
        p_copy //= 10
    m = 10
    while p > m:
        if p % m not in sieve:
            return False
        m *= 10
    return True


sieve = prime_eratosthenes(1000000)
sum_ = 0
count = 0
res = []
for p in sieve:
    if p > 10:
        if truncatable_prime(p, sieve):
            sum_ += p
            count += 1
            res.append(p)
    if count >= 11:
        break
print(sum_)
