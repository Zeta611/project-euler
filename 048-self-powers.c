#include <stdio.h>
#include <time.h>


int main(void)
{
	clock_t start = clock();

	unsigned long sum = 0;
	for (int n = 1; n <= 1000; ++n) {
		unsigned long product = 1;
		for (int i = 0; i < n; ++i) {
			product *= n;
			product %= 10000000000;
		}
		sum += product;
		sum %= 10000000000;
	}
	printf("%lu\n", sum);

	clock_t end = clock();
	float seconds = (float)(end - start) / CLOCKS_PER_SEC;
	printf("Took %f seconds\n", seconds);
	/** 0.006683 seconds */

	return 0;
}
