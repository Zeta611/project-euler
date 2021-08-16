n = "".join(str(i) for i in range(1000000))
prod = 1
for p in range(2, 7):
    prod *= int(n[10 ** p])
print(prod)
