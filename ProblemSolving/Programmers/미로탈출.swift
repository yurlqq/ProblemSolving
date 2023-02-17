import Foundation

func solution(_ maps:[String]) -> Int {
    let maps = maps.map { Array($0) }
    
    func getDistance(from: [Int], to: [Int]) -> Int? {
        var queue: [() -> Int?] = []
        var counter = 0
        var visited: Set<[Int]> = []
        
        func bfs(_ coordinate: [Int], _ distance: Int) -> Int? {
            let x = coordinate[0]
            let y = coordinate[1]
            
            if x < 0 || x >= maps[0].count || y < 0 || y >= maps.count { return nil }
            if maps[y][x] == "X" { return nil }
            if !visited.insert(coordinate).inserted { return nil }
            if coordinate == to { return distance }
            
            queue.append { bfs([x+1, y], distance + 1) }
            queue.append { bfs([x-1, y], distance + 1) }
            queue.append { bfs([x, y+1], distance + 1) }
            queue.append { bfs([x, y-1], distance + 1) }
            
            return nil
        }
        
        queue.append { bfs(from, 0) }
        
        while queue.count > counter {
            if let current = queue[counter]() {
                return current
            } else {
                counter += 1
                continue
            }
        }
        
        return nil
    }
    
    var path: [[Int]] = [[],[],[]]
    
    for y in maps.indices {
        for x in maps[y].indices {
            if maps[y][x] == "S" { path[0] = [x, y] }
            if maps[y][x] == "L" { path[1] = [x, y] }
            if maps[y][x] == "E" { path[2] = [x, y] }
        }
    }
    
    if let distance1 = getDistance(from: path[0], to: path[1]),
       let distance2 = getDistance(from: path[1], to: path[2]) {
        return distance1 + distance2
    } else {
        return -1
    }
}
