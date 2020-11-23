import math

# 10^{n - 1} \le x^n \le 10^n => x < 10 && \frac{1}{1 - \log_{10} x} \ge n
def cnt_power_with_digits(x):
    return int(1 / (1 - math.log10(x)))


# \sum_{x = 1}^9 \left\lfloor\frac{1}{1 - \log_{10} x}\right\rfloor
print(sum(cnt_power_with_digits(x) for x in range(1, 10)))
