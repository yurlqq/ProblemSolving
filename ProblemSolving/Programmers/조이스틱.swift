import Foundation

func solution(_ name:String) -> Int {
    let name = name.map { $0 }
    let visited = Set(name.enumerated().filter { $0.element == "A" }.map { $0.offset })
    var answer = Int.max
    
    func getIndex(_ i: Int) -> Int {
        return (name.count + i) % name.count
    }
    
    func moveJoystick(index: Int, derection: Int, isDirectionNotChanged: Bool, visited: Set<Int>, moveCount: Int) {
        var visited = visited
        visited.insert(index)
        
        if visited.count == name.count {
            answer = min(answer, moveCount)
            return
        }
        
        if name[getIndex(index + derection)] == "A" && isDirectionNotChanged {
            moveJoystick(index: getIndex(index - derection),
                         derection: -derection,
                         isDirectionNotChanged: !isDirectionNotChanged,
                         visited: visited,
                         moveCount: moveCount + 1)
        }
        
        moveJoystick(index: getIndex(index + derection),
                     derection: +derection,
                     isDirectionNotChanged: isDirectionNotChanged,
                     visited: visited,
                     moveCount: moveCount + 1)
    }

    moveJoystick(index: 0, derection: +1, isDirectionNotChanged: true, visited: visited, moveCount: 0)
    moveJoystick(index: 0, derection: -1, isDirectionNotChanged: true, visited: visited, moveCount: 0)

    return answer + name.map { Int($0.asciiValue!) }.reduce(0) { $0 + min($1-65, 91-$1) }
}
