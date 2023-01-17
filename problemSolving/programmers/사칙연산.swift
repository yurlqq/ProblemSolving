import Foundation

func solution(_ input:[String]) -> Int {
    let numbers = stride(from: 0, to: input.count, by: 2).map { Int(input[$0])! }
    let operations = stride(from: 1, to: input.count, by: 2).map { input[$0] }
    
    var maxDP = [[Int]](repeating: [Int](repeating: Int.min , count: numbers.count), count: numbers.count)
    var minDP = [[Int]](repeating: [Int](repeating: Int.max , count: numbers.count), count: numbers.count)
    
    for i in numbers.indices {
        maxDP[i][i] = numbers[i]
        minDP[i][i] = numbers[i]
    }
    
    for step in 1..<numbers.count {
        for i in 0..<numbers.count - step {
            let j = i + step
            
            for k in i..<j {
                if operations[k] == "+" {
                    maxDP[i][j] = max(maxDP[i][j], maxDP[i][k] + maxDP[k+1][j])
                    minDP[i][j] = min(minDP[i][j], minDP[i][k] + minDP[k+1][j])
                } else {
                    maxDP[i][j] = max(maxDP[i][j], maxDP[i][k] - minDP[k+1][j])
                    minDP[i][j] = min(minDP[i][j], minDP[i][k] - maxDP[k+1][j])
                }
            }
        }
    }

    return maxDP[0].last!
}
