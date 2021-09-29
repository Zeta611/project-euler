#include <iostream>
#include <numeric>

constexpr int MAX{12'000};

int main()
{
    int cnt{0};
    for (int d{5}; d <= MAX; ++d) {
        const int lo{d / 3 + 1};
        const int hi{(d + 1) / 2};
        for (int n{lo}; n < hi; ++n) {
            if (std::gcd(d, n) == 1) {
                ++cnt;
            }
        }
    }
    std::cout << cnt << '\n';
}
