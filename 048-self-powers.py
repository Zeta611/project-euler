import time


start = time.time()

sum = 0
for n in range(1, 1001):
    product = 1
    for i in range(n):
        product *= n
        product %= 10000000000
    sum += product
    sum %= 10000000000
print(sum)

end = time.time()
seconds = end - start
print(f"Took {seconds} seconds")
# 0.10995721817016602 seconds
