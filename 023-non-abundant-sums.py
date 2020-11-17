import time


def prop_div(n):
    div_list = [1]
    for i in range(2, int(n ** 0.5) + 1):
        if n % i == 0:
            if i != n / i:
                div_list += [i, n / i]
            else:
                div_list += [i]
    # div_list.sort()
    return div_list


def det_perfect(n):
    PERFECT = 0
    DEFICIENT = -1
    ABUNDANT = 1
    if sum(prop_div(n)) == n:
        return PERFECT
    if sum(prop_div(n)) < n:
        return DEFICIENT
    return ABUNDANT


def list_abundant(limit):
    abundant_numbers = []
    for i in range(1, limit + 1):
        if det_perfect(i) == 1:
            abundant_numbers.append(i)
    return abundant_numbers


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


start = time.time()
print sum(imp_sum_abundant())
end = time.time()
print "%.5f ms" % ((end - start) * 1000)
