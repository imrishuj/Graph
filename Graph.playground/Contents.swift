import UIKit

public struct Heap<T> {
    
  var nodes = [T]()
    
  private var orderCriteria: (T, T) -> Bool
    
  public init(sort: @escaping (T, T) -> Bool) {
    self.orderCriteria = sort
  }
    
  public init(array: [T], sort: @escaping (T, T) -> Bool) {
    self.orderCriteria = sort
    configureHeap(from: array)
  }
    
  private mutating func configureHeap(from array: [T]) {
    nodes = array
    for i in stride(from: (nodes.count/2-1), through: 0, by: -1) {
      shiftDown(i)
    }
  }
  
  public var isEmpty: Bool {
    return nodes.isEmpty
  }
  
  public var count: Int {
    return nodes.count
  }
    
   func parentIndex(ofIndex i: Int) -> Int {
    return (i - 1) / 2
  }
    
   func leftChildIndex(ofIndex i: Int) -> Int {
    return 2*i + 1
  }
    
   func rightChildIndex(ofIndex i: Int) -> Int {
    return 2*i + 2
  }
    
  public func peek() -> T? {
    return nodes.first
  }
    
  public mutating func insert(_ value: T) {
    nodes.append(value)
    shiftUp(nodes.count - 1)
  }
    
  public mutating func insert<S: Sequence>(_ sequence: S) where S.Iterator.Element == T {
    for value in sequence {
      insert(value)
    }
  }
    
   mutating func remove() -> T? {
    guard !nodes.isEmpty else { return nil }
    
    if nodes.count == 1 {
      return nodes.removeLast()
    } else {
      let value = nodes[0]
      nodes[0] = nodes.removeLast()
      shiftDown(0)
      return value
    }
  }
    
  internal mutating func shiftUp(_ index: Int) {
    var childIndex = index
    let child = nodes[childIndex]
    var parentIndex = self.parentIndex(ofIndex: childIndex)
    
    while childIndex > 0 && orderCriteria(child, nodes[parentIndex]) {
      nodes[childIndex] = nodes[parentIndex]
      childIndex = parentIndex
      parentIndex = self.parentIndex(ofIndex: childIndex)
    }
    
    nodes[childIndex] = child
  }
    
  internal mutating func shiftDown(from index: Int, until endIndex: Int) {
    let leftChildIndex = self.leftChildIndex(ofIndex: index)
    let rightChildIndex = leftChildIndex + 1
    var first = index
    if leftChildIndex < endIndex && orderCriteria(nodes[leftChildIndex], nodes[first]) {
      first = leftChildIndex
    }
    if rightChildIndex < endIndex && orderCriteria(nodes[rightChildIndex], nodes[first]) {
      first = rightChildIndex
    }
    if first == index { return }
    
    nodes.swapAt(index, first)
    shiftDown(from: first, until: endIndex)
  }
  
  internal mutating func shiftDown(_ index: Int) {
    shiftDown(from: index, until: nodes.count)
  }
  
}

public struct PriorityQueue<T> {
  fileprivate var heap: Heap<T>
    
  public init(sort: @escaping (T, T) -> Bool) {
    heap = Heap(sort: sort)
  }

  public var isEmpty: Bool {
    return heap.isEmpty
  }
    
  public mutating func enqueue(_ element: T) {
    heap.insert(element)
  }

  public mutating func dequeue() -> T? {
    return heap.remove()
  }
}

class LinkedListNode  {

    var from: Int
    var to: Int
    var weight: Int?
    var next: LinkedListNode?

    init(_ from: Int, _ to: Int, _ next: LinkedListNode? = nil, _ weight: Int? = nil) {
        self.from = from
        self.to = to
        self.next = next
        self.weight = weight
    }
}

class QueueUsingArray {
    
    var element: [Int] = []
    
    init() {}
    
    var isEmpty: Bool {
        return element.isEmpty ? true : false
    }
    
    var first: Int {
        guard !isEmpty else { return -1 }
        return element.first ?? -1
    }
    
    func enqueue(_ value: Int) {
        element.append(value)
    }
    
    func dequeue() -> Int? {
        guard !isEmpty else { return nil }
        return element.removeFirst()
    }
}

class DSU {
    
    var array = [Int]()
    var rank = [Int]()
    var size: Int
    
    init(_ size: Int) {
        self.size = size
        self.array = Array(repeating: 0, count: size)
        self.rank = Array(repeating: 0, count: size)
        var firstIndex = 0
        while (firstIndex < size) {
            self.array[firstIndex] = firstIndex
            firstIndex += 1
        }
    }
    
    func find(_ element: Int) -> Int {
        return (array[element] == element) ? element : find(array[element])
    }
    
    func union(_ first: Int, _ second: Int) {
        let x = find(first)
        let y = find(second)
        
        if x == y {
            return
        }
        
        array[y] = x
        
        if rank[x] < rank[y] {
            array[x] = y
        } else if rank[x] > rank[y] {
            array[y] = x
        } else {
            array[y] = x
            rank[x] += 1
        }
    }
}

class GraphMatrix {
    
    var node: [[Int]] = [[Int]]()
    var size: Int = 0
    
    init(_ size: Int) {
        guard size > 0 else { return }
        self.node = Array(repeating: Array(repeating: 0, count: size), count: size)
        self.size = size
    }
    
    func addEdge(_ row: Int, _ col: Int) {
        if (self.size > row && self.size > col) {
            self.node[row][col] = 1
            self.node[col][row] = 1
        }
    }
    
    
    func display() {
        if (self.size > 0) {
            var row = 0
            while(row < self.size) {
                print("Vertex of \(row):", terminator: "")
                var col = 0
                while(col < self.size) {
                    if (self.node[row][col] == 1) {
                        print(" \(col)", terminator: "")
                    }
                    col += 1
                }
                print("\n", terminator: "")
                row += 1
            }
        }
    }
}

/* Create Graph */

//let graphMatrix = GraphMatrix(5)
//graphMatrix.addEdge(0,1)
//graphMatrix.addEdge(0,3)
//graphMatrix.addEdge(0,4)
//graphMatrix.addEdge(1,0)
//graphMatrix.addEdge(1,3)
//graphMatrix.addEdge(2,4)
//graphMatrix.addEdge(3,0)
//graphMatrix.addEdge(3,1)
//graphMatrix.addEdge(3,4)
//graphMatrix.addEdge(4,0)
//graphMatrix.addEdge(4,2)
//graphMatrix.addEdge(4,3)
//graphMatrix.display()

class Vertices {
    
    var data: Int
    var next: LinkedListNode?
    var last: LinkedListNode?
    
    init(_ data: Int, _ next: LinkedListNode? = nil, _ last: LinkedListNode? = nil) {
        self.data = data
        self.next = next
        self.last = last
    }
}

class GraphList {
    
    var edges: [Vertices?]
    var size: Int
    
    init(_ size: Int) {
        self.edges = Array(repeating: nil, count: size)
        self.size = size
        self.setData()
    }
    
    func setData() {
        if (self.size > 0) {
            var index = 0
            while(index < self.size) {
                self.edges[index] = Vertices(index)
                index += 1
            }
        }
    }
        
    func addEdge(_ from: Int, _ to: Int, _ weight: Int? = nil) {
        if (from >= 0 && from < self.size && to >= 0 && to < self.size) {
            let edge: LinkedListNode? = LinkedListNode(from, to, nil, weight)
            if (self.edges[from]?.next == nil) {
                self.edges[from]?.next = edge
            } else {
                self.edges[from]?.last?.next = edge
            }
            self.edges[from]?.last = edge
        }
    }
    
    func display() {
        if (self.size > 0) {
            var index = 0
            while(index < self.size) {
                print("Vertex of \(index):", terminator: "")
                var temp: LinkedListNode? = self.edges[index]?.next
                while(temp != nil) {
                    print(" \(self.edges[temp!.to]!.data)", terminator: "")
                    temp = temp?.next;
                }
                print("\n", terminator: "")
                index += 1
            }
        }
    }
    
    func bfs(_ start: Int) {
        guard start < size else { return }
        let queue = QueueUsingArray()
        var temp: LinkedListNode?
        var visitedNodeArray: [Bool] = Array(repeating: false, count: self.size)
        queue.enqueue(start)
        print("BFS", terminator: "")
        while (!queue.isEmpty) {
            temp = self.edges[queue.first]?.next
            while (temp != nil) {
                if (!visitedNodeArray[temp!.to]) {
                    visitedNodeArray[temp!.to] = true
                    queue.enqueue(temp!.to)
                }
                temp = temp?.next
            }
            visitedNodeArray[queue.first] = true
            print(" \(queue.first)", terminator: "")
            let _ = queue.dequeue()
        }
    }
    
    func dfs(_ start: Int, _ visitedNodeArray: inout [Bool]) {
        guard start < size else { return }
        visitedNodeArray[start] = true
        print(" \(start)", terminator: "")
        var temp: LinkedListNode? = self.edges[start]?.next
        while (temp != nil) {
            if !visitedNodeArray[temp!.to] {
                self.dfs(temp!.to, &visitedNodeArray)
            }
            temp = temp?.next
        }
    }
    
    func doDFSSort(_ start: Int, _ visitedNodeArray: inout [Bool], _ sortedArray: inout [Int]?) {
        visitedNodeArray[start] = true
        var temp: LinkedListNode? = self.edges[start]?.next
        while (temp != nil) {
            if !visitedNodeArray[temp!.to] {
                self.doDFSSort(temp!.to, &visitedNodeArray, &sortedArray)
            }
            temp = temp?.next
        }
        if let data = edges[start]?.data {
            sortedArray?.append(data)
        }
    }
    
    func topologicalSortUsingDFS() {
        var sortedArray: [Int]? = [Int]()
        var visitedArray = Array(repeating: false, count: self.size)
        var firstIndex = 0
        while (firstIndex < self.size) {
            if !visitedArray[firstIndex] {
                self.doDFSSort(firstIndex, &visitedArray, &sortedArray)
            }
            firstIndex += 1
        }
        sortedArray?.reverse()
        print("\nTOPLOGICAL SORT USING DFS \(sortedArray  as Any)", terminator: "")
    }
    
    func indegree() -> [Int] {
        var degreeArray = Array(repeating: 0, count: self.size)
        var temp: LinkedListNode? = nil
        var firstIndex = 0
        while (firstIndex < self.size) {
            temp = self.edges[firstIndex]?.next
            while (temp != nil) {
                degreeArray[temp!.to] += 1
                temp = temp?.next
            }
            firstIndex += 1
        }
        return degreeArray
    }
    
    func topologicalSortKahnAlgo() {
        
        let queue = QueueUsingArray()
        var indegree = self.indegree()
        var sortedArray = [Int]()
        var firstIndex = 0
        
        while (firstIndex < self.size) {
            if indegree[firstIndex] == 0 {
                queue.enqueue(firstIndex)
            }
            firstIndex += 1
        }
        
        var temp: LinkedListNode?
        
        while(!queue.isEmpty) {
            if let element = queue.dequeue() {
                sortedArray.append(element)
                temp = self.edges[element]?.next
                while (temp != nil) {
                    indegree[temp!.to] -= 1
                    if indegree[temp!.to] == 0 {
                        queue.enqueue(temp!.to)
                    }
                    temp = temp?.next
                }
            }
        }
    }
    
    func primsAlgorithm() {
        var minWeightCycle = Int()
        var visitedArray = Array(repeating: false, count: self.size)
        var pQueue = PriorityQueue<(vertex: Int, weight: Int, parent: Int?)> (sort: { $0.weight < $1.weight })
        pQueue.enqueue((vertex: 0, weight: 0, parent: nil))
        while !pQueue.isEmpty {
            let minPair = pQueue.dequeue()
            let vertex = minPair?.vertex ?? 0
            if visitedArray[vertex] {
                continue
            }
            minWeightCycle += minPair?.weight ?? 0
            visitedArray[vertex] = true
            var temp: LinkedListNode? = self.edges[vertex]?.next
            while (temp != nil) {
                if (!visitedArray[temp!.to]) {
                    pQueue.enqueue((vertex: temp!.to, weight: temp!.weight ?? 0, parent: nil))
                }
                temp = temp?.next
            }
        }
        print("Min Weight to visit graph", minWeightCycle)
    }
    
    func dijkstraAlgorithm() {
        var array = Array(repeating: 10000, count: self.size)
        var visitedArray = Array(repeating: false, count: self.size)
        var pQueue = PriorityQueue<(vertex: Int, weight: Int, parent: Int?)> (sort: { $0.weight < $1.weight })
        pQueue.enqueue((vertex: 0, weight: 0, parent: nil))
        array[0] = 0
        while !pQueue.isEmpty {
            let minPair = pQueue.dequeue()
            let vertex = minPair?.vertex ?? 0
            if visitedArray[vertex] {
                continue
            }
            visitedArray[vertex] = true
            var temp: LinkedListNode? = self.edges[vertex]?.next
            while (temp != nil) {
                if array[temp!.to] > array[vertex] + temp!.weight! {
                    array[temp!.to] = array[vertex] + temp!.weight!
                    pQueue.enqueue((vertex: temp!.to, weight: array[temp!.to], parent: nil))
                }
                temp = temp?.next
            }
        }
        print("Min Weight to visit each node", array)
    }
    
    func isNegCycleBellmanFord() {
        var array = Array(repeating: 10000, count: self.size)
        array[0] = 0
        var verticesCount = 1
        
        while (verticesCount < self.size) {
            var edgeCount = 0
            while (edgeCount < self.edges.count) {
                let next = self.edges[edgeCount]?.next
                let source = self.edges[edgeCount]?.data ?? 0
                let weight = self.edges[edgeCount]?.next?.weight ?? 0
                if next != nil {
                    if (array[next!.to] > array[source] + weight && array[source] != 10000) {
                        array[next!.to] = array[source] + weight
                    }
                }
                edgeCount += 1
            }
            verticesCount += 1
        }
        
        print(array)
        
        var edgeCount = 0
        while (edgeCount < self.edges.count) {
            let next = self.edges[edgeCount]?.next
            let source = self.edges[edgeCount]?.data ?? 0
            let weight = self.edges[edgeCount]?.next?.weight ?? 0
            if next != nil {
                if (array[next!.to] > array[source] + weight) {
                    print("CYCLE FOUND")
                    return
                }
            }
            edgeCount += 1
        }
    }
    
    func getAllEdgeWithWeight() -> [LinkedListNode] {
        
        var allEdges = [LinkedListNode]()
        var firstIndex = 0
        while (firstIndex < self.edges.count) {
            var temp = self.edges[firstIndex]?.next
            while (temp != nil) {
                allEdges.append(temp!)
                temp = temp?.next
            }
            firstIndex += 1
        }
        allEdges.sort(by: { $0.weight! < $1.weight! })
        return allEdges
    }
    
    func kruskalAlgorithm() {
        var minWeightCycle = Int()
        let allEdges = getAllEdgeWithWeight()
        var firstIndex = 0
        var count = 0
        let dsu = DSU(self.size)
        while (count < self.size - 1) {
            let edge = allEdges[firstIndex]
            let from = dsu.find(edge.from)
            let to = dsu.find(edge.to)
            if from != to {
                count += 1
                dsu.union(from, to)
                minWeightCycle += edge.weight ?? 0
            }
            firstIndex += 1
        }
        print("Min Weight Cycle", minWeightCycle)
    }
}

/* Create Graph */

//let graphList = GraphList(5)
//graphList.addEdge(0,1)
//graphList.addEdge(0,3)
//graphList.addEdge(0,4)
//graphList.addEdge(1,0)
//graphList.addEdge(1,3)
//graphList.addEdge(2,4)
//graphList.addEdge(3,0)
//graphList.addEdge(3,1)
//graphList.addEdge(3,4)
//graphList.addEdge(4,0)
//graphList.addEdge(4,2)
//graphList.addEdge(4,3)
//graphList.display()

//let graphList1 = GraphList(6)
//graphList1.addEdge(0,2)
//graphList1.addEdge(0,3)
//graphList1.addEdge(1,4)
//graphList1.addEdge(2,3)
//graphList1.addEdge(2,1)
//graphList1.addEdge(3,1)
//graphList1.addEdge(5,4)
//graphList1.addEdge(5,1)
//graphList1.display()

//let graphList2 = GraphList(5)
//graphList2.addEdge(0,1,2)
//graphList2.addEdge(0,3,7)
//graphList2.addEdge(0,4,6)
//graphList2.addEdge(1,0,2)
//graphList2.addEdge(1,2,1)
//graphList2.addEdge(1,4,4)
//graphList2.addEdge(2,1,1)
//graphList2.addEdge(2,3,3)
//graphList2.addEdge(2,4,2)
//graphList2.addEdge(3,0,7)
//graphList2.addEdge(3,2,3)
//graphList2.addEdge(3,4,5)
//graphList2.addEdge(4,0,6)
//graphList2.addEdge(4,1,4)
//graphList2.addEdge(4,2,2)
//graphList2.addEdge(4,3,5)
//graphList2.display()

//let graphList3 = GraphList(4)
//graphList3.addEdge(0,1,3)
//graphList3.addEdge(0,2,1)
//graphList3.addEdge(1,2,-8)
//graphList3.addEdge(2,3,2)
//graphList3.addEdge(3,1,4)

//let graphList4 = GraphList(5)
//graphList4.addEdge(0,1,1)
//graphList4.addEdge(0,4,5)
//graphList4.addEdge(1,2,2)
//graphList4.addEdge(1,4,6)
//graphList4.addEdge(2,3,7)
//graphList4.addEdge(2,4,4)
//graphList4.addEdge(3,4,8)
//graphList4.display()

//graphList.bfs(0)
//var array = Array(repeating: false, count: graphList.size)
//print("\nDFS", terminator: "")
//graphList.dfs(0, &array)

//graphList1.topologicalSortKahnAlgo()
//graphList2.primsAlgorithm()
//graphList2.dijkstraAlgorithm()
//graphList3.isNegCycleBellmanFord()
//graphList4.kruskalAlgorithm()
