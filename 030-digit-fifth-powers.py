result = []

for n in range(2, 6 * 9 ** 5):
    n_str = str(n)
    summation = 0
    for digit in n_str:
        summation += int(digit) ** 5
    if summation == n:
        result.append(n)

print sum(result)
