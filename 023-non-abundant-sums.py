from enum import Enum


class Number(Enum):
    PERFECT = 0
    DEFICIENT = 1
    ABUNDANT = 2


def prop_div(n):
    div_list = [1]
    for i in range(2, int(n ** 0.5) + 1):
        if n % i == 0:
            if i != n // i:
                div_list += [i, n // i]
            else:
                div_list += [i]
    return div_list


def det_perfect(n):
    if sum(prop_div(n)) == n:
        return Number.PERFECT
    elif sum(prop_div(n)) < n:
        return Number.DEFICIENT
    else:
        return Number.ABUNDANT


def list_abundant(limit):
    abundant = []
    for i in range(1, limit + 1):
        if det_perfect(i) == Number.ABUNDANT:
            abundant.append(i)
    return abundant


def imp_sum_abundant():
    LIMIT = 28123
    elements = list_abundant(LIMIT + 1)
    n = len(elements)
    pos_sum_abundant = set()
    for i in range(n):
        for j in range(i, n):
            e = elements[i] + elements[j]
            if e > LIMIT:
                break
            pos_sum_abundant.add(e)
    result = []
    for i in range(1, LIMIT + 1):
        if i not in pos_sum_abundant:
            result.append(i)
    return result


print(sum(imp_sum_abundant()))
