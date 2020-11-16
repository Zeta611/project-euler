p=[2]
n=3; i=0
while len(p)<=10001:
	c=0
	j=0
	while p[j]<int(n**0.5)+1:
		if n%p[j]==0:
			c+=1
			break
		j+=1
	if c==0:
		p.append(n)
		i+=1
	n+=1
print p[10000]
