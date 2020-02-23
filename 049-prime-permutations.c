#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>


void generate_sieve(bool* sieve, int cnt)
{
	for (int p = 2; p <= sqrt(cnt - 1); ++p) {
		if (!sieve[p]) {
			for (int n = p * p; n < cnt; n += p) {
				sieve[n] = true;
			}
		}
	}
}


bool check_permutations(int a, int b)
{
	int digits[10] = {0};
	int i;

	for (i = 0; i < 4; ++i) {
		++digits[a % 10];
		--digits[b % 10];
		a /= 10;
		b /= 10;
	}

	for (i = 0; i < 10; ++i) {
		if (digits[i]) return false;
	}
	return true;
}


static inline bool check_three_permutations(int a, int b, int c)
{
	return check_permutations(a, b) && check_permutations(a, c);
}


int main(void)
{
	clock_t start = clock();

	bool sieve[10000] = {true, true};
	generate_sieve(sieve, 10000);

	int cnt = 0;
	for (int i = 1000; i < 10000; ++i) {
		cnt += !sieve[i];
	}

	int* primes = (int*)malloc(cnt * sizeof(int));
	for (int i = 1000, j = 0; i < 10000; ++i) {
		if (!sieve[i]) {
			primes[j++] = i;
		}
	}

	for (int i = 0; i < cnt; ++i) {
		for (int j = i + 1; j < cnt; ++j) {
			int prime1 = primes[i];
			int prime2 = primes[j];
			int prime3 = 2 * primes[j] - primes[i];
			if (prime3 < 10000 &&
			    !sieve[prime3] &&
			    check_three_permutations(prime1, prime2, prime3)) {
				printf("%d %d %d\n", prime1, prime2, prime3);
			}
		}
	}

	free(primes);

	clock_t end = clock();
	float seconds = (float)(end - start) / CLOCKS_PER_SEC;
	printf("Took %f seconds\n", seconds);
	/** 0.005172 seconds */

	return 0;
}
