import Foundation

typealias Assertion = (Bool) -> Void
typealias Completion = () -> Void

func test(
  _ name: String,
  block: (@escaping Assertion, @escaping Completion) -> Void)
{
  var pass = true
  var assertionCount = 0

  let assert: Assertion = { value in
    assertionCount += 1
    pass = pass && value
  }

  let finish: Completion = {
    if pass {
      print("👌 \(name) passed with \(assertionCount) assertions.")
    } else {
      print("🙅‍♂️ \(name) failed with \(assertionCount) assertions.")
    }
  }

  block(assert, finish)
}

func solveQuadratic(_ a: Int, _ b: Int, _ c: Int) -> Int? {
  let temp = b * b - c * 4 * a
  guard temp >= 0 else { return nil }
  let doubleSqrt = pow(Double(temp), 0.5)
  let intSqrt = Int(round(doubleSqrt))
  guard intSqrt * intSqrt == temp else { return nil }
  let solution = (-b + intSqrt) / (2 * a)
  guard solution * 2 * a == -b + intSqrt else { return nil }
  return solution
}

func pentagonNumber(_ n: Int) -> Int {
  return n * (3 * n - 1) / 2
}

func isPentagon(_ p: Int) -> Bool {
  return solveQuadratic(3, -1, -2 * p) != nil
}


test("solveQuadratic") { assert, complete in
  assert(solveQuadratic(1, 0, 0) == 0)
  assert(solveQuadratic(1, 0, -1) == 1)
  assert(solveQuadratic(1, 0, 1) == nil)
  assert(solveQuadratic(1, 2, 1) == -1)
  assert(solveQuadratic(1, -2, 1) == 1)
  complete()
}

test("pentagonNumber") { assert, complete in
  assert(pentagonNumber(1) == 1)
  assert(pentagonNumber(2) == 5)
  assert(pentagonNumber(3) == 12)
  assert(pentagonNumber(4) == 22)
  assert(pentagonNumber(5) == 35)
  assert(pentagonNumber(6) == 51)
  complete()
}

test("isPentagon") { assert, complete in
  assert(isPentagon(1) == true)
  assert(isPentagon(5) == true)
  assert(isPentagon(12) == true)
  assert(isPentagon(22) == true)
  assert(isPentagon(35) == true)
  assert(isPentagon(51) == true)
  complete()
}

var i = 0
loop: while true {
  i += 1
  for j in 1...i {
    let p1 = pentagonNumber(i)
    let p2 = pentagonNumber(j)
    if isPentagon(p1 - p2) && isPentagon(p1 + p2) {
      print(p1 - p2)
      break loop
    }
  }
}
