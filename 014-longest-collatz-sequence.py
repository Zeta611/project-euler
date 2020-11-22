def collatz_chain_len(n):
    cnt = 0
    while n > 1:
        if n % 2 == 0:
            n /= 2
        else:
            n = 3 * n + 1
        cnt += 1
    return cnt


max_len = 0
for n in range(1, 1000000):
    l = collatz_chain_len(n)
    if max_len < l:
        max_len = l
        max_n = n

print(max_n)
