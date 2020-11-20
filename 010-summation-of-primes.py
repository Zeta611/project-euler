def sieve(size):
    """Generate a sieve of Eratosthenes where sieve[n] is True if n is a prime,
    False otherwise, where n <= size"""
    if size < 0:
        return []
    # 0 and 1 are not primes (False), and rest are to be determined
    s = [True] * (size + 1)
    s[0] = s[1] = False
    bound = int(size ** 0.5) + 1
    for p in range(2, bound):
        if s[p]:
            for i in range(p * p, size + 1, p):
                s[i] = False
    return s


primes = (n for n, is_prime in enumerate(sieve(1999999)) if is_prime)
print(sum(primes))
