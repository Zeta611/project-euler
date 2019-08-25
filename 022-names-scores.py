fin = open('022-names.txt', 'r')
ilist = fin.read().split('","')
ilist[0] = ilist[0][1:]
ilist[-1] = ilist[-1][:-1]
ilist.sort()
result = 0
for i in range(len(ilist)):
	S = 0
	for letter in ilist[i]:
		S += ord(letter) - ord('A') + 1
	result += S * (i + 1)
print result
