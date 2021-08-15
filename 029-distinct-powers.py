sequence = set()
for i in range(2, 101):
    for j in range(2, 101):
        sequence.add(i ** j)

print(len(sequence))
