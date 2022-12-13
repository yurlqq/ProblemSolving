import Foundation

func solution(_ user_id:[String], _ banned_id:[String]) -> Int {
    
    let dict = user_id.reduce(into: [String: [String]]()) { s, id in
        getPermutation(id).forEach { s[$0, default: []].append(id) }
    }
    
    var answer = Set<Set<String>>()
    
    func getAnswer(_ index: Int, _ current: Set<String>) {
        if index >= banned_id.count {
            answer.insert(current)
            return
        }
        for id in dict[banned_id[index]]! {
            if !current.contains(id) {
                getAnswer(index+1, current.union([id]))
            }
        }
    }
    
    getAnswer(0, Set<String>())
    
    return answer.count
}

func getPermutation(_ user_id: String) -> [String] {
    var result = [String]()
    
    for bit in 0..<Int(pow(2.0, Double(user_id.count))) {
        var ch = Array(user_id)
        for shiftCount in 0..<user_id.count {
            let current = bit >> shiftCount
            if current % 2 == 1 {
                ch[shiftCount] = "*"
            }
        }
        result.append(String(ch))
    }
    
    return result
}
