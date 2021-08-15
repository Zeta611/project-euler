n = 2
f0 = f1 = 1
while f1 < 10 ** 999:
    n += 1
    f0, f1 = f1, f0 + f1
print(n)
