def order_of_ten(n):
    exponent = 1
    while n % 2 == 0:
        n /= 2
    while n % 5 == 0:
        n /= 5
    mod = 10
    while True:
        while mod >= n:
            mod -= n
        if mod == 0 or mod == 1:
            return exponent
        mod *= 10
        exponent += 1
    return exponent


def main():
    max_length = 0
    for n in range(3, 1000, 2):
        if n % 5 == 0:
            continue
        length = order_of_ten(n)
        if length > max_length:
            max_length = length
            max_n = n
    return max_n


if __name__ == "__main__":
    print main()
