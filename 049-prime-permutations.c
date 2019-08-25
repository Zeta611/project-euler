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
	int a_1 = a % 10;
	int a_2 = a / 10 % 10;
	int a_3 = a / 100 % 10;
	int a_4 = a / 1000 % 10;
	int b_1 = b % 10;
	int b_2 = b / 10 % 10;
	int b_3 = b / 100 % 10;
	int b_4 = b / 1000 % 10;
	if (a_1 == b_1) {
		if (a_2 == b_2) {
			if (a_3 == b_3) {
				return a_4 == b_4;
			} else if (a_3 == b_4) {
				return a_4 == b_3;
			} else {
				return false;
			}
		} else if (a_2 == b_3) {
			if (a_3 == b_2) {
				return a_4 == b_4;
			} else if (a_3 == b_4) {
				return a_4 == b_2;
			} else {
				return false;
			}
		} else if (a_2 == b_4) {
			if (a_3 == b_2) {
				return a_4 == b_3;
			} else if (a_3 == b_3) {
				return a_4 == b_2;
			} else {
				return false;
			}
		} else {
			return false;
		}
	} else if (a_1 == b_2) {
		if (a_2 == b_1) {
			if (a_3 == b_3) {
				return a_4 == b_4;
			} else if (a_3 == b_4) {
				return a_4 == b_3;
			} else {
				return false;
			}
		} else if (a_2 == b_3) {
			if (a_3 == b_1) {
				return a_4 == b_4;
			} else if (a_3 == b_4) {
				return a_4 == b_1;
			} else {
				return false;
			}
		} else if (a_2 == b_4) {
			if (a_3 == b_1) {
				return a_4 == b_3;
			} else if (a_3 == b_3) {
				return a_4 == b_1;
			} else {
				return false;
			}
		} else {
			return false;
		}
	} else if (a_1 == b_3) {
		if (a_2 == b_1) {
			if (a_3 == b_2) {
				return a_4 == b_4;
			} else if (a_3 == b_4) {
				return a_4 == b_2;
			} else {
				return false;
			}
		} else if (a_2 == b_2) {
			if (a_3 == b_1) {
				return a_4 == b_4;
			} else if (a_3 == b_4) {
				return a_4 == b_1;
			} else {
				return false;
			}
		} else if (a_2 == b_4) {
			if (a_3 == b_1) {
				return a_4 == b_2;
			} else if (a_3 == b_2) {
				return a_4 == b_4;
			} else {
				return false;
			}
		} else {
			return false;
		}
	} else if (a_1 == b_4) {
		if (a_2 == b_1) {
			if (a_3 == b_2) {
				return a_4 == b_3;
			} else if (a_3 == b_3) {
				return a_4 == b_2;
			} else {
				return false;
			}
		} else if (a_2 == b_2) {
			if (a_3 == b_1) {
				return a_4 == b_1;
			} else if (a_3 == b_3) {
				return a_4 == b_3;
			} else {
				return false;
			}
		} else if (a_2 == b_3) {
			if (a_3 == b_1) {
				return a_4 == b_2;
			} else if (a_3 == b_2) {
				return a_4 == b_1;
			} else {
				return false;
			}
		} else {
			return false;
		}
	} else {
		return false;
	}
}


bool check_three_permutations(int a, int b, int c)
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

	return 0;
}
