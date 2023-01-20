import Foundation

func solution(_ edges:[[Int]], _ target:[Int]) -> [Int] {
    var nodes = [Node]()
    var target = target
    
    for i in target.indices { nodes.append(Node(i+1)) }
    for edge in edges { nodes[edge[0]-1].append(nodes[edge[1]-1]) }
    
    var dropCount = [Int](repeating: 0, count: target.count)
    var order = [Int]()
    
ex: while true {
        let leaf = nodes[0].drop()
        order.append(leaf)
        
        dropCount[leaf-1] += 1
        
        for i in target.indices {
            if dropCount[i] > target[i] { return [-1] }
            if target[i] > dropCount[i] * 3 { continue ex }
        }
    
        break
    }
    
    var orderCount = order.reduce(into: [:]) { dict, number in
        dict[number, default: 0] += 1
    }
    
    var answer = [Int]()
    
    for number in order {
        orderCount[number]! -= 1
        
        let dropNumber =
            orderCount[number]! * 3 < target[number-1] ?
            target[number-1] - orderCount[number]! * 3 : 1
                
        answer.append(dropNumber)
        target[number-1] -= dropNumber
    }
    
    return answer
}

class Node: Comparable {
    let number: Int
    var children: [Node] = []
    var order = 0
    
    init(_ number: Int) { self.number = number }
    
    func append(_ child: Node) {
        children.append(child)
        children.sort()
    }
    
    func drop() -> Int {
        if children.isEmpty {
            return number
        } else {
            let temp = order
            order = (order + 1) % children.count
            return children[temp].drop()
        }
    }
    
    static func < (lhs: Node, rhs: Node) -> Bool {
        return lhs.number < rhs.number
    }
    
    static func == (lhs: Node, rhs: Node) -> Bool {
        lhs.number == rhs.number
    }
}
