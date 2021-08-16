with open("067-triangle.txt", "r") as fin:
    s = fin.read().split()


def triangle(s):
    n = int(((8 * len(s) + 1) ** 0.5 - 1) / 2)
    p = [[None] * (i + 1) for i in range(n)]
    for i in range(n):
        for j in range(i + 1):
            p[i][j] = int(s.pop(0))
    return p


def max_sum(s):
    length = len(s)
    if length == 1:
        return s[0][0]
    length -= 1
    for j in range(length):
        if s[length - 1][j] + s[length][j] > s[length - 1][j] + s[length][j + 1]:
            s[length - 1][j] = s[length - 1][j] + s[length][j]
        else:
            s[length - 1][j] = s[length - 1][j] + s[length][j + 1]
    s.pop()
    return max_sum(s)


print(max_sum(triangle(s)))
