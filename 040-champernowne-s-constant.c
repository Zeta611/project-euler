#include <stdio.h>
#include <stdbool.h>
#include <math.h>
#include <time.h>

int digit_cnt(int i)
{
	int cnt = 0;
	for (cnt = 0; i; ++cnt) {
		i /= 10;
	}
	return cnt;
}

int main(void)
{
	clock_t start = clock();

	bool flag[] = {false, false, false, false, false};
	int pow10[] = {100, 1000, 10000, 100000, 1000000};
	int cnt = 0;
	int prod = 1;

	for (int i = 1; !flag[4]; ++i) {
		cnt += digit_cnt(i);
		for (int j = 0; j < 5; ++j) {
			if (!flag[j] && cnt >= pow10[j]) {
				prod *= (i / (int)pow(10, cnt - pow10[j])) % 10;
				flag[j] = true;
				break;
			}
		}
	}

	clock_t end = clock();
	float seconds = (float)(end - start) / CLOCKS_PER_SEC;

	printf("%d\n", prod);
	printf("Took %f milliseconds\n", seconds * 1000);
	/* 6.138 ms */

	return 0;
}
