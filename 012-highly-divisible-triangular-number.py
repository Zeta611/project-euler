def triangle(n):
    return n * (n + 1) // 2


def num_divisors(n):
    factor = 2
    factor_cnt = 0
    cnt = 1
    while n > 1:
        if n % factor == 0:
            n //= factor
            factor_cnt += 1
        else:
            factor += 1 if factor == 2 else 2
            cnt *= factor_cnt + 1
            factor_cnt = 0
    cnt *= factor_cnt + 1
    return cnt


n = 1
while True:
    t = triangle(n)
    if num_divisors(t) > 500:
        break
    n += 1

print(t)
