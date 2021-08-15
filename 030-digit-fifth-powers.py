result = []

for n in range(2, 6 * 9 ** 5):
    n_str = str(n)
    sum_ = 0
    for digit in n_str:
        sum_ += int(digit) ** 5
    if sum_ == n:
        result.append(n)

print(sum(result))
