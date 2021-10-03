#include <cstring>
#include <iostream>
#include <numeric>

constexpr int DIGITS{100};
int digits[DIGITS];
int prod[2 * DIGITS];

void square()
{
    memset(prod, 0, sizeof prod);
    for (int i{DIGITS - 1}; i >= 0; --i) {
        for (int j{0}; j <= DIGITS - 1; ++j) {
            prod[i + j + 1] += digits[i] * digits[j];
        }
    }

    for (int i{2 * DIGITS - 1}; i > 0; --i) {
        prod[i - 1] += prod[i] / 10;
        prod[i] %= 10;
    }
}

int main()
{
    int sum{0};

    for (int n{2}, m{2}; n < 100; ++n) {
        if (m * m == n) {
            ++m;
            continue;
        }

        memset(digits, 0, sizeof digits);
        digits[0] = m - 1;

        for (int i{1}; i <= DIGITS - 1; ++i) {
            int lo{0};
            int hi{9};
            while (lo <= hi) {
                const int mid{(lo + hi) / 2};
                const int prev{digits[i]};
                digits[i] = mid;
                square();

                if (prod[0] * 10 + prod[1] >= n) {
                    digits[i] = prev;
                    hi = mid - 1;
                } else {
                    lo = mid + 1;
                }
            }
        }

        sum += std::accumulate(std::begin(digits), std::end(digits), 0);
    }

    std::cout << sum << '\n';
}
