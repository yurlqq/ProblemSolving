import Foundation

func solution(_ stones:[Int], _ k:Int) -> Int {
    if k == 1 { return stones.min()! }

    var answer = Int.max
    let enumerated = stones.enumerated().map { (value: $0.element, offset: $0.offset) }
    var queue = Queue([enumerated[0]])

    for i in 1..<stones.count {
        if i - k >= queue.first!.offset {
            queue.dequeue()
        }
        while !queue.isEmpty && queue.last!.value <= stones[i] {
            queue.popLast()
        }
        queue.enqueue(enumerated[i])
        if i >= k-1 { answer = min(answer, queue.first!.value) }
    }

    return answer
}

struct Queue<T> {
    private var array: [T]
    private var head = 0

    init(_ queue: [T]) {
        self.array = queue
    }

    var isEmpty: Bool {
        return head == array.count
    }

    var first: T? {
        return array.isEmpty ? nil : array[head]
    }

    var last: T? {
        return array.last
    }

    mutating func enqueue(_ value: T) {
        array.append(value)
    }

    mutating func dequeue() -> T? {
        if head >= array.count { return nil }
        else {
            head += 1
            return array[head-1]
        }
    }
    mutating func popLast() -> T? {
        return array.popLast()
    }
}


//sliding window와 Deque 자료구조를 이용합니다.
//stones 배열을 (index, value) 쌍으로 매핑한 뒤 순회합니다.
//
//1. Deque 에 뒤에서부터 집어 넣습니다.
//2. Deque의 마지막 원소가 집어넣을 원소보다 작다면, pop 해줍니다.
//3. Deque의 첫번째 원소가 현재 index - k 를 벗어났다면, pop 해줍니다.
//
//이렇게 하면 Deque[0]가 해당 구간의 max 값입니다.
//Deque 자료구조는 head 와 tail 의 삽입, 삭제가 모두 O(1) 이기에 max 값을 O(1) 시간에 구할 수 있습니다.
//answer 은 여기서 구해진 max 값 중 가장 작은 값이 됩니다.
//
//
//예시)
//stones: [7, 2, 8, 7, 5, 2, 9], k: 3 일 때,
//
//index: 0, [7, 2, 8, 7, 5, 2, 9]
//Deque: INF
//
//index 1, [7, 2, 8, 7, 5, 2, 9]
//Deque: [7, 2]
//answer: INF k보다 index가 작을 때는 answer를 update 하지 않음
//
//index 2, [7, 2, 8, 7, 5, 2, 9]
//Deque: [8] - 7, 2 는 8보다 작아 pop.
//answer: min(INF, 8) = 8
//
//index 3, [7, 2, 8, 7, 5, 2, 9]
//Deque: [8, 7]
//answer: min(8, 8) = 8
//
//index 4, [7, 2, 8, 7, 5, 2, 9]
//Deque: [8, 7, 5]
//answer: min(8, 8) = 8
//
//index 5, [7, 2, 8, 7, 5, 2, 9]
//Deque: [7, 5, 2] - 8은 인덱스 범위 벗어나 pop.
//answer: min(8, 7) = 7
//
//index 6, [7, 2, 8, 7, 5, 2, 9]
//Deque: [9]
//answer: min(7, 9) = 7
