def count_digits(n):
    cnt = 0
    while n:
        n //= 10
        cnt += 1
    return cnt


def is_pandigital(n):
    check = [0] * 10
    cnt = 0
    while n:
        if n % 10 == 0 or check[n % 10]:
            return False
        else:
            check[n % 10] = 1
        n //= 10
        cnt += 1
    return cnt == 9


def pandigital_multiple(n):
    concat = 0
    cnt = 0
    for i in range(1, 10):
        mult = n * i
        digits = count_digits(mult)
        cnt += digits
        if cnt > 9:
            return None
        concat *= 10 ** digits
        concat += mult
        if cnt == 9:
            break
    return concat if is_pandigital(concat) else None


result = []
for n in range(1, 10000):
    if m := pandigital_multiple(n):
        result.append(m)
print(max(result))
