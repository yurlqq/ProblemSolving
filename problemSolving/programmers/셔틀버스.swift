import Foundation

func solution(_ n:Int, _ t:Int, _ m:Int, _ timetable:[String]) -> String {
    let tt = timetable.map { getInt(time: $0) }.sorted()
    var counter = 0
    
    for i in 0..<n-1 {
        let currentTime = 540 + i * t
        var passengersCount = 0
        
        while passengersCount < m && counter < tt.count {
            if currentTime >= tt[counter] {
                passengersCount += 1
                counter += 1
            } else {
                break
            }
        }
    }
    
    if counter + m - 1 >= tt.count {
        return getTime(540 + (n-1) * t)
    } else {
        return getTime(min(tt[counter + m - 1]-1, 540 + (n-1) * t))
    }
}

func getInt(time: String) -> Int {
    let splited = time.split { $0 == ":" }
    return Int(splited[0])! * 60 + Int(splited[1])!
}

func getTime(_ num: Int) -> String {
    let h = num / 60 < 10 ? "0\(num / 60)" : "\(num / 60)"
    let m = num % 60 < 10 ? "0\(num % 60)" : "\(num % 60)"
    return h + ":" + m
}
