#include <cmath>
#include <iostream>
#include <vector>

constexpr int MAX{100};
std::vector<bool> sieve(MAX + 1, true);
std::vector<int> primes{2};

int memo[MAX + 1][MAX + 1];
int psum(int n, int p)
{
    if (n < 0) {
        return 0;
    } else if (n == 0) {
        return 1;
    } else if (p == -1) {
        return 0;
    }

    int &ret{memo[n][p]};
    if (ret) {
        return ret;
    }
    return ret = psum(n - primes[p], p) + psum(n, p - 1);
}

int main()
{
    sieve[0] = sieve[1] = false;
    const int LIM{static_cast<int>(sqrt(MAX))};
    for (int n{2}; n <= LIM; ++n) {
        if (sieve[n]) {
            for (int m{n * 2}; m <= MAX; m += n) {
                sieve[m] = false;
            }
        }
    }

    for (int n{3}; n <= MAX; n += 2) {
        if (sieve[n]) {
            primes.push_back(n);
        }
    }

    const int max_p{static_cast<int>(size(primes)) - 1};
    for (int n{1}; n <= MAX; ++n) {
        if (const int s{psum(n, max_p)}; s > 5000) {
            std::cout << n << ':' << s << '\n';
            break;
        }
    }
}
