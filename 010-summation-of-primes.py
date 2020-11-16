p=[2]
for n in range(3,2000000,2):
	c=0
	for q in p:
		if q>n**0.5: break
		if n%q==0:
			c=1
			break
	if c==0: p.append(n)
print sum(p)
