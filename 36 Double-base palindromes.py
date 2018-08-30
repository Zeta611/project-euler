def is_palindrome(n, base):
    n_copy = n
    count = 0
    while n_copy:
        n_copy /= base
        count += 1
    n_copy = n
    palindrome = 0
    for i in xrange(count):
        palindrome += (n_copy % base) * base ** (count - 1)
        n_copy /= base
        count -= 1
    return palindrome == n


sum_ = 0
for n in xrange(1, 1000000000):
    sum_ += n * (is_palindrome(n, 2) and is_palindrome(n, 10))
print sum_
