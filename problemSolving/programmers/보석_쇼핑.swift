import Foundation

func solution(_ gems:[String]) -> [Int] {
    var answer = [1, gems.count]
    
    let gemSet = Set(gems)
    var count = [String: Int]()
    
    var head = 0
    var tail = 0
    
    while tail < gems.count && head <= tail {
        count[gems[tail], default: 0] += 1
        tail += 1
        
        while count.count == gemSet.count {
            count[gems[head]]! -= 1
            if count[gems[head]]! == 0 {
                count[gems[head]] = nil
            }
            head += 1
            
            if tail - head < answer[1] - answer[0] {
                answer = [head, tail]
            }
        }
    }
    
    return answer
}
