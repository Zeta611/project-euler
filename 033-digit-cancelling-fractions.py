def frac_eq(r1, r2):
    return (r1[0] * r2[1] - r1[1] * r2[0]) == 0


def gcd(a, b):
    if a < b:
        a, b = b, a
    while b:
        a, b = b, a % b
    return a


result = set()

# Type 1: ab / cb == a / c, a < c
for a in range(1, 10):
    for c in range(a + 1, 10):
        for b in range(1, 10):
            r = (10 * a + b, 10 * c + b)
            if frac_eq(r, (a, c)):
                result.add(r)

# Type 2: ab / bc == a / c, a < c
for a in range(1, 10):
    for c in range(a + 1, 10):
        for b in range(1, 10):
            r = (10 * a + b, 10 * b + c)
            if frac_eq(r, (a, c)):
                result.add(r)

# Type 3: ab / ac == b / c, b < c
for b in range(1, 10):
    for c in range(b + 1, 10):
        for a in range(1, 10):
            r = (10 * a + b, 10 * a + c)
            if frac_eq(r, (b, c)):
                result.add(r)

# Type 4: ab / ca == b / c, b < c
for b in range(1, 10):
    for c in range(b + 1, 10):
        for a in range(1, 10):
            r = (10 * a + b, 10 * c + a)
            if frac_eq(r, (b, c)):
                result.add(r)

print(result)

num = den = 1
for r in result:
    num *= r[0]
    den *= r[1]
g = gcd(num, den)
print(den // g)
