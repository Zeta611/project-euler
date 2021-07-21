#include <cmath>
#include <cstdlib>
#include <iostream>

long gcd(long a, long b)
{
    if (a < b) {
        const long tmp{a};
        a = b;
        b = tmp;
    }
    while (b) {
        const long tmp{b};
        b = a % b;
        a = tmp;
    }
    return a;
}

struct Fraction {
    long numerator = 0;
    long denominator = 1;

    Fraction(long n, long d, bool reduce = true)
    {
        if (d == 0) {
            exit(EXIT_FAILURE);
        }

        const bool negative{(n < 0 && d > 0) || (n > 0 && d < 0)};
        n = std::abs(n);
        d = std::abs(d);

        this->numerator = negative ? -n : n;
        this->denominator = d;
        if (reduce) {
            this->reduce();
        }
    }

    Fraction(long n) : numerator{n} {}
    Fraction() {}

    void reduce()
    {
        const long g{gcd(this->numerator, this->denominator)};
        this->denominator /= g;
        this->numerator /= g;
    }

    Fraction operator-() const
    {
        return Fraction{-this->numerator, this->denominator};
    }

    Fraction &operator++()
    {
        ++this->numerator;
        return *this;
    }

    Fraction operator++(int)
    {
        const Fraction tmp{*this};
        ++this->numerator;
        return tmp;
    }

    Fraction &operator--()
    {
        --this->numerator;
        return *this;
    }

    Fraction operator--(int)
    {
        const Fraction tmp{*this};
        --this->numerator;
        return tmp;
    }
};

Fraction operator+(const Fraction &a, const Fraction &b)
{
    return Fraction{a.numerator * b.denominator + a.denominator * b.numerator,
                    a.denominator * b.denominator};
}

Fraction operator-(const Fraction &a, const Fraction &b)
{
    return Fraction{a.numerator * b.denominator - a.denominator * b.numerator,
                    a.denominator * b.denominator};
}

Fraction operator*(const Fraction &a, const Fraction &b)
{
    return Fraction{a.numerator * b.numerator, a.denominator * b.denominator};
}

Fraction operator/(const Fraction &a, const Fraction &b)
{
    return Fraction{a.numerator * b.denominator, a.denominator * b.numerator};
}

bool operator==(const Fraction &a, const Fraction &b)
{
    return a.numerator == b.numerator && a.denominator == b.denominator;
}

bool operator>(const Fraction &a, const Fraction &b)
{
    return a.numerator * b.denominator > a.denominator * b.numerator;
}

bool operator>=(const Fraction &a, const Fraction &b)
{
    return a.numerator * b.denominator >= a.denominator * b.numerator;
}

bool operator<(const Fraction &a, const Fraction &b)
{
    return a.numerator * b.denominator < a.denominator * b.numerator;
}

bool operator<=(const Fraction &a, const Fraction &b)
{
    return a.numerator * b.denominator <= a.denominator * b.numerator;
}

std::ostream &operator<<(std::ostream &s, const Fraction &f)
{
    return s << f.numerator << '/' << f.denominator;
}

Fraction search_slightly_smaller_than(const Fraction &frac, long dlim)
{
    Fraction res;
    for (long d{3}; d <= dlim; ++d) {
        long left{1};
        long right{d - 1};
        Fraction f{left, d};
        while (left <= right) {
            const long middle{(left + right) / 2};
            const Fraction tmp{middle, d};
            if (tmp < frac) {
                f = tmp;
                left = middle + 1;
            } else {
                right = middle - 1;
            }
        }
        if (res < f) {
            res = f;
        }
    }
    res.reduce();
    return res;
}

int main()
{
    constexpr long MAX{1'000'000};
    const Fraction FRAC{3, 7};
    std::cout << search_slightly_smaller_than(FRAC, MAX) << '\n';
    return 0;
}
