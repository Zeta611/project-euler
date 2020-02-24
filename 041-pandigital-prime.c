#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <math.h>
#include <time.h>

#define SIZE 10000000


void generate_sieve(bool *sieve, int cnt)
{
	int bound = sqrt(cnt - 1);
	for (int p = 2; p <= bound; ++p) {
		if (!sieve[p]) {
			for (int n = p * p; n < cnt; n += p) {
				sieve[n] = true;
			}
		}
	}
}


bool check_pandigital(int n)
{
	int size;
	int n_cpy = n;
	for (size = 0; n_cpy; n_cpy /= 10, ++size);

	bool *slot = calloc(size, sizeof(bool));
	for (; n; n /= 10) {
		int ind = n % 10 - 1;
		if (slot[ind] || ind >= size) return false;
		slot[ind] = true;
	}
	return true;
}


int main(void)
{
	clock_t start = clock();

	/* malloc for large SIZE's */
	bool *sieve = malloc(sizeof(bool[SIZE]));
	sieve[0] = sieve[1] = true;
	generate_sieve(sieve, SIZE);

	int cnt = 0;
	int i;
	for (i = 0; i < SIZE; ++i) {
		cnt += !sieve[i];
	}

	int pand_prime = -1;
	for (i = SIZE - 1; i >= 0; --i) {
		if (!sieve[i] && check_pandigital(i)) {
			pand_prime = i;
			break;
		}
	}
	free(sieve);

	clock_t end = clock();
	float seconds = (float)(end - start) / CLOCKS_PER_SEC;
	printf("%d\n", pand_prime);
	printf("Took %.3f ms\n", seconds * 1000);
	/* 120.170 ms */

	return 0;
}
