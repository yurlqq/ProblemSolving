import Foundation

func solution(_ maps:[String]) -> [Int] {
    let maps = maps.map { Array($0) }
    
    var answer = [Int]()
    var visited = Set<[Int]>()
    
    func dfs(_ x: Int, _ y: Int) -> Int {
        if x < 0 || x >= maps[0].count || y < 0 || y >= maps.count { return 0 }
        if maps[y][x].isLetter { return 0 }
        if !visited.insert([x, y]).inserted { return 0 }
        
        return Int(String(maps[y][x]))! + dfs(x, y - 1) + dfs(x, y + 1) + dfs(x - 1, y) + dfs(x + 1, y)
    }
    
    for y in maps.indices {
        for x in maps[y].indices {
            let current = dfs(x, y)
            if current > 0 {
                answer.append(current)
            }
        }
    }
    
    return answer.isEmpty ? [-1] : answer.sorted()
}
