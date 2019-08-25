import time

def main():
	n = 2
	Fi = 1
	Ff = 1
	while Ff < 10 ** 999:
		n += 1
		Fi, Ff = Ff, Fi + Ff
	return n

start = time.time()
print main()
print time.time() - start
