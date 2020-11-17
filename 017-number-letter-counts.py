def read(n):
    if n == 1:
        return "one"
    if n == 2:
        return "two"
    if n == 3:
        return "three"
    if n == 4:
        return "four"
    if n == 5:
        return "five"
    if n == 6:
        return "six"
    if n == 7:
        return "seven"
    if n == 8:
        return "eight"
    if n == 9:
        return "nine"
    if n == 10:
        return "ten"
    if n == 11:
        return "eleven"
    if n == 12:
        return "twelve"
    if n == 13:
        return "thirteen"
    if n == 14:
        return "fourteen"
    if n == 15:
        return "fifteen"
    if n == 16:
        return "sixteen"
    if n == 17:
        return "seventeen"
    if n == 18:
        return "eighteen"
    if n == 19:
        return "nineteen"
    if n == 20:
        return "twenty"
    if n == 30:
        return "thirty"
    if n == 40:
        return "forty"
    if n == 50:
        return "fifty"
    if n == 60:
        return "sixty"
    if n == 70:
        return "seventy"
    if n == 80:
        return "eighty"
    if n == 90:
        return "ninety"
    if n in range(100):
        return read(n - n % 10) + read(n % 10)
    if n % 100 == 0 and n < 1000:
        return read(n / 100) + "hundred"
    if n in range(1000):
        return read(n - n % 100) + "and" + read(n % 100)
    if n == 1000:
        return "onethousand"


def main():
    S = 0
    for n in range(1, 1001):
        S += len(read(n))
    return S


print main()
