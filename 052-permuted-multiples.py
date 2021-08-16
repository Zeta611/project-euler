def check_perm(a: int, b: int) -> bool:
    slot = [0] * 10
    while a > 0 and b > 0:
        slot[a % 10] += 1
        slot[b % 10] -= 1
        a //= 10
        b //= 10
    if a or b:
        return False
    return not [n for n in slot if n != 0]


def check_mult_perm(n: int) -> bool:
    return (
        check_perm(n, 2 * n)
        and check_perm(n, 3 * n)
        and check_perm(n, 4 * n)
        and check_perm(n, 5 * n)
    )


def check_in_range(r) -> bool:
    for n in r:
        if check_mult_perm(n):
            print(n, 2 * n, 3 * n, 4 * n, 5 * n)
            return True
    return False


for r in (
    range(1000, 2000),
    range(10000, 20000),
    range(100000, 200000),
    range(1000000, 2000000),
    range(10000000, 20000000),
):
    if check_in_range(r):
        break
