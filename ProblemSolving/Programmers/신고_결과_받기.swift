import Foundation

func solution(_ id_list:[String], _ report:[String], _ k:Int) -> [Int] {
    var reporting: [String: Set<String>] = [:]
    var reported: [String: Int] = [:]
    
    report.forEach { str in
        let info = str.components(separatedBy: " ")
        if reporting[info[0], default: Set<String>()].insert(info[1]).inserted {
            reported[info[1], default: 0] += 1
        }
    }
    
    return id_list.map { id in
        return reporting[id, default: Set<String>()]
            .filter { reported[$0, default: 0] >= k }
            .count
    }
}
