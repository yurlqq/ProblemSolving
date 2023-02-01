import Foundation

func solution(_ x:Int, _ y:Int, _ n:Int) -> Int {
    var queue: [(number: Int, count: Int)] = [(number: y, count: 0)]
    var counter = 0

    while queue.count > counter {
        let number = queue[counter].number
        let count = queue[counter].count

        if number == x { return count }
        if number % 3 == 0 && number / 3 >= x {
            queue.append((number: number / 3, count: count + 1))
        }
        if number % 2 == 0 && number / 2 >= x {
            queue.append((number: number / 2, count: count + 1))
        }
        if number - n >= x {
            queue.append((number: number - n, count: count + 1))
        }

        counter += 1
    }

    return -1
}
