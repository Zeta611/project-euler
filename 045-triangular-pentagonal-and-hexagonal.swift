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


func triangularNumber(_ n: Int) -> Int {
  return n * (n + 1) / 2
}


func pentagonalNumber(_ n: Int) -> Int {
  return n * (3 * n - 1) / 2
}


func hexagonalNumber(_ n: Int) -> Int {
  return n * (2 * n - 1)
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


func isPentagonal(_ p: Int) -> Bool {
  return solveQuadratic(3, -1, -2 * p) != nil
}


func isTriangular(_ t: Int) -> Bool {
  return solveQuadratic(1, 1, -2 * t) != nil
}


test("triangularNumber") { assert, complete in
  assert(triangularNumber(1) == 1)
  assert(triangularNumber(2) == 3)
  assert(triangularNumber(3) == 6)
  assert(triangularNumber(4) == 10)
  assert(triangularNumber(5) == 15)
  complete()
}

test("pentagonalNumber") { assert, complete in
  assert(pentagonalNumber(1) == 1)
  assert(pentagonalNumber(2) == 5)
  assert(pentagonalNumber(3) == 12)
  assert(pentagonalNumber(4) == 22)
  assert(pentagonalNumber(5) == 35)
  complete()
}

test("hexagonalNumber") { assert, complete in
  assert(hexagonalNumber(1) == 1)
  assert(hexagonalNumber(2) == 6)
  assert(hexagonalNumber(3) == 15)
  assert(hexagonalNumber(4) == 28)
  assert(hexagonalNumber(5) == 45)
  complete()
}

test("isTriangular") { assert, complete in
  assert(isTriangular(2) == false)
  assert(isTriangular(4) == false)
  assert(isTriangular(7) == false)
  assert(isTriangular(11) == false)
  assert(isTriangular(16) == false)
  assert(isTriangular(1) == true)
  assert(isTriangular(3) == true)
  assert(isTriangular(6) == true)
  assert(isTriangular(10) == true)
  assert(isTriangular(15) == true)
  complete()
}


var i = 143
loop: while true {
  i += 1
  let hexagonal = hexagonalNumber(i)
  if isPentagonal(hexagonal) && isTriangular(hexagonal) {
    print(hexagonal)
    break loop
  }
}
