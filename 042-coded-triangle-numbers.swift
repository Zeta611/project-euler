import Foundation


func getAlphabetOrder(of alphabet: String) -> UInt32? {
  let normalizedAlphabet = alphabet.uppercased()
  let referenceOrder = UnicodeScalar("A").value
  guard let value = UnicodeScalar(normalizedAlphabet)?.value else {
    return nil
  }
  return value - referenceOrder + 1
}


func readFromFile(_ name: String) -> [String]? {
  guard let content = try? NSString(
    contentsOfFile: name,
    encoding: String.Encoding.utf8.rawValue
  ) else { return nil }

  return content
    .replacingOccurrences(of: "\"", with: "")
    .components(separatedBy: ",")
}


func solveQuadratic(a: Double, b: Double, c: Double) -> (Double, Double) {
  let D = (b * b - 4 * a * c).squareRoot()
  return ((-b + D) / (2 * a), (-b - D) / (2 * a))
}


func checkTriangleNumber(_ number: Int) -> Bool {
  // Find n such that number = 1/2 * n * (n + 1)
  let n = solveQuadratic(a: 1, b: 1, c: -2 * Double(number)).0
  return n == n.rounded()
}


let inputData = readFromFile("p042-words.txt")?
  .map {
    Array($0).reduce(0) {
      $0 + (getAlphabetOrder(of: String($1)) ?? 0)
    }
  }
  .map { checkTriangleNumber(Int($0)) }

print(inputData!.reduce(0) { $0 + ($1 ? 1 : 0) })
