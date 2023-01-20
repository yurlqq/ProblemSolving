import Foundation

func solution(_ line:[[Int]]) -> [String] {
    var interactionPoints = [[Int]]()
    
    for i in 0..<line.count {
        for j in 0..<i {
            if i == j { continue }
            if let interactionPoint = getInteractionPoint(line[i], line[j]) {
                interactionPoints.append(interactionPoint)
            }
        }
    }
    
    let sortedByX = interactionPoints.sorted { $0[0] < $1[0] }
    let sortedByY = interactionPoints.sorted { $0[1] < $1[1] }
    
    let answerX = sortedByX.last![0] - sortedByX[0][0] + 1
    let answerY = sortedByY.last![1] - sortedByY[0][1] + 1
    
    var answer = [[Character]](repeating: [Character](repeating: ".", count: answerX), count: answerY)
    
    interactionPoints.forEach { point in
        answer[sortedByY.last![1]-point[1]][point[0]-sortedByX[0][0]] = "*"
    }
    
    return answer.map { String($0) }
}

func getInteractionPoint(_ a: [Int], _ b: [Int]) -> [Int]? {
    let slope = a[0] * b[1] - b[0] * a[1]
    if slope == 0 { return nil }
    
    let x = a[1] * b[2] - b[1] * a[2]
    if x % slope != 0 { return nil}
    
    let y = a[2] * b[0] - b[2] * a[0]
    if y % slope != 0 { return nil}
    
    return [x/slope, y/slope]
}
