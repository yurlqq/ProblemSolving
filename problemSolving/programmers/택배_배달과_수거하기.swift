import Foundation

func solution(_ cap:Int, _ n:Int, _ deliveries:[Int], _ pickups:[Int]) -> Int64 {
    var answer = 0
//    var remainDeliveries = deliveries.reduce(0, +)
//    var remainPickups = pickups.reduce(0, +)
    
    var deliveries = deliveries
    deliveries.popZeroSuffixes()
    
    var pickups = pickups
    pickups.popZeroSuffixes()
    
    while !deliveries.isEmpty || !pickups.isEmpty {
        answer += max(deliveries.count, pickups.count) * 2
        var deliveryBox = cap
        var pickupBox = cap
        
        while deliveryBox > 0 {
            guard let current = deliveries.popLast()
            else { break }
            
            deliveryBox -= current
            
            if deliveryBox < 0 {
                deliveries.append(-deliveryBox)
            }
        }
        
        while pickupBox > 0 {
            guard let current = pickups.popLast()
            else { break }
            
            pickupBox -= current
            
            if pickupBox < 0 {
                pickups.append(-pickupBox)
            }
        }
        
        deliveries.popZeroSuffixes()
        pickups.popZeroSuffixes()
        
        print("d", deliveries)
        print("p", pickups)
        
    }
    
    return Int64(answer)
}

extension Array where Element == Int {
    mutating func popZeroSuffixes() {
        while (self.last ?? 1) == 0 {
            self.popLast()
        }
    }
}


//print(solution(4  ,  5   , [1, 0, 3, 1, 2]  ,  [0, 3, 0, 4, 0]))

"sadf".com
