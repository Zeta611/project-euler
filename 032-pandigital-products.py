def pandigital(n):
    return sorted(map(int, str(n))) == list(range(1, 10))


def subpandigital(n):
    l = sorted(map(int, str(n)))
    for i in range(len(l) - 1):
        if l[i] == l[i + 1]:
            return False
    return True


prod_rec = set()
for x in range(2, 10):
    for y in range(1000, 10000):
        z = x * y
        if pandigital(f"{x}{y}{z}"):
            prod_rec.add(z)

for x in range(10, 100):
    if not subpandigital(x):
        continue
    for y in range(100, 1000):
        z = x * y
        if pandigital(f"{x}{y}{z}"):
            prod_rec.add(z)

print(sum(prod_rec))
