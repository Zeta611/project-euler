#include <stdio.h>
#include <tgmath.h>

#define L 1500000
int hyp[L / 2 + 1];

static inline int sqsum(int a, int b) { return a * a + b * b; }

int main(void)
{
    int cnt = L / 2;

    for (int m = 1; m <= L / 2; ++m) {
        for (int u = sqrt(m / 2.0) + 1; u <= sqrt(m - 1); ++u) {
            if (m % u) {
                continue;
            }

            for (int k = 1; k * m <= L / 2; ++k) {
                int *val = &hyp[k * m];
                if (!*val) {
                    *val = k * sqsum(u, m / u - u);
                } else if (*val != -1) {
                    if (*val != k * sqsum(u, m / u - u)) {
                        *val = -1;
                        --cnt;
                    }
                }
            }
        }

        if (!hyp[m]) {
            --cnt;
        }
    }

    printf("%d\n", cnt);
}
