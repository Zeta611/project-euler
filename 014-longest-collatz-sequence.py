memo = {}


def collatz_chain_len(n):
    if n == 1:
        return 1
    if memo.get(n):
        return memo[n]
    if n % 2:
        memo[n] = collatz_chain_len(3 * n + 1)
    else:
        memo[n] = collatz_chain_len(n // 2)
    return 1 + memo[n]


max_n = 0
max_len = 0
for n in range(1, 1000000):
    l = collatz_chain_len(n)
    if max_len < l:
        max_len = l
        max_n = n

print(max_n)
