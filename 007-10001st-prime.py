primes = [2]
test = 3
while len(primes) <= 10001:
    found_factor = False
    bound = int(test ** 0.5)
    for p in primes:
        if p > bound:
            break
        if test % p == 0:
            found_factor = True
            break
    if not found_factor:
        primes.append(test)
    test += 2
print(primes[10000])
