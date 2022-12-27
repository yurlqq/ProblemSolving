import Foundation

func solution(_ s:String) -> Int {
    let numbers = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
    
    var answer = s
    numbers.enumerated().forEach { num, eng in
        answer = answer.replacingOccurrences(of: eng, with: "\(num)")
    }
    
    return Int(answer)!
}
