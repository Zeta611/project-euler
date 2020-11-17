def isLeapYear(Y):
    if Y % 400 == 0:
        return True
    if Y % 100 == 0:
        return False
    if Y % 4 == 0:
        return True
    return False


def DayinMonth(Y, M):
    if M in [9, 4, 6, 11]:
        return 30
    if M == 2:
        if isLeapYear(Y):
            return 29
        return 28
    return 31


def DayPastNewYear(Y, M, D):
    result = 0
    for m in range(1, M):
        result += DayinMonth(Y, m)
    result += D
    return result - 1


def DayPastGivenDate(Y, M, D):
    result = 0
    for y in range(1900, Y):
        if isLeapYear(y):
            result += 366
        else:
            result += 365
    result += DayPastNewYear(Y, M, D)
    return result


def isSunday(Y, M, D):
    if DayPastGivenDate(Y, M, D) % 7 == 6:
        return True
    return False


def main():
    cnt = 0
    for y in range(1901, 2000 + 1):
        for m in range(1, 12 + 1):
            if isSunday(y, m, 1):
                cnt += 1
    return cnt


print main()
