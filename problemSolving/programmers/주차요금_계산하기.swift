import Foundation

func solution(_ fees:[Int], _ records:[String]) -> [Int] {
    var informations: [String: [Int]] = records.reduce(into: [:]) { record, str in
        let information = str.components(separatedBy: " ")
        let time = information[0].convertedToInt()
        let carNumber = information[1]
        
        record[carNumber, default: []].append(time)
    }
    
    return informations.keys.sorted(by: <).map { carNumber in
        if informations[carNumber]!.count % 2 == 1 {
            informations[carNumber]!.append("23:59".convertedToInt())
        }
        
        let parkingTime = informations[carNumber]!.enumerated().reduce(0) { result, enumerated in
            let time = enumerated.element
            let index = enumerated.offset
            
            return index % 2 == 0 ? result - time : result + time // IN 이면 빼주고, OUT 이면 더해준다.
        }
        
        if parkingTime <= fees[0] {
            return fees[1]
        } else {
            let overtime = parkingTime - fees[0]
            
            if overtime % fees[2] == 0 {
                return fees[1] + (fees[3] * (overtime / fees[2]))
            } else {
                return fees[1] + (fees[3] * (overtime / fees[2] + 1))
            }
        }
    }
}

extension String {
    func convertedToInt() -> Int {
        let result = self.components(separatedBy: ":")
        let hours = Int(result[0])!
        let minutes = Int(result[1])!
        
        return hours * 60 + minutes
    }
}
