even_sum = 0
f0 = f1 = 1
while f0 <= 4000000:
    f0, f1 = f0 + f1, f0
    if f0 % 2 == 0:
        even_sum += f0
print(even_sum)
