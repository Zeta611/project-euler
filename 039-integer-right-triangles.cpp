#include <cmath>
#include <iostream>
#include <set>

constexpr int L{1000};
std::set<int> hyp[L / 2 + 1];

template <class T> inline T sqsum(T a, T b) { return a * a + b * b; }

int main()
{
    for (int m{1}; m <= L / 2; ++m) {
        for (int u{static_cast<int>(sqrt(m / 2.0)) + 1};
             u <= static_cast<int>(sqrt(m - 1)); ++u) {
            if (m % u) {
                continue;
            }

            for (int k{1}; k * m <= L / 2; ++k) {
                hyp[k * m].insert(k * sqsum(u, m / u - u));
            }
        }
    }

    int max{0};
    int argmax{0};
    for (int m{1}; m <= L / 2; ++m) {
        if (hyp[m].size() > max) {
            max = hyp[m].size();
            argmax = m;
        }
    }

    std::cout << argmax * 2 << '\n';
}
