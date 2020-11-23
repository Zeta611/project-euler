function arePermutations(n, m) {
  const digits = [];
  while (n) {
    const d = n % 10;
    if (d in digits) {
      digits[d] += 1;
    } else {
      digits[d] = 1;
    }
    n = (n - d) / 10;
  }
  while (m) {
    const d = m % 10;
    digits[d] -= 1;
    m = (m - d) / 10;
  }
  return digits.every((d) => d === 0);
}

function solve() {
  const table = [];
  for (let cand = 1; ; cand += 1) {
    table[cand] = {
      cube: cand * cand * cand,
      permCount: 1,
      groupLeastElement: cand,
    };
    for (let n = cand - 1; n > 0 && table[cand].cube / 10 < table[n].cube; n -= 1) {
      if (arePermutations(table[cand].cube, table[n].cube)) {
        table[cand].permCount = table[n].permCount + 1;
        table[cand].groupLeastElement = table[n].groupLeastElement;
        break;
      }
    }
    if (table[cand].permCount === 5) {
      const m = table[cand].groupLeastElement;
      return table[m].cube;
    }
  }
}

console.log(solve());
