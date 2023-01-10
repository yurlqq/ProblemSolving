import Foundation

func solution(_ n:Int, _ m:Int, _ x:Int, _ y:Int, _ r:Int, _ c:Int, _ k:Int) -> String {
    var x = x
    var y = y
    
    var answer = [Character]()
    
    for i in 0..<k {
        if x < n {
            let nextDistance = abs(r - (x + 1)) + abs(c - y)
            if nextDistance < k - i {
                answer.append("d")
                x += 1

                continue
            }
        }
        if y > 1 {
            let nextDistance = abs(r - x) + abs(c - (y - 1))
            if nextDistance < k - i {
                answer.append("l")
                y -= 1

                continue
            }
        }
        if y < m {
            let nextDistance = abs(r - x) + abs(c - (y + 1))
            if nextDistance < k - i {
                answer.append("r")
                y += 1
                
                continue
            }
        }
        if x > 1 {
            let nextDistance = abs(r - (x - 1)) + abs(c - y)
            if nextDistance < k - i {
                answer.append("u")
                x -= 1
        
                continue
            }
        }
    }
    
    return answer.count == k ? String(answer) : "impossible"
}

