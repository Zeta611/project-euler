#define PRIME_RANGE 1000000
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


int main(void)
{
	clock_t start = clock();

	bool sieve[PRIME_RANGE] = {true, true};
	generate_sieve(sieve, PRIME_RANGE);

	int cnt = 0;
	for (int i = 0; i < PRIME_RANGE; ++i) {
		cnt += !sieve[i];
	}

	int* primes = (int *) malloc(cnt * sizeof(int));
	for (int i = 0, j = 0; i < PRIME_RANGE; ++i) {
		if (!sieve[i]) {
			primes[j++] = i;
		}
	}

	/** Maximum length of consecutive prime sum which does not exceed the
	 * maximum prime */
	int max_len = 0;
	int sum = 0;
	while (sum <= primes[cnt - 1]) {
		sum += primes[max_len];
		++max_len;
	}
	--max_len;
	sum -= primes[max_len];

	/** Find sum like a "moving window", decreasing a length each time */
	bool flag = false;
	for (int len = max_len; len > 0; --len) {
		/** sum is the sum of primes in the starting window, and 
		 * curr_sum is the sum of the primes in an updating window */
		int curr_sum = sum;
		/** i is the start of the window */
		for (int i = 0; i <= cnt - len; ++i) {
			if (!sieve[curr_sum]) {
				printf("%d\n", curr_sum);
				flag = true;
				break;
			}
			/** Move a window */
			curr_sum += primes[i + len] - primes[i];
			if (curr_sum > primes[cnt - 1]) { break; }
		}
		if (flag) { break; }
		sum -= primes[len - 1];
	}

	free(primes);

	clock_t end = clock();
	float seconds = (float)(end - start) / CLOCKS_PER_SEC;
	printf("Took %f seconds\n", seconds);
	/** 0.010948 seconds */

	return 0;
}
