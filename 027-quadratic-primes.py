sieve = dict({1:False, 2: True})

def is_prime(n):
    if n <= 0:
        return False
    if n not in sieve:
        flag = False
        for p in range(2, int(n**.5) + 1):
            if is_prime(p) and n % p == 0:
                sieve[n] = False
                flag = True
                break
        if not flag:
            sieve[n] = True
    return sieve[n]

def main():
    max_n = [[0 for i in range(-999, 1000)] for j in range(-1000, 1001)]
    max_consecutive = 0
    for a in range(-999, 1000):
        for b in range(max(1 - a, 2), 1001):
            if not (is_prime(b) and is_prime(a + b + 1)):
                continue
            n = 0
            while True:
                if is_prime(n**2 + a * n + b):
                    max_n[b + 1000][a + 999] = n
                    if n > max_consecutive:
                        max_consecutive, max_a, max_b = n, a, b
                else:
                    break
                n += 1
    return max_a * max_b

if __name__ == "__main__":
    print main()
