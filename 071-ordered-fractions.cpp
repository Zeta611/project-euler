#include <cmath>
#include <cstdlib>
#include <iostream>
#include <numeric>
#include <utility>

template <class T> struct Fraction {
    T numerator{0};
    T denominator{1};

    Fraction(T n, T d)
    {
        if (d == 0) {
            exit(EXIT_FAILURE);
        }

        const bool negative{n < 0 && d > 0 || n > 0 && d < 0};
        n = abs(n);
        d = abs(d);

        numerator = negative ? -n : n;
        denominator = d;
        reduce();
    }

    Fraction(T n) : numerator{n} {}
    Fraction() {}

    void reduce()
    {
        const T g{std::gcd(numerator, denominator)};
        denominator /= g;
        numerator /= g;
    }

    Fraction operator-() const { return Fraction{-numerator, denominator}; }

    Fraction &operator++()
    {
        numerator += denominator;
        return *this;
    }

    Fraction operator++(int)
    {
        const auto tmp{*this};
        numerator += denominator;
        return tmp;
    }

    Fraction &operator--()
    {
        numerator -= denominator;
        return *this;
    }

    Fraction operator--(int)
    {
        const auto tmp{*this};
        numerator -= denominator;
        return tmp;
    }
};

template <class T>
Fraction<T> operator+(const Fraction<T> &a, const Fraction<T> &b)
{
    return {a.numerator * b.denominator + a.denominator * b.numerator,
            a.denominator * b.denominator};
}

template <class T>
Fraction<T> operator-(const Fraction<T> &a, const Fraction<T> &b)
{
    return {a.numerator * b.denominator - a.denominator * b.numerator,
            a.denominator * b.denominator};
}

template <class T>
Fraction<T> operator*(const Fraction<T> &a, const Fraction<T> &b)
{
    return {a.numerator * b.numerator, a.denominator * b.denominator};
}

template <class T>
Fraction<T> operator/(const Fraction<T> &a, const Fraction<T> &b)
{
    return {a.numerator * b.denominator, a.denominator * b.numerator};
}

template <class T> bool operator==(const Fraction<T> &a, const Fraction<T> &b)
{
    return a.numerator == b.numerator && a.denominator == b.denominator;
}

template <class T> bool operator>(const Fraction<T> &a, const Fraction<T> &b)
{
    return a.numerator * b.denominator > a.denominator * b.numerator;
}

template <class T> bool operator>=(const Fraction<T> &a, const Fraction<T> &b)
{
    return a.numerator * b.denominator >= a.denominator * b.numerator;
}

template <class T> bool operator<(const Fraction<T> &a, const Fraction<T> &b)
{
    return a.numerator * b.denominator < a.denominator * b.numerator;
}

template <class T> bool operator<=(const Fraction<T> &a, const Fraction<T> &b)
{
    return a.numerator * b.denominator <= a.denominator * b.numerator;
}

template <class T>
std::ostream &operator<<(std::ostream &s, const Fraction<T> &f)
{
    return s << f.numerator << '/' << f.denominator;
}

Fraction<int> search_slightly_smaller_than(const Fraction<int> &frac, int dlim)
{
    Fraction<int> res;

    for (int d{3}; d <= dlim; ++d) {
        int left{1};
        int right{d - 1};
        Fraction f{left, d};

        while (left <= right) {
            const int middle{(left + right) / 2};
            if (const Fraction tmp{middle, d}; tmp < frac) {
                f = tmp;
                left = middle + 1;
            } else {
                right = middle - 1;
            }
        }
        res = std::max(res, f);
    }

    res.reduce();
    return res;
}

int main()
{
    constexpr int MAX{1'000'000};
    const Fraction FRAC{3, 7};

    std::cout << search_slightly_smaller_than(FRAC, MAX) << '\n';
}
