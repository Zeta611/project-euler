import time

def digitsum(n):
	S = 0
	while n >= 1:
		S += n % 10
		n /= 10
	return S

def factorial(n):
	P = 1
	for k in range(1, n + 1):
		P *= k
	return P

start = time.time()
print digitsum(factorial(100))
print time.time() - start
