import Foundation

func solution(_ rows:Int, _ columns:Int, _ queries:[[Int]]) -> [Int] {
    var matrix = [[Int]]()
    
    for i in 0..<rows {
        matrix.append([Int]())
        for j in 0..<columns {
            matrix[i].append(columns * i + j + 1)
        }
    }
    
    return queries.map { rotate(query: $0, to: &matrix) }
}

func rotate(query: [Int], to matrix: inout [[Int]]) -> Int {
    let query = query.map { $0 - 1 }
    
    var targetIndices = [(x: Int, y: Int)]()
    var rotatedNumber = [Int]()
    
    for i in stride(from: query[1], to: query[3] , by: 1) {
        targetIndices.append((x: i, y: query[0]))
        rotatedNumber.append(matrix[query[0]][i])
    }
    for i in stride(from: query[0], to: query[2] , by: 1) {
        targetIndices.append((x: query[3], y: i))
        rotatedNumber.append(matrix[i][query[3]])
    }
    for i in stride(from: query[3], to: query[1] , by: -1) {
        targetIndices.append((x: i, y: query[2]))
        rotatedNumber.append(matrix[query[2]][i])
    }
    for i in stride(from: query[2], to: query[0] , by: -1) {
        targetIndices.append((x: query[1], y: i))
        rotatedNumber.append(matrix[i][query[1]])
    }
    
    for i in targetIndices.indices {
        let x = targetIndices[i].x
        let y = targetIndices[i].y
        
        matrix[y][x] = i != 0 ? rotatedNumber[i-1] : rotatedNumber.last!
    }
    
    return rotatedNumber.min()!
}
