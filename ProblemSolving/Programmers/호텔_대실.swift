import Foundation

func solution(_ bookTimes:[[String]]) -> Int {
    var bookTimes = bookTimes.map { bookTime in
        let checkinTime = convertToInt(time: bookTime[0])
        let checkoutTime = convertToInt(time: bookTime[1])
        
        return [checkinTime, checkoutTime + 10]
    }.sorted { $0[0] > $1[0] }
    
    var rooms = [[bookTimes.removeLast()]]
    
    while !bookTimes.isEmpty {
        let current = bookTimes.removeLast()
        var isNotBooked = true
        
        for i in rooms.indices {
            if rooms[i].last![1] <= current[0] {
                rooms[i].append(current)
                isNotBooked = false
                break
            }
        }
        
        if isNotBooked {
            rooms.append([current])
        }
    }
    
    return rooms.count
}

func convertToInt(time: String) -> Int {
    let time = time.components(separatedBy: ":")
    return Int(time[0])! * 60 + Int(time[1])!
}
