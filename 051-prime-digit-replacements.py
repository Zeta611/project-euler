import math
import time

size = 10000000


def generate_sieve(cnt):
    sieve = [False] * cnt
    sieve[0] = sieve[1] = True
    for p in range(2, int(math.sqrt(cnt - 1)) + 1):
        if not sieve[p]:
            for n in range(p * p, cnt, p):
                sieve[n] = True
    return sieve


def family(n):
    sn = str(n)
    return [
        [
            int(sn.replace(str(x), str(y)))
            for y in range(10)
            if y != 0 or sn.find(str(x)) != 0
        ]
        for x in range(10)
        if str(x) in sn
    ]


start = time.time()

sieve = generate_sieve(size)
for i in range(size):
    if not sieve[i]:
        res = list(
            filter(
                lambda l: len(l) == 8,
                [[p for p in l if not sieve[p]] for l in family(i)],
            )
        )
        if len(res) > 0:
            print(i, res[0])
            break

end = time.time()
seconds = end - start
print(f"Took {seconds:.3f} s")
# 2.311 s
