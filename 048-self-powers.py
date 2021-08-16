MOD = 10 ** 10
sum_ = 0
for n in range(1, 1001):
    product = 1
    for i in range(n):
        product *= n
        product %= MOD
    sum_ += product
    sum_ %= MOD
print(sum_)
