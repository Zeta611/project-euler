factorial = [1] * 10
for i in range(1, 10):
    factorial[i] = factorial[i - 1] * i

upper = 1
while 10 ** upper - 1 <= factorial[9] * upper:
    upper += 1

res = []
for n in range(10, 10 ** upper):
    digit_factorial = 0
    n_orig = n
    while n:
        digit_factorial += factorial[n % 10]
        n //= 10
    if digit_factorial == n_orig:
        res.append(n_orig)

print(sum(res))  # 145 + 40585 = 40730
