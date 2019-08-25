def next_perm(l):
    n = len(l)
    if n == 1:
        return None
    i = -1
    while l[i] < l[i-1] and -i < n:
        i -= 1
    if -i == n:
        return None
    j = -1
    while l[i-1] > l[j]:
        j -= 1
    l[i-1], l[j] = l[j], l[i-1]
    m = l[:i]+l[-1:i-1:-1]
    for i in range(n):
        l[i] = m[i]

a = range(10)
for i in range(1000000-1):
    next_perm(a)
print a
