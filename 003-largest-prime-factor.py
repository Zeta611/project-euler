p=[]
N=600851475143; k=2
while N>1:
	if N%k==0:
		N/=k
		p.append(k)
	else:
		k+=1
print max(p)
