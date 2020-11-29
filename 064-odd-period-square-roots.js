function square(n) {
  return n * n;
}

function quotient(a, b) {
  return (a - (a % b)) / b;
}

function isPerfectSquare(n) {
  return n === square(Math.floor(Math.sqrt(n)));
}

function isOdd(n) {
  return n % 2 === 1;
}

function period(n) {
  let result = 0;
  if (isPerfectSquare(n)) {
    return result;
  }

  const a0 = Math.floor(Math.sqrt(n));
  const b1 = a0;
  const c1 = n - square(a0);

  let an = a0;
  let bn = b1;
  let cn = c1;

  do {
    result += 1;
    an = quotient(a0 + bn, cn);
    bn = an * cn - bn;
    cn = (n - square(bn)) / cn;
  } while (!((bn === b1) && (cn === c1)));

  return result;
}

function solve() {
  let cnt = 0;
  for (let n = 1; n <= 10000; n += 1) {
    if (isOdd(period(n))) {
      cnt += 1;
    }
  }
  return cnt;
}

console.log(solve());
