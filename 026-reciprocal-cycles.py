def order_of_ten(n):
    while n % 2 == 0:
        n //= 2
    while n % 5 == 0:
        n //= 5

    exponent = 1
    mod = 10
    while True:
        mod %= n
        if mod <= 1:
            return exponent
        mod *= 10
        exponent += 1


max_n = max_length = 0
for n in range(3, 1000, 2):
    if n % 5 == 0:
        continue
    length = order_of_ten(n)
    if length > max_length:
        max_length = length
        max_n = n
print(max_n)
