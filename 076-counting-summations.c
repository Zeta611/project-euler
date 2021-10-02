#include <stdbool.h>
#include <stdio.h>
#define MAX 100

int p[MAX + 1] = {1};

int main(void)
{
    // p(n)
    // = \sum_1^\infty (-1)^(k + 1)
    //                   (p(n - (3 k^2 - k) / 2) + p(n - (3 k^2 + k) / 2))
    for (int n = 1; n <= MAX; ++n) {
        bool add = true;
        for (int k = 1;; ++k, add = !add) {
            const int pent0 = (3 * k * k - k) / 2;
            if (pent0 > n) {
                break;
            } else if (add) {
                p[n] += p[n - pent0];
            } else {
                p[n] -= p[n - pent0];
            }

            const int pent1 = pent0 + k;
            if (pent1 > n) {
                break;
            } else if (add) {
                p[n] += p[n - pent1];
            } else {
                p[n] -= p[n - pent1];
            }
        }
    }

    printf("%d\n", p[MAX] - 1);
}
