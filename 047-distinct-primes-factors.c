#include <stdio.h>
#include <stdbool.h>
#include <time.h>


bool check_distinct_factors(int n)
{
	int cnt = n % 2 == 0;
	while (n % 2 == 0) {
		n /= 2;
	}
	for (int p = 3; cnt <= 5 && n > 1; p += 2) {
		bool divisible = n % p == 0;
		cnt += divisible;
		while (n % p == 0) {
			n /= p;
		}
	}
	return cnt == 4;
}


int main(void)
{
	clock_t start = clock();
	int cnt = 0;
	int mark = 0;
	for (int n = 644; cnt <= 5; n++) {
		if (check_distinct_factors(n)) {
			if (cnt == 0) {
				mark = n;
			}
			cnt++;
		} else {
			cnt = 0;
		}
		if (cnt == 4) {
			printf("%d\n", mark);
			break;
		}
	}
	clock_t end = clock();
	float seconds = (float)(end - start) / CLOCKS_PER_SEC;
	printf("Took %f seconds\n", seconds);
	return 0;
}
