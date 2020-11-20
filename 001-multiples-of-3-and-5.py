multiples = (n for n in range(1000) if n % 3 == 0 or n % 5 == 0)
print(sum(multiples))
