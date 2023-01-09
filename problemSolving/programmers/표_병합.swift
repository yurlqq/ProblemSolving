import Foundation

func solution(_ commands:[String]) -> [String] {
    var answer = [String]()
    var cell = Cell()
    
    commands.forEach { str in
        let command = str.components(separatedBy: " ")
        
        switch command[0] {
        case "UPDATE":
            if command.count > 3 {
                let r = Int(command[1])!
                let c = Int(command[2])!
                let value = command[3]
                
                cell.update(r: r, c: c, value: value)
            } else {
                let value1 = command[1]
                let value2 = command[2]
                
                cell.update(value1, changeTo: value2)
            }
            
        case "MERGE":
            let r1 = Int(command[1])!
            let c1 = Int(command[2])!
            let r2 = Int(command[3])!
            let c2 = Int(command[4])!
            
            cell.merge(r1, c1, r2, c2)
            
        case "UNMERGE":
            let r = Int(command[1])!
            let c = Int(command[2])!

            cell.unmerge(r, c)
            
        case "PRINT":
            let r = Int(command[1])!
            let c = Int(command[2])!
            let result = cell.print(r, c)
            
            answer.append(result)
            
        default:
            print("unexpected command")
        }
    }
    
    return answer
}

struct Cell {
    var cell = [[String?]](repeating: [String?](repeating: nil, count: 51), count: 51)
    var merged = [[Int]: [[Int]]]()
    
    init() {
        for i in cell.indices {
            for j in cell.indices {
                self.merged[[i,j]] = [[i,j]]
            }
        }
    }
    
    mutating func update(r: Int, c: Int, value: String) {
        merged[[r,c]]!.forEach { coordinate in
            let row = coordinate[0]
            let col = coordinate[1]
            
            self.cell[row][col] = value
        }
        
    }
    
    mutating func update(_ value1: String, changeTo value2: String) {
        for i in cell.indices {
            for j in cell[i].indices {
                if self.cell[i][j] == value1 {
                    self.cell[i][j] = value2
                }
            }
        }
    }
    
    mutating func merge(_ r1: Int, _ c1: Int, _ r2: Int, _ c2: Int) {
        if merged[[r1, c1]]!.contains([r2, c2]) { return }

        if let value = self.cell[r1][c1] {
            let merged1 = self.merged[[r1, c1]]!
            let merged2 = self.merged[[r2, c2]]!
            
            self.merged[[r1, c1]]!.forEach { coordinate in
                let row = coordinate[0]
                let col = coordinate[1]
                
                merged[[row, col]]! += merged2
            }
            self.merged[[r2, c2]]!.forEach { coordinate in
                let row = coordinate[0]
                let col = coordinate[1]
                
                cell[row][col] = value
                merged[[row, col]]! += merged1
            }
            
        } else {
            let value = self.cell[r2][c2]
            let merged1 = self.merged[[r1, c1]]!
            let merged2 = self.merged[[r2, c2]]!
            
            self.merged[[r1, c1]]!.forEach { coordinate in
                let row = coordinate[0]
                let col = coordinate[1]
                
                cell[row][col] = value
                merged[[row, col]]! += merged2
            }
            self.merged[[r2, c2]]!.forEach { coordinate in
                let row = coordinate[0]
                let col = coordinate[1]
                
                merged[[row, col]]! += merged1
            }
        }
    }
    
    mutating func unmerge(_ r: Int, _ c: Int) {
        let value = self.cell[r][c]

        self.merged[[r, c]]!.forEach { coordinate in
            let row = coordinate[0]
            let col = coordinate[1]

            self.cell[row][col] = nil
            self.merged[[row, col]] = [[row, col]]
        }

        self.cell[r][c] = value
    }
    
    func print(_ r: Int, _ c: Int) -> String {
        return self.cell[r][c] ?? "EMPTY"
    }
}
