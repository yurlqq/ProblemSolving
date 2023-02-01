import Foundation

func solution(_ land:[[Int]], _ p:Int, _ q:Int) -> Int64 {
    let land = land.flatMap { $0 }.sorted()
    
    var cost = q * (land.reduce(0, +) - land.count * land[0])
    var answer = cost
    var visited: Set<Int> = [land[0]]
    
    for i in 1..<land.count {
        if !visited.insert(land[i]).inserted { continue }
        cost += (p * i * (land[i] - land[i-1])) - (q * (land.count - i) * (land[i] - land[i-1]))
        answer = min(answer, cost)
    }
    
    return Int64(answer)
}
