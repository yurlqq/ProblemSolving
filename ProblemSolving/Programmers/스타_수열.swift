import Foundation

func solution(_ a:[Int]) -> Int {
    let counts = a.reduce(into: [:]) { dict, num in
        dict[num, default: 0] += 1
    }
    
    var answer = 0
    
    for key in counts.keys.sorted(by: { counts[$0]! > counts[$1]! }) {
        if counts[key]! < answer { return answer }
        answer = max(answer, getStarssequenceLength(in: a, intersection: key))
    }
    
    return answer
}

func getStarssequenceLength(in a: [Int], intersection: Int) -> Int {
    var result = 0
    var i = 0
    
    while i < a.count-1 {
        if a[i] == intersection && a[i+1] != intersection {
            result += 2
            i += 2
        } else if a[i] != intersection && a[i+1] == intersection {
            result += 2
            i += 2
        } else {
            i += 1
        }
    }
    
    return result
}
