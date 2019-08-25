sequence = set([])
for a in range(2, 101):
    for b in range(2, 101):
        sequence |= set([a ** b])

print len(sequence)
