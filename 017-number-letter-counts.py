def read(n):
    dct = {
        1: "one",
        2: "two",
        3: "three",
        4: "four",
        5: "five",
        6: "six",
        7: "seven",
        8: "eight",
        9: "nine",
        10: "ten",
        11: "eleven",
        12: "twelve",
        13: "thirteen",
        14: "fourteen",
        15: "fifteen",
        16: "sixteen",
        17: "seventeen",
        18: "eighteen",
        19: "nineteen",
        20: "twenty",
        30: "thirty",
        40: "forty",
        50: "fifty",
        60: "sixty",
        70: "seventy",
        80: "eighty",
        90: "ninety",
        1000: "onethousand",
    }
    if n in dct:
        return dct[n]
    if n in range(100):
        return read(n - n % 10) + read(n % 10)
    if n % 100 == 0 and n < 1000:
        return read(n / 100) + "hundred"
    if n in range(1000):
        return read(n - n % 100) + "and" + read(n % 100)


cnt = sum(len(read(n)) for n in range(1, 1001))
print(cnt)
