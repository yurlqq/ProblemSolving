import Foundation

func solution(_ n:Int, _ times:[Int]) -> Int64 {
    var answer = Int64(0)
    var high = 1_000_000_000 * n
    var low = 1
    
    while low <= high {
        let mid = (high + low) / 2
        if times.reduce(0, { $0 + mid / $1 }) < n {
            low = mid + 1
        } else {
            high = mid - 1
            answer = Int64(mid)
        }
    }
    
    return answer
}
