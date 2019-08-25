import time

def pandigital(m):
    m_word = str(m)
    m_list = list(m_word)
    for i in range(len(m_list)):
        m_list[i] = int(m_list[i])
    m_list.sort()
    return m_list == range(1, 10)

def subpandigital(m):
    m_word = str(m)
    m_list = list(m_word)
    for i in range(len(m_list)):
        m_list[i] = int(m_list[i])
    m_list.sort()
    for i in range(len(m_list)-1):
        if m_list[i] == m_list[i + 1]:
            return False
    return True

prod_rec = []

start = time.time()

for x in range(2, 10):
    for y in range(1000, 10000):
        z = x * y
        xyz = str(x) + str(y) + str(z)
        if pandigital(xyz):
            if z not in prod_rec:
                prod_rec.append(z)

for x in range(10, 100):
    if subpandigital(x):
        for y in range(100, 1000):
            z = x * y
            xyz = str(x) + str(y) + str(z)
            if pandigital(xyz):
                if z not in prod_rec:
                    prod_rec.append(z)

print sum(prod_rec)
print time.time() - start, "s"
