part = [1]
n = 1
while True:
    part.append(0)

    add = True
    k = 1
    while True:
        pent0 = (3 * k * k - k) // 2
        if pent0 > n:
            break
        if add:
            part[n] += part[n - pent0]
        else:
            part[n] -= part[n - pent0]

        pent1 = pent0 + k
        if pent1 > n:
            break
        if add:
            part[n] += part[n - pent1]
        else:
            part[n] -= part[n - pent1]

        add = not add
        k += 1

    if not (part[n] % 1_000_000):
        print(f"{n}:{part[n]}")
        break

    n += 1
