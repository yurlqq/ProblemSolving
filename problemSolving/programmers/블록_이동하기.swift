import Foundation

func solution(_ board:[[Int]]) -> Int {
    let n = board.count-1
    
    var queue = [() -> Int]()
    var visited = Set<[Int]>()
    
    func bfs(_ x1: Int, _ y1: Int, _ x2: Int, _ y2: Int, _ result: Int) -> Int {
        if x1 < 0 || y1 < 0 || x2 < 0 || y2 < 0 { return 0 } // board 인덱스 범위 미만
        if x1 > n || y1 > n || x2 > n || y2 > n { return 0 } // board 인덱스 범위 초과
        if board[y1][x1] > 0 || board[y2][x2] > 0 { return 0 } // 잘못된 board 로 이동
        if !visited.insert([x1, y1, x2, y2]).inserted { return 0 } // 이미 방문한 위치
        if (x1 == n && y1 == n) || (x2 == n && y2 == n) { return result } // 도착 시
        
        queue.append { bfs(x1+1, y1, x2+1, y2, result+1) } // 우로 이동
        queue.append { bfs(x1, y1+1, x2, y2+1, result+1) } // 하로 이동
        queue.append { bfs(x1-1, y1, x2-1, y2, result+1) } // 좌로 이동
        queue.append { bfs(x1, y1-1, x2, y2-1, result+1) } // 상으로 이동
        
        if y1 == y2 { // 가로 방향으로 놓여 있을 때의 회전
            if y1 > 0 {
                if board[y1-1][x2] < 1 {
                    queue.append { bfs(x1, y1-1, x1, y1, result+1) }
                }
                if board[y1-1][x1] < 1 {
                    queue.append { bfs(x2, y2-1, x2, y2, result+1) }
                }
            }
            if y1 < n {
                if board[y1+1][x2] < 1 {
                    queue.append { bfs(x1, y1, x1, y1+1, result+1) }
                }
                if board[y1+1][x1] < 1 {
                    queue.append { bfs(x2, y2, x2, y2+1, result+1) }
                }
            }
        } else { // 세로 방향으로 놓여 있을 때의 회전
            if x1 > 0 {
                if board[y1][x1-1] < 1 {
                    queue.append { bfs(x2-1, y2, x2, y2, result+1) }
                }
                if board[y2][x2-1] < 1 {
                    queue.append { bfs(x1-1, y1, x1, y1, result+1) }
                }
            }
            if x1 < n {
                if board[y1][x1+1] < 1 {
                    queue.append { bfs(x2, y2, x2+1, y2, result+1) }
                }
                if board[y2][x2+1] < 1 {
                    queue.append { bfs(x1, y1, x1+1, y1, result+1) }
                }
            }
        }
        
        return 0
    }
    
    queue.append { bfs(0, 0, 1, 0, 0) }
    
    var counter = 0 // queue 를 위한 counter
    
    while counter < queue.count {
        let answer = queue[counter]()
        if answer > 0 { return answer }
        counter += 1
    }
    
    return -1
}
