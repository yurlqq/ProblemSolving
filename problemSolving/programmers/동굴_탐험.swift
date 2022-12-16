import Foundation

func solution(_ n:Int, _ path:[[Int]], _ order:[[Int]]) -> Bool {
    var paths = [[Int]](repeating: [Int](), count: n)
    path.forEach { connection in
        paths[connection[0]].append(connection[1])
        paths[connection[1]].append(connection[0])
    }
    
    var inDegrees = getInDegrees(root: 0, paths: paths, order: order)
    
    order.forEach { connection in
        paths[connection[0]].append(connection[1])
    }
    
    if inDegrees[0] > 0 { return false }
    
    var queue = [0]
    var counter = 0
    
    while queue.count > counter {
        let current = queue[counter]
        counter += 1
        
        paths[current].forEach { next in
            inDegrees[next] -= 1
            if inDegrees[next] == 0 {
                queue.append(next)
            }
        }
    }
    
    return counter == n
}

func getInDegrees(root: Int, paths: [[Int]], order: [[Int]]) -> [Int] {
    var result = [Int](repeating: 0, count: paths.count)
    order.forEach { result[$0[1]] += 1 }
    
    var visited = Set([0])

    func traverse(_ current: Int) {
        if !visited.insert(current).inserted { return }
        result[current] += 1
        paths[current].forEach { traverse($0) }
    }
    
    paths[root].forEach { traverse($0) }
    
    return result
}
