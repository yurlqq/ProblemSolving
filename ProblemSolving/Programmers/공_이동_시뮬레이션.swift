import Foundation

func solution(_ n:Int, _ m:Int, _ x:Int, _ y:Int, _ queries:[[Int]]) -> Int64 {
    var first = [x, y]
    var last = [x, y]
    
    for query in queries.reversed() {
        switch query[0] {
        case 0:
            last[1] = min(last[1] + query[1], m-1)
            if first[1] > 0 {
                first[1] += query[1]
                if first[1] >= m { return Int64(0) }
            }
        case 1:
            first[1] = max(first[1] - query[1], 0)
            if last[1] < m-1 {
                last[1] -= query[1]
                if last[1] < 0 { return Int64(0) }
            }
        case 2:
            last[0] = min(last[0] + query[1], n-1)
            if first[0] > 0 {
                first[0] += query[1]
                if first[0] >= n { return Int64(0) }
            }
        case 3:
            first[0] = max(first[0] - query[1], 0)
            if last[0] < n-1 {
                last[0] -= query[1]
                if last[0] < 0 { return Int64(0) }
            }
        default:
            print("err")
        }
    }
    
    return Int64((last[0] - first[0] + 1) * (last[1] - first[1] + 1))
}
