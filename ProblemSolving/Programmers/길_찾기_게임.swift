import Foundation

func solution(_ nodeinfo:[[Int]]) -> [[Int]] {
    var root: Node
    
    nodeinfo.enumerated()
        .sorted { a, b in
            if a.element[1] == b.element[1] {
                return a.element[0] < b.element[0]
            } else {
                return a.element[1] > b.element[1]
            }
        }
        .forEach { node in
            let current = Node(node.offset+1, node.element)
            if root == nil {
                root = current
            } else {
                root?.append(current)
            }
        }
    
    return [root!.getPreorder(), root!.getPostorder()]
}

class Node {
    let id: Int
    let coordinate: [Int]
    
    var left: Node? = nil
    var right: Node? = nil
    
    init(_ id: Int, _ coordinate: [Int]) {
        self.id = id
        self.coordinate = coordinate
    }
    
    func append(_ node: Node) {
        if self.coordinate[0] > node.coordinate[0] {
            if let next = self.left {
                next.append(node)
            } else {
                self.left = node
            }
        } else {
            if let next = self.right {
                next.append(node)
            } else {
                self.right = node
            }
        }
    }
    
    func getPreorder() -> [Int] {
        var result = [Int]()
        
        result.append(self.id)
        result += left?.getPreorder() ?? []
        result += right?.getPreorder() ?? []
        
        return result
    }
    
    func getPostorder() -> [Int] {
        var result = [Int]()
        
        result += left?.getPostorder() ?? []
        result += right?.getPostorder() ?? []
        result.append(self.id)
        
        return result
    }
}
