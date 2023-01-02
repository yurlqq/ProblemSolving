import Foundation

func solution(_ numbers:[Int]) -> Int {
    return 45 - numbers.reduce(0, +)    // 없는 숫자는, (1부터 9까지 더한) 45에다가 numbers에 있는 숫자를 뺀 값과 같다.
}
