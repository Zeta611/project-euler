def main():
    a=0
    for i in range(1000):
        if i%3==0 or i%5==0: a+=i
    return a

if __name__ == '__main__':
    print main()
