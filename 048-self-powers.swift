import Foundation


let start = DispatchTime.now().uptimeNanoseconds

var sum = 0
for n in 1...1000 {
  var product = 1
  for _ in 0..<n {
    product *= n
    product %= 10_000_000_000
  }
  sum += product
  sum %= 10_000_000_000
}
print(sum)

let end = DispatchTime.now().uptimeNanoseconds
let seconds = Double(end - start) / 1_000_000_000
print("Took \(seconds) seconds")
// 0.00705290 seconds
