def is_leap_year(year):
    if year % 400 == 0:
        return True
    if year % 100 == 0:
        return False
    return year % 4 == 0


def days_in_month(year, month):
    if month in [4, 6, 9, 11]:
        return 30
    if month == 2:
        return 29 if is_leap_year(year) else 28
    return 31


def days_past_new_year(year, month, day):
    result = 0
    for m in range(1, month):
        result += days_in_month(year, m)
    result += day
    return result - 1


def days_past(year, month, day):
    result = 0
    for y in range(1900, year):
        result += 366 if is_leap_year(y) else 365
    result += days_past_new_year(year, month, day)
    return result


def is_sunday(year, month, day):
    return days_past(year, month, day) % 7 == 6


cnt = 0
for y in range(1901, 2001):
    for m in range(1, 13):
        if is_sunday(y, m, 1):
            cnt += 1
print(cnt)
