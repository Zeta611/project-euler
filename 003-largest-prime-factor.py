n = 600851475143
factor = 3
while n > 1:
    if n % factor == 0:
        n /= factor
    else:
        factor += 2
print(factor)
