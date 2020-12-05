function sqrt(value) {
  if (value < 0n) {
    throw new Error('value is negative');
  }
  if (value < 2n) {
    return value;
  }

  function newtonIteration(n, x0) {
    const x1 = (n / x0 + x0) >> 1n;
    if (x0 === x1 || x0 === (x1 - 1n)) {
      return x0;
    }
    return newtonIteration(n, x1);
  }

  return newtonIteration(value, 1n);
}

function square(n) {
  return n * n;
}

function quotient(n, q) {
  return (n - n % q) / q;
}

function isPerfectSquare(n) {
  return n === square(sqrt(n));
}

function isOdd(n) {
  return n % 2 === 1;
}

function ContinuedFractionInfo(period, a0, as) {
  this.period = period;
  this.a0 = a0;
  this.as = as;
}

function continuedFractionExpand(n) {
  let period = 0;
  if (isPerfectSquare(n)) {
    return new ContinuedFractionInfo(period, sqrt(n), []);
  }

  const a0 = sqrt(n);
  const b1 = a0;
  const c1 = n - square(a0);

  let an = a0;
  let bn = b1;
  let cn = c1;

  const as = [];
  do {
    period += 1;
    an = quotient(a0 + bn, cn);
    bn = an * cn - bn;
    cn = (n - square(bn)) / cn;
    as.push(an);
  } while (!((bn === b1) && (cn === c1)));

  return new ContinuedFractionInfo(period, a0, as);
}

function gcd(a, b) {
  if (b > a) {
    [a, b] = [b, a];
  }
  return b == 0 ? a : gcd(b, a % b);
}

function Fraction(numer, denom) {
  const g = gcd(numer, denom);
  this.numer = numer / g;
  this.denom = denom / g;

  this.add = (other) => new Fraction(
    this.numer * other.denom + this.denom * other.numer,
    this.denom * other.denom,
  );

  this.inverse = () => new Fraction(this.denom, this.numer);
}

function reduceContinuedFraction(a0, as) {
  if (as.length === 0) {
    return new Fraction(a0, 1n);
  }
  const tl = as.splice(1);
  const hd = as.pop();
  return reduceContinuedFraction(hd, tl)
    .inverse()
    .add(new Fraction(a0, 1n));
}

function Pair(x, y) {
  this.x = x;
  this.y = y;
}

function pell(d) {
  d = BigInt(d);
  if (isPerfectSquare(d)) {
    return null;
  }

  const cfInfo = continuedFractionExpand(d);
  let { as } = cfInfo;
  if (isOdd(cfInfo.period)) {
    as = as.concat(as);
  }
  as.pop();

  const frac = reduceContinuedFraction(cfInfo.a0, as);
  return new Pair(frac.numer, frac.denom);
}

function solve() {
  let x = 0;
  let result = null;
  for (let d = 1; d <= 1000; ++d) {
    const pair = pell(d);
    if (pair === null) {
      continue;
    }
    if (pair.x > x) {
      x = pair.x;
      result = new Pair(d, pair);
    }
  }
  return result;
}

console.log(solve());
