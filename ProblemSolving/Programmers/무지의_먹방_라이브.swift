import Foundation

func solution(_ food_times:[Int], _ k:Int64) -> Int {
    var array = food_times.enumerated().sorted { $0.element > $1.element }
    var time = Int(k)
    var last = 0
    
    while !array.isEmpty {
        let current = array.last!.element
        
        if time >= (current - last) * array.count {
            time -= (current - last) * array.count
            last = current
        } else {
            time -= (time / array.count) * array.count
            last += (time / array.count)
            break
        }
        
        while current == array.last!.element {
            array.popLast()
            if array.isEmpty {
                return -1
            }
        }
    }
    
    return array.sorted { $0.offset < $1.offset }[time].offset + 1
}
