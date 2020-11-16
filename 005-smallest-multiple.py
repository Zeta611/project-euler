def gcd(a,b):
	if a>b: a, b = b, a
	while a!=0:
		a, b = b%a, a
	return b
P=1
for i in range(2,21):
	P*=i/gcd(i, P)
print P
