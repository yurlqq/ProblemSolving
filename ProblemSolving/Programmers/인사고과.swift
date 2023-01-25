import Foundation

func solution(_ scores:[[Int]]) -> Int {
    let wonhoScore = scores[0]
    var maxScore = 0
    var canWonhoGetIncentive = true
    
    let wonhoRank =
        scores.sorted { $0[0] != $1[0] ? $0[0] > $1[0] : $0[1] < $1[1] }
            .filter { score in
                maxScore = max(maxScore, score[1])
                if score[0] > wonhoScore[0] && score[1] > wonhoScore[1] {
                    canWonhoGetIncentive = false
                }
                
                return score[1] >= maxScore &&
                       score[0] + score[1] > wonhoScore[0] + wonhoScore[1]
            }
            .count + 1
    
    return canWonhoGetIncentive ? wonhoRank : -1
}
