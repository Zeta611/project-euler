function countDigits(n) {
  for (var count = 0; n > 0; ++count) {
    n = (n - n % 10n) / 10n;
  }
  return count;
}

function gcd(a, b) {
  if (b > a) {
    [a, b] = [b, a];
  }
  if (b === 1n) {
    return 1n;
  } else if (b === 0n) {
    return a;
  } else {
    return gcd(b, a % b);
  }
}

function Fraction(numer, denom) {
  const g = gcd(numer, denom);
  this.numer = numer / g;
  this.denom = denom / g;

  this.add = other => new Fraction(
    this.numer * other.denom + this.denom * other.numer,
    this.denom * other.denom);

  this.inverse = () => new Fraction(this.denom, this.numer);
}

Fraction.one = new Fraction(1n, 1n);

function memo(f) {
  const array = [];
  return function(n) {
    if (array[n] === undefined) {
      const result = f(n);
      array[n] = result;
      return result;
    } else {
      return array[n];
    }
  }
}

const expansion = memo(function(n) {
  if (n === 0) {
    return Fraction.one;
  }
  return expansion(n - 1)
    .add(Fraction.one)
    .inverse()
    .add(Fraction.one);
});

function solve(n) {
  let count = 0;
  for (let i = 1; i <= n; ++i) {
    const frac = expansion(i);
    if (countDigits(frac.numer) > countDigits(frac.denom)) {
      ++count;
    }
  }
  return count;
}

console.log(solve(1000));