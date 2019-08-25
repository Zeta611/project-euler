def bouncy(n):
    cur_flag = 2
    cur_digit = n % 10
    while n >= 10:
        n /= 10
        prev_digit = cur_digit
        prev_flag = cur_flag
        cur_digit = n % 10
        if cur_digit > prev_digit:
            cur_flag = -1
        elif cur_digit < prev_digit:
            cur_flag = 1
        else:
            cur_flag = prev_flag
        if cur_flag != prev_flag != 2:
            return 0
    return cur_flag

def main():
    cnt = 0
    n = 1
    while True:
        if bouncy(n) == 0:
            cnt += 1
        if float(cnt)/n==.99:
            return n
            break
        n += 1

if __name__=="__main__":
    print main()
