import Foundation

func solution(_ n:Int, _ results:[[Int]]) -> Int {
    var children = [Int: Set<Int>]()
    var parents = [Int: Set<Int>]()
    
    for i in 1...n {
        children[i] = Set<Int>()
        parents[i] = Set<Int>()
    }
    
    results.forEach { result in
        children[result[0]]!.insert(result[1])
        parents[result[1]]!.insert(result[0])
    }
    
    var ancestors = [Int: Set<Int>]()
    var descendants = [Int: Set<Int>]()
    
    func getAncestors(_ node: Int, _ current: Int) {
        if ancestors[node, default: Set<Int>()].insert(current).inserted {
            parents[current]!.forEach { getAncestors(node, $0) }
        }
    }
    
    func getDescendants(_ node: Int, _ current: Int) {
        if descendants[node, default: Set<Int>()].insert(current).inserted {
            children[current]!.forEach { getDescendants(node, $0) }
        }
    }
    
    for i in 1...n {
        getAncestors(i, i)
        getDescendants(i, i)
    }
    
    return (1...n).filter { ancestors[$0]!.count + descendants[$0]!.count > n }.count
}
