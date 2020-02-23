import time

start = time.time()
n = "".join([f"{i}" for i in range(1000000)])
prod = 1
for p in range(2, 7):
    prod *= int(n[10 ** p])
end = time.time()
print(prod)
print(f"Took {(end - start) * 1000:.1f} ms")
# 177.0 ms
