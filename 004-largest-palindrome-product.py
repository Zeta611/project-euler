def listN(n):
	r=n[::-1]
	return n==r
pal=[]
for i in range(100,1000):
	for j in range(i,1000):
		if listN(str(i*j)):
			pal.append(i*j)
print max(pal)
