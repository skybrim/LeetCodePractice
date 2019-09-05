import UIKit

var str = "Hello, playground"

//节点
class Node: Equatable {
    var key: Int, value: Int
    var pre: Node?, next: Node?
    
    init(key: Int, value: Int) {
        self.key = key
        self.value = value
    }
    
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.key == rhs.key
    }
}

//双向链表
class DoubleList {
    private var head: Node, tail: Node
    private var size: Int
    var getSize: Int {
        return size
    }
    
    init(size: Int) {
        self.size = size
        self.head = Node(key: 0, value: 0)
        self.tail = Node(key: 0, value: 0)
        self.head.next = self.tail
        self.tail.pre = self.head
    }
    
    //添加新节点到最前
    func addFirst(_ newHead: Node) {
        newHead.next = head.next
        newHead.pre = head
        head.next?.pre = newHead
        head.next = newHead
        size += 1
    }
    
    //移除节点
    func remove(_ node: Node) {
        node.pre?.next = node.next
        node.next?.pre = node.pre
        size -= 1
    }
    
    //移除最后一个节点
    func removeLast() -> Node? {
        if let last = tail.pre {
            if last == head {
                return nil
            }
            remove(last)
            return last
        }
        return nil
    }
}

class LRUCache {
    //hash，快速取值
    private var hashMap = [Int: Node]()
    private var cache = DoubleList(size: 0)
    private var capacity: Int
    
    init(_ capacity: Int) {
        self.capacity = capacity
    }
    
    //取值
    func get(_ key: Int) -> Int {
        if let node = hashMap[key] {
            //把最新使用的节点提到最前
            put(key, node.value)
            return node.value
        }
        return -1
    }
    
    //插值
    func put(_ key: Int, _ value: Int) {
        let newNode = Node(key: key, value: value)
        if let oldNode = hashMap[key] {
            //更新原有值
            cache.remove(oldNode)
            cache.addFirst(newNode)
            hashMap[key] = newNode
        } else {
            //插入新值
            if cache.getSize == capacity {
                //缓存满了，移除最后一个
                if let oldLastNode = cache.removeLast() {
                    hashMap[oldLastNode.key] = nil
                }
            }
            cache.addFirst(newNode)
            hashMap[key] = newNode
        }
    }
}


