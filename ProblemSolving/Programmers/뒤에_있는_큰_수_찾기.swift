import Foundation

func solution(_ numbers:[Int]) -> [Int] {
    var prevNumbers = [(offset: Int, number: Int)]()
    var answer = [Int](repeating: -1, count: numbers.count)
    
    numbers.enumerated().forEach { (offset, number) in
        print(prevNumbers)
        while !prevNumbers.isEmpty {
            if prevNumbers.last!.number < number {
                let current = prevNumbers.removeLast()
                answer[current.offset] = number
            } else {
                break
            }
        }
        
        prevNumbers.append((offset: offset, number: number))
    }
    
    return []
}
