def digit_sum(n):
    return sum(int(d) for d in str(n))


print(digit_sum(2 ** 1000))
