#include <cmath>
#include <iostream>
#include <numeric>
#include <vector>

constexpr int MAX{1'000'000};
const int SQRT{static_cast<int>(std::sqrt(MAX))};

int main()
{
    std::vector<int> spf(MAX + 1);
    iota(begin(spf), end(spf), 0);
    for (int n{2}; n <= SQRT; ++n) {
        if (spf[n] == n) {
            for (int m{n * n}; m <= MAX; m += n) {
                if (spf[m] == m) {
                    spf[m] = n;
                }
            }
        }
    }

    std::vector<int> phi(MAX + 1);
    for (int n{2}; n <= MAX; ++n) {
        if (spf[n] == n) {
            phi[n] = n - 1;
        } else {
            const int p{spf[n]};
            const int m{n / p};
            if (spf[m] == p) {
                phi[n] = phi[m] * p;
            } else {
                phi[n] = phi[m] * (p - 1);
            }
        }
    }

    std::cout << accumulate(begin(phi) + 2, end(phi), 0LL) << '\n';
}
