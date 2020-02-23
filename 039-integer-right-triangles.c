#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <time.h>

#define OFFSET 6

typedef struct trip { int a, b, c; } trip;

bool check_fnd(int fnd_cnt, trip *fnd, trip t);
int argmax(int cnt, int *arr);


int main(void)
{
	clock_t start = clock();

	int n, m, k;
	// p(erimeter) = 2km(m + n) <= 1000
	// half_p[0] represents km(m + n) = 6, ..., half_p[494] represents 500
	int half_p[495] = {0};
	// Try 1 <= n <= 15
	//     n <  m <= 22
	//     (1 <= k <= 83)
	//     km(m + n) <= 500
	
	// Adequate upper bound for all possible pythagorean triples where the
	// perimeter <= 1000
	// (21 + 20 + ... + 7) * 83
	// Actually, there are only 462 of them
	trip fnd[17430];
	int fnd_cnt = 0;
	trip new_trip;

	for (n = 1; n <= 15; ++n) {
		for (m = n + 1; m <= 22; ++m) {
			for (k = 1; k <= 83 && k * m * (m + n) <= 500; ++k) {
				if (m % 2 == n % 2) continue;
				new_trip = (trip){
					k * (m * m - n * n),
					2 * k * m * n,
					k * (m * m + n * n)
				};
				if (!check_fnd(fnd_cnt, fnd, new_trip)) {
					fnd[fnd_cnt++] = new_trip;
					++half_p[k * m * (m + n) - OFFSET];
				}
			}
		}
	}

	int perim = 2 * (argmax(495, half_p) + OFFSET);
	clock_t end = clock();

	float seconds = (float)(end - start) / CLOCKS_PER_SEC;
	printf("%d\nTook %.3f milliseconds\n", perim, seconds * 1000);
	// Took 0.167 ms

	return 0;
}


int argmax(int cnt, int *arr)
{
	if (arr == NULL) return 0;

	int curr, arg, max;
	curr = arg = 0;
	max = arr[0];

	for (int i = 0; i < cnt; ++i) {
		curr = arr[i];
		if (max < curr) {
			max = curr;
			arg = i;
		}
	}
	return arg;
}


bool check_fnd(int fnd_cnt, trip *fnd, trip t)
{
	trip curr;
	for (int i = 0; i < fnd_cnt; ++i) {
		curr = fnd[i];
		if (curr.a == t.a && curr.b == t.b && curr.c == t.c) {
			return true;
		}
	}
	return false;
}
