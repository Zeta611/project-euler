#include <iostream>
#include <stack>

template <class T, std::size_t N> struct Fct {
    consteval Fct() : val{}
    {
        val[0] = 1;
        for (std::size_t i{1}; i < N; ++i) {
            val[i] = val[i - 1] * i;
        }
    }

    constexpr T operator[](std::size_t n) const { return val[n]; }

  private:
    T val[N];
};
constexpr auto fct{Fct<int, 10>()};

constexpr int MAX{1'000'000};
int memo[MAX];
int next(int n)
{
    if (n < MAX && memo[n]) {
        return memo[n];
    }

    int sum{0};
    while (n) {
        sum += fct[n % 10];
        n /= 10;
    }
    if (n < MAX) {
        return memo[n] = sum;
    } else {
        return sum;
    }
}

int len[MAX];
int main()
{
    len[169] = len[363601] = len[1454] = 3;
    len[871] = len[45361] = len[872] = len[45362] = 2;

    int cnt{0};
    for (int n{1}; n < MAX; ++n) {
        int m{n};
        std::stack<int> stk;
        do {
            stk.push(m);
            if (const int next_m{next(m)}; next_m != m) {
                m = next_m;
            } else if (m < MAX) {
                len[m] = 1;
            }
        } while (m >= MAX || !len[m]);

        int l{0};
        while (!stk.empty()) {
            ++l;
            if (stk.top() < MAX) {
                len[stk.top()] = len[m] + l;
            }
            stk.pop();
        }

        if (len[n] == 60) {
            ++cnt;
        }
    }

    std::cout << cnt << '\n';
}
