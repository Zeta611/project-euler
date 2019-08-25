def nthtrinum(n):
	return n*(n+1)/2

def numofdivisors(N):
	cnt=[0]
	p=2
	while N>1:
		if N%p==0:
			N/=p
			cnt[p-2]+=1
		else:
			p+=1
			cnt.append(0)
	P=1
	for n in cnt:
		if n!=0: P*=(n+1)
	return P

def main():
	n=1
	while True:
		T = nthtrinum(n)
		if numofdivisors(T)>500: return T
		n+=1

print main()
