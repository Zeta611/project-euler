flag = False
for a in range(1, 1000):
    for b in range(a, 1000 - a + 1):
        c = 1000 - a - b
        if a ** 2 + b ** 2 == c ** 2:
            p = a * b * c
            flag = True
            break
    if flag:
        break
print(p)
