import Foundation

func solution(_ sizes:[[Int]]) -> Int {
    var w = 0
    var h = 0
    
    sizes.forEach { size in
        if size[0] > size[1] {
            w = max(size[0], w)
            h = max(size[1], h)
        } else {
            w = max(size[1], w)
            h = max(size[0], h)
        }
    }
    
    return w * h
}
