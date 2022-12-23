import Foundation

func solution(_ lines:[String]) -> Int {
    var answer = 0
    let times: [(start: Int, end: Int)] = lines
        .map { line in
            let info = line.components(separatedBy: " ")
            var endTime: Int {
                let temp = info[1]
                    .split { $0 == ":" || $0 == "." }
                    .map { Int(String($0))! }
                return temp[0] * 60 * 60 * 1000 + temp[1] * 60 * 1000 + temp[2] * 1000 + temp[3]
            }
            var responseTime: Int {
                var temp2 = info[2].components(separatedBy: ".")
                if temp2.count < 2 {
                    temp2[0].removeLast()
                    return Int(temp2[0])! * 1000
                }
                
                temp2[1].removeLast()
                temp2[1] += String(repeating: "0", count: 3 - temp2[1].count)
                
                return Int(temp2[0])! * 1000 + Int(temp2[1])!
            }
            
            let startTime = endTime - responseTime + 1
            
            
            return (start: startTime, end: endTime)
        }
    
    for i in 0..<times.count {
        var count = 0
        for j in i..<times.count {
            if times[i].end + 1000 > times[j].start {
                count += 1
            }
        }
        answer = max(answer, count)
    }
    
    return answer
}

print(
    solution([
        "2016-09-15 00:00:00.000 3s"
        ]),
    solution([
        "2016-09-15 23:59:59.999 0.001s"
        ]),
    solution([
        "2016-09-15 01:00:04.001 2.0s",
        "2016-09-15 01:00:07.000 2s"
        ]),
    solution([
        "2016-09-15 01:00:04.002 2.0s",
        "2016-09-15 01:00:07.000 2s"
        ]),
    solution([
        "2016-09-15 20:59:57.421 0.351s",
        "2016-09-15 20:59:58.233 1.181s",
        "2016-09-15 20:59:58.299 0.8s",
        "2016-09-15 20:59:58.688 1.041s",
        "2016-09-15 20:59:59.591 1.412s",
        "2016-09-15 21:00:00.464 1.466s",
        "2016-09-15 21:00:00.741 1.581s",
        "2016-09-15 21:00:00.748 2.31s",
        "2016-09-15 21:00:00.966 0.381s",
        "2016-09-15 21:00:02.066 2.62s"
        ])
)
