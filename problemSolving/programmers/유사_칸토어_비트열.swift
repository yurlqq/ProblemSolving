import Foundation

func solution(_ n:Int, _ l:Int64, _ r:Int64) -> Int {
    if n == 1 { return (l...r).reduce(0) { $0 + (Int($1) == 3 ? 0 : 1) } }
    
    let base = pow(5, n-1).int64Value
    
    let currentL = base * ((l-1) / base) + 1
    let currentR = base * ((r-1) / base + 1)
    
    var mid: Int {
        return stride(from: currentL, to: currentR, by: Int64.Stride(base))
            .reduce(0) { initialValue, current in
                if current / base == 2 {
                    return initialValue
                } else {
                    return initialValue + pow(4, n-1).intValue
                }
            }
    }
    
    var left: Int {
        if currentL == l { return 0 }
        if currentL / base == 2 { return 0 }
        return solution(n-1, 1, (l-1) % base)
    }
    
    var right: Int {
        if currentR == r { return 0 }
        if currentR / base == 3 { return 0 }
        return solution(n-1, r % base + 1, base)
    }
    
    return mid - left - right
}

extension Decimal {
    var int64Value: Int64 {
        return NSDecimalNumber(decimal: self).int64Value
    }
    var intValue: Int {
        return NSDecimalNumber(decimal: self).intValue
    }
}
