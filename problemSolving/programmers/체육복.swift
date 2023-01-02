import Foundation

func solution(_ n:Int, _ lost:[Int], _ reserve:[Int]) -> Int {
    var countOfStudentWithUniform = n
    var canReserve = [Bool](repeating: false, count: n+2)
    var shouldLend = [Int]()
    
    reserve.forEach { number in
        canReserve[number] = true
    }
    
    lost.forEach { number in
        if canReserve[number] {
            canReserve[number] = false      // 여벌이 있지만 도난당했다면, 다른 친구에게 빌려줄 수 없다.
        } else {
            shouldLend.append(number)
            countOfStudentWithUniform -= 1  // 여벌이 없고, 도난당했다면, 빌려야 한다.
        }
    }
    
    shouldLend.sorted().forEach { number in
        if canReserve[number-1] {
            canReserve[number-1] = false    // 친구에게 빌려주었다면, 더 이상 빌려줄 수 없다.
            countOfStudentWithUniform += 1
        } else if canReserve[number+1] {
            canReserve[number+1] = false
            countOfStudentWithUniform += 1
        }
    }

    return countOfStudentWithUniform
}
