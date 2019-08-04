typealias Pair = ([Int], [Int])

func generate(from pair: Pair) -> [Pair] {
  let (permutation, source) = pair
  return source.enumerated()
    .map {
      var capturedPermutation = permutation
      var capturedSource = source
      capturedPermutation.append(capturedSource.remove(at: $0.0))
      return (capturedPermutation, capturedSource)
    }
}

func checkSubstring(_ permutation: [Int]) -> Bool {
  return
    Int(permutation[1...3].map { String($0) }.joined())!.isMultiple(of: 2) &&
    Int(permutation[2...4].map { String($0) }.joined())!.isMultiple(of: 3) &&
    Int(permutation[3...5].map { String($0) }.joined())!.isMultiple(of: 5) &&
    Int(permutation[4...6].map { String($0) }.joined())!.isMultiple(of: 7) &&
    Int(permutation[5...7].map { String($0) }.joined())!.isMultiple(of: 11) &&
    Int(permutation[6...8].map { String($0) }.joined())!.isMultiple(of: 13) &&
    Int(permutation[7...9].map { String($0) }.joined())!.isMultiple(of: 17)
}

var permutationPairs = [([Int](), Array(0...9))]
(1...10)
  .forEach { _ in permutationPairs = permutationPairs.flatMap(generate) }

print(permutationPairs.reduce(0) {
  $0 + (checkSubstring($1.0) ? Int($1.0.map { String($0) }.joined())! : 0)
})
