primes = [2]
n = 3
while len(primes) <= 10001:
    flag = False
    i = 0
    while primes[i] < int(n ** 0.5) + 1:
        if n % primes[i] == 0:
            flag = True
            break
        i += 1
    if not flag:
        primes.append(n)
    n += 1
print(primes[10000])
