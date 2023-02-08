import Foundation

func solution(_ clockHands:[[Int]]) -> Int {
    var answer = Int.max
    
    for id in 0..<NSDecimalNumber(decimal: pow(4, clockHands.count)).intValue {
        var puzzle = Puzzle(clockHands: clockHands, id: id)
        
        for y in 1..<clockHands.count {
            for x in 0..<clockHands.count {
                puzzle.rotate(coordinate: [x, y], type: (4 - puzzle.matrix[y-1][x]) % 4 )
            }
        }
        
        if puzzle.matrix.last!.allSatisfy({ $0 == 0 }) {
            answer = min(answer, puzzle.rotationCount)
        }
    }
    
    return answer
}

struct Puzzle {
    var matrix: [[Int]]
    var rotationCount = 0
    
    init(clockHands: [[Int]], id: Int) {
        self.matrix = clockHands
        
        var temp = id
        var digit = 0
        
        while temp > 0 {
            self.rotate(coordinate: [digit, 0], type: temp % 4)
            temp /= 4
            digit += 1
        }
    }
    
    mutating func rotate(coordinate: [Int], type: Int) {
        let x = coordinate[0]
        let y = coordinate[1]
        
        self.matrix[y][x] = (self.matrix[y][x] + type) % 4
        if y > 0 { self.matrix[y-1][x] = (self.matrix[y-1][x] + type) % 4 }
        if x > 0 { self.matrix[y][x-1] = (self.matrix[y][x-1] + type) % 4 }
        if y < self.matrix.count-1 { self.matrix[y+1][x] = (self.matrix[y+1][x] + type) % 4 }
        if x < self.matrix.count-1 { self.matrix[y][x+1] = (self.matrix[y][x+1] + type) % 4 }
        
        self.rotationCount += type
    }
}
