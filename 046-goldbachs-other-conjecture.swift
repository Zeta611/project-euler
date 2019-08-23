import Foundation

func checkPrime(_ n: Int) -> Bool {
  if n < 2 || n == 4 { return false }
  if n == 2 || n == 3 { return true }
  for i in stride(from: 3, through: Int(pow(Double(n), 0.5)) + 1, by: 2) {
    if n.isMultiple(of: i) { return false }
  }
  return true
}

var n = 33
while true {
  n += 2
  if checkPrime(n) { continue }
  var found = false
  for p in stride(from: 3, to: n, by: 2) {
    guard checkPrime(p), (n - p).isMultiple(of: 2) else { continue }
    let squared = (n - p) / 2
    let sqrt = Int(round(pow(Double(squared), 0.5)))
    if sqrt * sqrt == squared {
      found = true
      break
    }
  }
  if !found {
    print(n)
    break
  }
}
