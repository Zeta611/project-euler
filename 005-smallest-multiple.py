def gcd(a, b):
    if a > b:
        a, b = b, a
    while a > 0:
        a, b = b % a, a
    return b


p = 1
for n in range(2, 21):
    p *= n // gcd(p, n)
print(p)
