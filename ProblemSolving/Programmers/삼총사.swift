import Foundation

func solution(_ number:[Int]) -> Int {
    var answer = 0
    for first in 0..<number.count - 2 {
        for second in first + 1..<number.count - 1 {
            for third in second + 1..<number.count {
                if number[first] + number[second] + number[third] == 0 {
                    answer += 1
                }
            }
        }
    }

    return answer
}
