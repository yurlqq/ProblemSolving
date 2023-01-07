import Foundation

func solution(_ today:String, _ terms:[String], _ privacies:[String]) -> [Int] {
    var answer = [Int]()
    
    let today = getIntValueFromDateString(date: today)
    let expiration = terms.reduce(into: [String: Int]()) { dict, str in
        let info = str.components(separatedBy: " ")
        dict[info[0]] = Int(info[1])!
    }
    
    privacies.enumerated().forEach { (offset, privacy) in
        let temp = privacy.components(separatedBy: " ")
        let beginDate = getIntValueFromDateString(date: temp[0])
        let isExpired =  beginDate + expiration[temp[1]]! * 28 <= today
        if isExpired { answer.append(offset + 1) }
    }
    
    return answer
}


func getIntValueFromDateString(date: String) -> Int {
    let info = date.components(separatedBy: ".").map { Int($0)! }
    return info[0] * 12 * 28 + info[1] * 28 + info[2]
}
