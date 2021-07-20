#include <algorithm>
#include <cmath>
#include <iostream>
#include <vector>

// std::vector<bool> is possibly specialized to be space-efficient.
void eratosthenes(std::vector<bool> &sieve)
{
    if (sieve.size() > 0) {
        sieve[0] = false;
    }
    if (sieve.size() > 1) {
        sieve[1] = false;
    }
    // Filter even numbers
    for (std::size_t n = 4; n < sieve.size(); n += 2) {
        sieve[n] = false;
    }
    // Filter odd numbers
    for (std::size_t n = 3; n <= std::sqrt(sieve.size() - 1); n += 2) {
        if (!sieve[n]) {
            continue;
        }
        for (std::size_t m = n * n; m < sieve.size(); m += n) {
            sieve[m] = false;
        }
    }
}

inline bool is_prime(const std::vector<bool> &sieve, long n)
{
    return sieve[n];
}

bool is_permutation(long a, long b)
{
    int digits[10]{};
    while (a) {
        ++digits[a % 10];
        a /= 10;
    }
    while (b) {
        --digits[b % 10];
        b /= 10;
    }
    for (int c : digits) {
        if (c != 0) {
            return false;
        }
    }
    return true;
}

int main()
{
    // Initialize the Sieve of Eratosthenes
    constexpr std::size_t size{10'000'000};
    std::vector<bool> sieve(size + 1, true);
    eratosthenes(sieve);
    std::cout << "sieve done!\n";

    std::vector<long> primes;
    for (long n = 1; n <= size; ++n) {
        if (is_prime(sieve, n)) {
            primes.push_back(n);
        }
    }
    std::cout << "primes done!\n";

    double min{10.0};
    long min_n{0};
    for (auto i = begin(primes); i != end(primes); ++i) {
        for (auto j = i + 1; j != end(primes); ++j) {
            const long n{*i * *j};
            if (n > size) {
                break;
            }
            const long tot{(*i - 1) * (*j - 1)};
            if (is_permutation(n, tot)) {
                const double ratio{static_cast<double>(n) / tot};
                if (ratio < min) {
                    min = ratio;
                    min_n = n;
                }
            }
        }
    }

    std::cout << min << ',' << min_n << '\n';
}
