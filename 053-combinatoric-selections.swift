import Foundation

func pascal(size: Int) -> [[Int]] {
    // triangle[n][r] = nCr
    var triangle = [[Int]](repeating: [], count: size + 1)
    for n in 0...size {
        triangle[n] = [Int](repeating: 0, count: n + 1)
    }

    triangle[0] = [1]
    triangle[1] = [1, 1]
    for n in 2...size {
        triangle[n][0] = 1
        triangle[n][n] = 1
        for r in 1...n - 1 {
            let left = triangle[n - 1][r - 1]
            let right = triangle[n - 1][r]
            if left == -1 || right == -1 {
                triangle[n][r] = -1
            } else {
                let sum = left + right
                triangle[n][r] = sum <= 1_000_000 ? sum : -1
            }
        }
    }

    return triangle
}

let start = DispatchTime.now()

print(pascal(size: 100).flatMap { $0 }.filter { $0 == -1 }.count)

let end = DispatchTime.now()
let seconds = end.uptimeNanoseconds - start.uptimeNanoseconds
print("Took \(Double(seconds) / 1_000_000.0) ms")
// 7.242482 ms
