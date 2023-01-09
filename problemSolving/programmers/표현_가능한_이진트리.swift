import Foundation

func solution(_ numbers:[Int64]) -> [Int] {
    return numbers.map { canExpress($0) ? 1: 0 }
}

func canExpress(_ number: Int64) -> Bool {
    var binary = Array(String(number, radix: 2))
    
    switch binary.count {
    case 1..<2:
        binary = [Character](repeating: "0", count: 1 - binary.count) + binary
    case 2..<4:
        binary = [Character](repeating: "0", count: 3 - binary.count) + binary
    case 4..<8:
        binary = [Character](repeating: "0", count: 7 - binary.count) + binary
    case 8..<16:
        binary = [Character](repeating: "0", count: 15 - binary.count) + binary
    case 16..<32:
        binary = [Character](repeating: "0", count: 31 - binary.count) + binary
    case 32..<64:
        binary = [Character](repeating: "0", count: 63 - binary.count) + binary
    default:
        print("unexpected value")
    }
    
    return dfs(binary)
}

func dfs(_ arr: [Character]) -> Bool {
    if arr.count == 1 { return true }
    
    let root = arr.count / 2
    let left = Array(arr[..<root])
    let right = Array(arr[root+1..<arr.count])
    
    if arr[root] == "0" {
        return !left.contains("1") && !right.contains("1")
    } else {
        return dfs(left) && dfs(right)
    }
}
