//
//  ViewController.swift
//  LeetCodePractice
//
//  Created by Wiley on 2019/6/24.
//  Copyright © 2019 Wiley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        var nums = [1, 0]
//        moveZeroes(&nums)
        
//        print("abc")
        print(rob([1,2,3,1]))

    }
    
    func countPrimes(_ n: Int) -> Int {
        guard n > 2 else {
            return 0
        }
        var res = 0
        var store = Array(repeating: 1, count: n)
        for i in 2 ..< n {
            if store[i] == 1 {
                res += 1
                var j = i + i
                while j < n {
                    store[j] = 0
                    j += i
                }
            }
        }
        return res
    }
    
    func fizzBuzz(_ n: Int) -> [String] {
        var res = [String]()
        for num in 1 ... n {
            var str = ""
            if num % 3 == 0 {
                str.append("Fizz")
            }
            if num % 5 == 0 {
                str.append("Buzz")
            }
            if str.count == 0 {
                str = String(num)
            }
            res.append(str)
        }
        return res
    }
    
    func rob2(_ nums: [Int]) -> Int {
        guard nums.count > 1 else {
            return nums.first ?? 0
        }
        
        var res = 0
        var last = 0
        
        for i in nums {
            let tmp = res
            res = max(last + i, res)
            last = tmp
        }
        return res
    }
    
    func rob(_ nums: [Int]) -> Int {
        guard nums.count > 1 else {
            return nums.first ?? 0
        }
        var memory = Array(repeating: -1, count: nums.count)
        memory[0] = nums[0]
        memory[1] = max(nums[0], nums[1])
        var res = max(memory[0], memory[1])
        for i in 2 ..< nums.count {
            memory[i] = max(memory[i - 2] + nums[i], memory[i - 1])
            res = max(res, memory[i])
        }
        return res
    }
    
    func isPalindrome(_ s: String) -> Bool {
        guard s.count > 1 else {
            return true
        }
        var s1 = s
        s1 = s1.filter({ !$0.isWhitespace })
        s1 = s1.filter({ $0.isLetter || $0.isNumber })
        s1 = s1.lowercased()
        let stringArray = s1.map{ String($0) }
        var left = 0, right = s1.count - 1
        while left < right {
            if stringArray[left] != stringArray[right] {
                return false
            }
            left += 1
            right -= 1
        }
        return true
    }
    
    
    func isAnagram(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else {
            return false
        }
        let sStore = Dictionary(s.map{ ($0, 1) }, uniquingKeysWith: +)
        let tStore = Dictionary(t.map{ ($0, 1) }, uniquingKeysWith: +)
        guard sStore.count == tStore.count else {
            return false
        }
        for (key, value) in sStore {
            if let tValue = tStore[key] {
                if tValue != value {
                    return false
                }
            } else {
                return false
            }
        }
        return true
    }
    
    func firstUniqChar(_ s: String) -> Int {
        
        let store = Dictionary(s.map{ ($0, 1) }, uniquingKeysWith: +)
        for (i, char) in s.enumerated() {
            if store[char] == 1 {
                return i
            }
        }
        return -1
    }
    
    func reverse(_ x: Int) -> Int {
        var result = 0, tmpX = abs(x)
        let resultMax = INT32_MAX / 10
        let xMax = INT32_MAX - INT32_MAX / 10
        while tmpX > 0 {
            if result > resultMax {
                return 0
            }
            if result == resultMax, tmpX > xMax {
                return 0
            }
            result = result * 10 + tmpX % 10
            tmpX = tmpX / 10
        }
        if x < 0 {
            result = -result
        }
        return result
    }
    
    func reverseString(_ s: inout [Character]) {
//         s = s.reversed()
        var left = 0, right = s.count - 1
        while left < right {
            s.swapAt(left, right)
            left += 1
            right -= 1
        }
    }
    
    func moveZeroes(_ nums: inout [Int]) {
        guard nums.count > 1 else {
            return
        }
        var zeroIndex = 0
        for i in 0 ..< nums.count {
            if nums[i] != 0 {
                nums[zeroIndex] = nums[i]
                zeroIndex += 1
            }
        }
        for j in zeroIndex ..< nums.count {
            nums[j] = 0
        }
        print(nums)
    }
    
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var nums1Dic = Dictionary(nums1.map{ ($0, 1) }, uniquingKeysWith: +)
        var res = [Int]()
        for num in nums2 {
            if let count = nums1Dic[num], count > 0 {
                res.append(num)
                nums1Dic[num] = count - 1
            }
        }
        return res
    }
    
    func singleNumber(_ nums: [Int]) -> Int {
        //按位异或
        //自身和自身 按位异或，等于 0
        //0 和 任何数 按位异或，等于 任何数
        var result = nums[0]
        for index in 1 ..< nums.count {
            result = result ^ nums[index]
        }
        return result
    }
    
    func containsDuplicate(_ nums: [Int]) -> Bool {
        var store = [Int: Int]()
        for num in nums {
            if let _ = store[num] {
                return true
            }
            store[num] = num
        }
        return false
    }
    
    func rotate(_ nums: inout [Int], _ k: Int) {
        guard k > 0, nums.count > 0 else {
            return
        }
        let j = k % nums.count
        func helpReversed(_ startIndex: Int, _ endIndex: Int) {
            var startIndex = startIndex, endIndex = endIndex
            while startIndex < endIndex {
                nums.swapAt(startIndex, endIndex)
                startIndex += 1
                endIndex -= 1
            }
        }
        nums = nums.reversed()
        helpReversed(0, j - 1)
        helpReversed(j, nums.count - 1)
    }
    
    //买卖股票的最佳时期  贪心算法
    func maxProfit(_ prices: [Int]) -> Int {
        guard prices.count > 1 else {
            return 0
        }
        var result = 0
        for (i, num) in prices[1 ..< prices.count].enumerated() {
            if num - prices[i] > 0 {
                result += num - prices[i]
            }
        }
        return result
    }
    
    //子集 位运算
    func subsets(_ nums: [Int]) -> [[Int]] {
        
        // [1, 2, 3] 的子集
        // 用 0 和 1 表示元素该子集是否存在
        // 【000】【001】【010】【100】【011】【101】【110】【111】
        // 转换成十进制
        //   0      1     2     3     4      5     6     7
        
        var res = [[Int]]()
        
        for i in 0 ..< (1 << nums.count) {
            var sub = [Int]()
            for (j, num) in nums.enumerated() {
                // 1 按索引向左偏移，得到 【001】 【010】 【100】
                // i 是当前子集是否存在的表示
                // 按位与
                //如果结果是 0 ，说明该位置上不存在数
                //如果不为 0，说明该位置上存在数
                if (1 << j) & i != 0 {
                    sub.append(num)
                }
            }
            res.append(sub)
        }
        return res
    }
    
    func subsets_backtracking(_ nums: [Int]) -> [[Int]] {
        var res = [[Int]]()
        func help(_ lasts: [Int], _ subRes: [Int]) {
            guard lasts.count > 0 else {
                res.append(subRes)
                return
            }
            var tmpLasts = lasts
            var tmpSubRes = subRes
            let num = tmpLasts.remove(at: 0)
            tmpSubRes.append(num)
            help(tmpLasts, subRes)
            help(tmpLasts, tmpSubRes)
        }
        help(nums, [])
        return res
    }
    
    
    @discardableResult
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        guard let root = root else {
            return nil
        }
        invertTree(root.left)
        invertTree(root.right)
        swap(&root.left, &root.right)
        return root
    }
    
    func maxDepth(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }
        return max(maxDepth(root.right), maxDepth(root.left)) + 1
    }
    
    func isValidBST(_ root: TreeNode?) -> Bool {
        
        func help(_ node: TreeNode?, _ min: Int?, _ max: Int?) -> Bool {
            guard let node = node else {
                return true
            }
            if let min = min, node.val <= min {
                return false
            }
            if let max = max, node.val >= max {
                return false
            }
            return help(node.left, min, node.val) && help(node.right, node.val, max)
        }
        return help(root, nil, nil)
    }
    
    
    func isSymmetric(_ root: TreeNode?) -> Bool {
        func help(_ r1: TreeNode?, _ r2: TreeNode?) -> Bool {
            if r1 == nil && r2 == nil {
                return true
            }
            guard let r1 = r1, let r2 = r2, r1.val == r2.val else {
                return false
            }
            return help(r1.left, r2.right) && help(r1.right, r2.left)
        }
        return help(root, root)
    }
    
    func isSymmetric2(_ root: TreeNode?) -> Bool {
        var queue = [TreeNode?]()
        queue.append(root)
        queue.append(root)
        while queue.count > 0 {
            let r1 = queue.removeLast()
            let r2 = queue.removeLast()
            if r1 == nil && r2 == nil { continue }
            if r1 == nil || r2 == nil { return false }
            if r1?.val != r2?.val { return false }
            queue.append(r1?.left)
            queue.append(r2?.right)
            queue.append(r1?.right)
            queue.append(r2?.left)
        }
        return true
    }//
    
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        var res = [[Int]]()
        var queue = [TreeNode]()
        guard let root = root else {
            return res
        }
        queue.append(root)
        while queue.count > 0 {
            var tmp = [Int]()
            let size = queue.count
            for _ in 0 ..< size {
                let node = queue.removeFirst()
                tmp.append(node.val)
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
            }
            res.append(tmp)
        }
        return res
    }
    
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        guard nums.count > 0 else {
            return nil
        }
        guard nums.count > 1 else {
            return TreeNode(nums[0])
        }
        let start = 0, end = nums.count - 1
        var mid = (start + end) / 2
        if (start + end) ^ 1 == 0 {
            mid = (start + end + 1) / 2
        }
        let root = TreeNode(nums[mid])
        let leftNums = Array(nums[start ..< mid])
        var rightNums = [Int]()
        if mid < end {
            rightNums = Array(nums[mid + 1 ... end])
        }
        root.left = sortedArrayToBST(leftNums)
        root.right = sortedArrayToBST(rightNums)
        return root
    }
    
    //Definition for a binary tree node.
    public class TreeNode {
        public var val: Int
        public var left: TreeNode?
        public var right: TreeNode?
        public init(_ val: Int) {
            self.val = val
            self.left = nil
            self.right = nil
        }
    }
    
    
    
    //杨辉三角
    func generate(_ numRows: Int) -> [[Int]] {
        if numRows == 0 { return [] }
        if numRows == 1 {return [[1]]}
        var res = [[1], [1, 1]]
        if numRows == 2 { return res }
        for row in 2 ... numRows - 1 {
            var rowNums = Array(repeating: 1, count: row + 1)
            let lastRowNums = res[row - 1]
            for i in 1 ..< rowNums.count - 1 {
                rowNums[i] = lastRowNums[i - 1] + lastRowNums[i]
            }
            res.append(rowNums)
        }
        return res
    }
    

    //零钱兑换 动态规划
    //暴力解法
    func coinChange_a(_ coins: [Int], _ amount: Int) -> Int {
        if amount == 0 { return 0 }
        var res = Int.max
        for coin in coins {
            if amount - coin < 0 { continue }
            let tmp = coinChange_a(coins, amount - coin)
            if tmp == -1 { continue }
            res = min(res, tmp + 1)
        }
        return res == Int.max ? -1 : Int(res)
    }
    //备忘录+暴力
    func coinChange_b(_ coins: [Int], _ amount: Int) -> Int {
        func help(_ coins: [Int], _ amount: Int, _ memory: inout [Int]) -> Int {
            if amount == 0 { return 0 }
            if memory[amount] != -2 { return memory[amount] }
            var res = Int.max
            for coin in coins {
                if amount - coin < 0 { continue }
                let tmp = help(coins, amount - coin, &memory)
                if tmp == -1 { continue }
                res = min(res, tmp + 1)
            }
            memory[amount] = res == Int.max ? -1 : Int(res)
            return memory[amount]
        }
        var memory = Array(repeating: -2, count: amount + 1)
        return help(coins, amount, &memory)
    }
    //动态规划
    func coinChange(_ coins: [Int], _ amount: Int) -> Int {
        if amount == 0 { return 0 }
        var memory = Array(repeating: amount + 1, count: amount + 1)
        memory[0] = 0
        for i in 1 ... amount {
            for coin in coins {
                if i - coin >= 0 {
                    memory[i] = min(memory[i], memory[i - coin] + 1)
                }
            }
        }
        return memory[amount] > amount ? -1 : memory[amount]
    }
    
    //最长上升子序列  动态规划结题
    func lengthOfLIS(_ nums: [Int]) -> Int {
        if nums.count == 0 { return 0 }
        var subs = Array(repeating: 1, count: nums.count)
        var result = 1
        for i in 1 ..< nums.count {
            for j in 0 ..< i {
                if nums[j] < nums[i] {
                    subs[i] = max(subs[i], subs[j] + 1)
                }
            }
            result = max(result, subs[i])
        }
        return result
    }
    
    //爬楼梯 暴力
    func climbStairs_a(_ n: Int) -> Int {
        guard n > 2 else {
            return n
        }
        let steps = [1, 2]
        var res = 0
        for curStep in steps {
            if n - curStep < 0 { continue }
            res += climbStairs(n - curStep)
        }
        return res
    }
    //爬楼梯 暴力递归
    func climbStairs_b(_ n: Int) -> Int {
        guard n > 2 else {
            return n
        }
        return climbStairs_b(n - 1) + climbStairs_b(n - 2)
    }
    //爬楼梯 记忆化递归
    func climbStairs_c(_ n: Int) -> Int {
        guard n > 2 else {
            return n
        }
        var store = Array(repeating: 0, count: n + 1)
        store[1] = 1
        store[2] = 2
        func help(_ step: Int) -> Int {
            if store[step] != 0 { return store[step] }
            store[step] = help(step - 1) + help(step - 2)
            return store[step]
        }
        return help(n)
    }
    //爬楼梯 动态规划
    func climbStairs(_ n: Int) -> Int {
        guard n > 2 else {
            return n
        }
        var res = Array(repeating: 0, count: n + 1)
        res[1] = 1
        res[2] = 2
        for i in 3 ... n {
            res[i] = res[i - 1] + res[i - 2]
        }
        return res[n]
    }
    
    func climbStairs_s(_ n: Int) -> Int {
        guard n > 2 else {
            return n
        }
        var res = 0
        var pre_1 = 1
        var pre_2 = 2
        for _ in 3 ... n {
            res = pre_1 + pre_2
            pre_1 = pre_2
            pre_2 = res
        }
        return res
    }
    
    func largestNumber(_ nums: [Int]) -> String {
        guard nums.count > 0 else {
            return "0"
        }
        var res = nums.map{ String($0) }
        res.sort(by: { Int($0 + $1)! > Int($1 + $0)!})
        if let firstNum = res.first {
            if firstNum == "0" {
                return "0"
            }
        }
        return res.joined()
    }
    
//    func maxProfit(_ prices: [Int]) -> Int {
//        guard prices.count > 1 else {
//            return 0
//        }
//        var buyIndex = 0, sellIndex = 1, maxRes = 0
//        for _ in 1 ... prices.count - 1 {
//            if prices[sellIndex] - prices[buyIndex] < 0 {
//                buyIndex = sellIndex
//            } else {
//                maxRes = max(maxRes, prices[sellIndex] - prices[buyIndex])
//            }
//            sellIndex += 1
//        }
//
//        return maxRes
//    }
    
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        var i = 0
        var tmpm = m
        for tmp in nums2 {
            while nums1[i] < tmp {
                if i == tmpm {
                    break
                }
                i += 1
            }
            nums1.insert(tmp, at: i)
            nums1.removeLast()
            tmpm += 1
        }
//        print(nums1)
    }
    
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        let sortedNum = nums.sorted()
        return sortedNum[nums.count - k]
    }
    
    public class ListNode {
        public var val: Int
        public var next: ListNode?
        public init(_ val: Int) {
            self.val = val
            self.next = nil
        }
    }
        
    func isPalindrome(_ head: ListNode?) -> Bool {
        var head = head
        var result = [String]()
        while let node = head {
            result += [String(node.val)]
            head = node.next
        }
        if result == result.reversed() {
            return true
        }
        return false
    }
    
    func deleteNode(node: ListNode) {
        if let tmp = node.next {
            node.val = tmp.val
            node.next = tmp.next
        }
    }
    
    func reverseList(_ head: ListNode?) -> ListNode? {
        guard let head = head else {
            return nil
        }
        let next = head.next
        head.next = nil
        func help(_ pre: ListNode, _ next: ListNode?) -> ListNode? {
            guard let next = next else {
                return pre
            }
            let tmpNext = next.next
            next.next = pre
            return help(next, tmpNext)
        }
        return help(head, next)
    }
    
    func swapPairs(_ head: ListNode?) -> ListNode? {
        guard let head = head else {
            return nil
        }
        if let next = head.next {
            head.next = swapPairs(next.next)
            next.next = head
            return next
        }
        return head
    }
    
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        let tmpNode = ListNode(0)
        tmpNode.next = head
        var firstNode: ListNode?, secondeNode: ListNode?
        firstNode = tmpNode
        secondeNode = tmpNode
        for _ in 1 ... n {
            firstNode = firstNode?.next
        }
        while firstNode?.next != nil {
            secondeNode = secondeNode?.next
            firstNode = firstNode?.next
        }
        secondeNode?.next = secondeNode?.next?.next
        return tmpNode.next
    }
    
    func addTwoNumberNewNode(_ l1: ListNode?, _ l2: ListNode?, _ pre: ListNode?) -> ListNode? {
        var next1: ListNode?
        var next2: ListNode?
        var val1 = 0
        var val2 = 0
        if let l1 = l1 {
            next1 = l1.next
            val1 = l1.val
        }
        if let l2 = l2 {
            next2 = l2.next
            val2 = l2.val
        }
        let l3 = ListNode(val1 + val2)
        if let pre = pre {
            if pre.val >= 10 {
                l3.val += 1
            }
        }
        if next1 == nil && next2 == nil {
            if l3.val >= 10 {
                l3.next = ListNode(1)
            } else {
                l3.next = nil
            }
        } else {
            l3.next = addTwoNumberNewNode(next1, next2, l3)
        }
        if l3.val >= 10 {
            l3.val -= 10
        }
        return l3
    }
    
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        return addTwoNumberNewNode(l1, l2, nil)
    }
    
    
    func plusOne(_ digits: [Int]) -> [Int] {
        var results = digits
        if Set(digits).count == 1, digits.contains(9) {
            results = [1] + Array(repeating: 0, count: digits.count)
            return results
        }
        for i in digits.indices.reversed() {
            if digits[i] != 9 {
                results[i] = results[i] + 1
                if i < digits.count - 1 {
                    for j in i + 1 ... digits.count - 1 {
                        results[j] = 0
                    }
                }
                break
            }
        }
        return results
    }
    
    
    func minPathSum(_ grid: [[Int]]) -> Int {
        var m = grid.count
        if m == 0 {
            return 0
        }
        var n = grid.first!.count
        var storeDic = [[Int] : Int]()
        func help(h: Int, v: Int) -> Int {
            let lastNum = grid[h-1][v-1]
            var minSum = 0
            if h == 1, v == 1 {
                minSum = 0
            } else if storeDic.keys.contains([h, v]) {
                minSum = storeDic[[h, v]]!
            } else {
                if h == 1, v > 1 {
                    minSum = help(h: h, v: v - 1)
                } else if h > 1, v == 1 {
                    minSum = help(h: h - 1, v: v)
                } else if h > 1, v > 1 {
                    minSum = min(help(h: h, v: v - 1), help(h: h - 1, v: v))
                }
                storeDic[[h, v]] = minSum
            }
            let sum = lastNum + minSum
            return sum
        }
        return help(h: m, v: n)
    }
    
    func uniquePathsWithObstacles(_ obstacleGrid: [[Int]]) -> Int {
        var m = obstacleGrid.count
        if m == 0 {
            return 0
        }
        var n = obstacleGrid.first!.count
        var storeDic = [[Int] : Int]()
        func help(h: Int, v: Int) -> Int {
            if obstacleGrid[h-1][v-1] == 1 {
                return 0
            }
            if h == 1, v == 1 {
                return 1
            }
            if storeDic.keys.contains([h, v]) {
                return storeDic[[h, v]]!
            } else {
                var tmp = 1;
                if h == 1, v > 1 {
                    tmp = help(h: h, v: v - 1)
                } else if h > 1, v == 1 {
                    tmp = help(h: h - 1, v: v)
                } else {
                    tmp = help(h: h - 1, v: v) + help(h: h, v: v - 1)
                }
                storeDic[[h, v]] = tmp
                return tmp
            }
        }
        return help(h: m, v: n)
    }
    
//    func uniquePaths(_ m: Int, _ n: Int) -> Int {
//        // (m+n-2)! / ((m-1)! * (m+n-2 - (m-1))!)
//        //
//        let a = m + n - 2
//        let b = m - 1
//        let c = a - b
//        func getFactorIal(num: Int) -> Int {
//            var sum = 1
//            for i in 1...num {
//                sum *= i
//            }
//            return sum
//        }
//
//        return getFactorIal(num: a) / (getFactorIal(num: b) * getFactorIal(num: c))
//    }
    
    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        var storeDic = [[Int] : Int]()
        func help(h: Int, v: Int) -> Int {
            if h == 1 || v == 1 {
                return 1
            }
            if storeDic.keys.contains([h, v]) {
                return storeDic[[h, v]]!
            } else {
                storeDic[[h ,v]] = help(h: h - 1, v: v) + help(h: h, v: v - 1)
            }
            return help(h: h - 1, v: v) + help(h: h, v: v - 1)
        }
        return help(h: m, v: n)
    }
    
    func getPermutation(_ n: Int, _ k: Int) -> String {
        var result = [Int]()
        var nums = [Int]()
        for i in 1 ... n {
            nums += [i]
        }
        var tmpK = k
        while nums.count > 0 {
            var tmpMaxResultCount = 1
            if nums.count > 2 {
                for i in 1 ... (nums.count - 1) {
                    tmpMaxResultCount *= i
                }
            }
            let index = Int(ceil(Double(tmpK) / Double(tmpMaxResultCount))) - 1
            tmpK = tmpK - tmpMaxResultCount * index
            result.append(nums[index])
            nums.remove(at: index)
        }
        var resultString = ""
        for i in result {
            resultString += String(i)
        }
        return resultString
    }
    
    func generateMatrix(_ n: Int) -> [[Int]] {
        var result = [[Int]]()
        var x = 1
        let maxX = n * n
        var s1 = 0, r1 = 0, s2 = n - 1, r2 = n - 1
        while x <= maxX {
            for i in r1 ... r2 {
                if result.indices.contains(s1) == false {
                    result.insert([Int](), at: s1)
                }
                result[s1].insert(x, at: i)
                x += 1
            }
            if s1 + 1 <= s2 {
                for j in (s1 + 1) ... s2 {
                    if result.indices.contains(j) == false {
                        result.insert([Int](), at: j)
                    }
                    result[j].insert(x, at: r1)
                    x += 1
                }
            }
            if r1 <= r2 - 1, s1 < s2 {
                for _ in (r1 ... (r2 - 1)).reversed() {
                    result[s2].insert(x, at: s1)
                    x += 1
                }
            }
            if s1 + 1 <= s2 - 1, r1 < r2 {
                for l in ((s1 + 1) ... (s2 - 1)).reversed() {
                    result[l].insert(x, at: r1)
                    x += 1
                }
            }
            s1 += 1
            r2 -= 1
            s2 -= 1
            r1 += 1
        }
        return result
    }
    
    func lengthOfLastWord(_ s: String) -> Int {
        var result = 0
        let str = s.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        for char in str.reversed() {
            if char == " " {
                return result
            }
            result += 1
        }
        return result
    }
    
    func merge(_ intervals: [[Int]]) -> [[Int]] {
        let sortedIntervals = intervals.sorted(by: { (nums1: [Int], nums2: [Int]) -> Bool in
            return nums1.first! < nums2.first!
        })
        var results = [[Int]]()
        for nums in sortedIntervals {
            if let lastNums = results.last {
                if lastNums.last! >= nums.first! {
                    if lastNums.last! <= nums.last! {
                        var tmpLastNums = results.last!
                        tmpLastNums[1] = nums.last!
                        results.removeLast()
                        results.append(tmpLastNums)
                    } else {
                        continue
                    }
                } else {
                    results.append(nums)
                }
            } else {
                results.append(nums)
            }
        }
        return results
    }
    
    func canJump(_ nums: [Int]) -> Bool {
        var last = nums.count - 1
        for (i, num) in nums.reversed().enumerated() {
            if num + (nums.count - 1 - i) >= last {
                last = nums.count - 1 - i
            } else {
                continue
            }
        }
        return last == 0 ? true : false
    }
    
//    func canJump(_ nums: [Int]) -> Bool {
//        var store = Array(repeating: 0, count: nums.count)
//        let length = nums.count - 1
//        for (i, num) in nums.reversed().enumerated() {
//            if num - i >= 0 {
//                store[length - i] = 1
//            } else {
//                store[length - i] = -1
//                for j in 0 ... num {
//                    if store[length - i + j] == 1 {
//                        store[length - i] = 1
//                        break
//                    }
//                }
//            }
//        }
//        return store[0] == 1 ? true : false
//    }
    
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        var result = [Int]()
        if matrix.count == 0 {
            return result
        }
        var s1 = 0, r1 = 0, s2 = matrix.count - 1, r2 = matrix.first!.count - 1
        while s1 <= s2, r1 <= r2 {
            for i in r1 ... r2 {
                result.append(matrix[s1][i])
            }
            if s1 + 1 <= s2 {
                for j in (s1 + 1) ... s2 {
                    result.append(matrix[j][r2])
                }
            }
            if r1 <= r2 - 1, s1 < s2 {
                for k in (r1 ... (r2 - 1)).reversed() {
                    result.append(matrix[s2][k])
                }
            }
            if s1 + 1 <= s2 - 1, r1 < r2 {
                for l in ((s1 + 1) ... (s2 - 1)).reversed() {
                    result.append(matrix[l][r1])
                }
            }
            s1 += 1
            r2 -= 1
            s2 -= 1
            r1 += 1
        }
        return result
    }
    
    
    func maxSubArray(_ nums: [Int]) -> Int {
        var result = nums.first!
        var sum = 0
        for num in nums {
            if sum > 0 {
                sum += num
            } else {
                sum = num
            }
            result = max(sum, result)
        }
        return result
    }
    
    func myPow(_ x: Double, _ n: Int) -> Double {
        if x == 1.0 { return x }
        if n == 0 { return 1 }
        var result = 1.0, X = x, N = n
        if n < 0 {
            N = -n
            X = 1 / x
        }
        func helper(_ x: Double, _ n: Int) -> Double {
            if n == 0 { return 1.0 }
            let half = helper(X, n / 2)
            if n & 1 == 0 {
                return half * half
            } else {
                return half * half * X
            }
        }
        
        return helper(X, N)
    }
    

    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var dic = [[Character]: [String]]()
        for string in strs {
            let key = string.sorted()
            var tmpArray = dic[key] ?? [String]()
            tmpArray.append(string)
            dic[key] = tmpArray
        }
        var res = [[String]]()
        for (_, value) in dic {
            res.append(value)
        }
        return res
    }
    
    func rotate(_ matrix: inout [[Int]]) {
        for i in 0 ..< matrix[0].count {
            for j in i ..< matrix[0].count {
                let tmp = matrix[i][j]
                matrix[i][j] = matrix[j][i]
                matrix[j][i] = tmp
            }
        }
        for (index, tmp) in matrix.enumerated() {
            matrix[index] = tmp.reversed()
        }
    }
    
    
    func permuteUnique(_ nums: [Int]) -> [[Int]] {
        guard nums.count > 1 else {
            return [nums]
        }
        var result = [[Int]]()
        func helper(orignNums: [Int], tmp: [Int]) {
            guard orignNums.count > 0 else {
                result.append(tmp)
                return
            }
            for i in 0 ..< orignNums.count {
                if i > 0, orignNums[i] == orignNums[i - 1] {
                    continue
                }
                var a = orignNums
                a.remove(at: i)
                helper(orignNums: a, tmp: tmp + [orignNums[i]])
            }
        }
        helper(orignNums: nums.sorted(), tmp: [])
        return result
    }
    
    func permute(_ nums: [Int]) -> [[Int]] {
        guard nums.count > 1 else {
            return [nums]
        }
        var result = [[Int]]()
        func helper(orignNums: [Int], tmp: [Int]) {
            guard orignNums.count > 0 else {
                result.append(tmp)
                return
            }
            for i in 0 ..< orignNums.count {
                if i > 0, orignNums[i] == orignNums[i - 1] {
                    continue
                }
                var a = orignNums
                a.remove(at: i)
                helper(orignNums: a, tmp: tmp + [orignNums[i]])
            }
        }
        helper(orignNums: nums.sorted(), tmp: [])
        return result
    }
    
    func multiply(_ num1: String, _ num2: String) -> String {
        if num1 == "0" || num2 == "0" { return "0" }
        var resDic = [Int : Int]()
        for i in 1 ... num2.count {
            for j in 1 ... num1.count {
                guard
                    let single1 = Int(String(num1[num1.index(num1.endIndex, offsetBy: -j)])),
                    let single2 = Int(String(num2[num2.index(num2.endIndex, offsetBy: -i)]))
                else {
                    break
                }
                let key = i + j
                var tmp = single1 * single2
                if let value = resDic[key] {
                    tmp += value
                }
                resDic[key] = tmp
            }
        }
        print(resDic)
        for key in resDic.keys.sorted() {
            if let value = resDic[key] {
                if let nextValue = resDic[key + 1] {
                    resDic[key + 1] = nextValue + value / 10
                } else  {
                    if value > 9 {
                        resDic[key + 1] = value / 10
                    }
                }
                resDic[key] = value % 10
            }
        }
        print(resDic)
        var result = ""
        for key in resDic.keys.sorted() {
            result = String(resDic[key]!) + result
        }
        return result
    }
    
    func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
        var results = [[Int]]()
        func helper(i: Int, tmp_sum: Int, res: [Int]) {
            if tmp_sum == target {
                results += [res.sorted()]
            }
            if i == candidates.count || tmp_sum > target {
                return
            }
            helper(i: i + 1, tmp_sum: tmp_sum + candidates[i], res: res + [candidates[i]])
            helper(i: i + 1, tmp_sum: tmp_sum, res: res)
        }
        helper(i: 0, tmp_sum: 0, res: [])
        return Array(Set(results))
    }
    
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        var results = [[Int]]()
        func helper(i: Int, tmp_sum: Int, res: [Int]) {
            if tmp_sum == target {
                results += [res.sorted()]
            }
            if i == candidates.count || tmp_sum > target {
                return
            }
            helper(i: i, tmp_sum: tmp_sum + candidates[i], res: res + [candidates[i]])
            helper(i: i + 1, tmp_sum: tmp_sum, res: res)
        }
        helper(i: 0, tmp_sum: 0, res: [])
        return Array(Set(results))
    }
    
    
    
    func countAndSay(_ n: Int) -> String {
        if n == 1 {
            return "1"
        } else {
            return recursiver(numString: countAndSay(n - 1))
        }
    }
    
    func recursiver(numString: String) -> String {
        var strings = numString.map{ String($0) }
        strings.append("0")
        var results = [String]()
        var j = 1
        for i in 0 ..< strings.count {
            if strings[i] == "0" { break }
            if strings[i] == strings[i + 1] {
                j += 1
            } else {
                let tmp = "\(j)" + "\(strings[i])"
                j = 1
                results.append(tmp)
            }
        }
        var result = ""
        for tmp in results {
            result += tmp
        }
        return result
    }

    
    
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        var leftIndex = 0
        var rightIndex = nums.count - 1
        while leftIndex <= rightIndex {
            if target < nums[leftIndex] { return leftIndex == 0 ? 0 : leftIndex}
            if target > nums[rightIndex] { return rightIndex + 1 }
            let midIndex = leftIndex + (rightIndex - leftIndex) / 2
            if nums[midIndex] == target { return midIndex }
            if target <= nums[midIndex] {
                rightIndex = midIndex
            } else {
                leftIndex = midIndex + 1
            }
        }
        return leftIndex
    }
    
    
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        if let first = nums.firstIndex(of: target),
            let last = nums.lastIndex(of: target) {
            return [first, last]
        }
        return [-1, -1]
    }
    
    func search(_ nums: [Int], _ target: Int) -> Int {
        var leftIndex = 0
        var rightIndex = nums.count - 1
        while leftIndex <= rightIndex {
            let midIndex = leftIndex + (rightIndex - leftIndex) / 2
            if nums[midIndex] == target { return midIndex }
            if nums[leftIndex] <= nums[midIndex] {
                if nums[leftIndex] <= target, target <= nums[midIndex] {
                    rightIndex = midIndex
                } else {
                    leftIndex = midIndex + 1
                }
            } else {
                if nums[midIndex] <= target, target <= nums[rightIndex] {
                    leftIndex = midIndex
                } else {
                    rightIndex = midIndex - 1
                }
            }
        }
        return -1
    }
    
    func divide(_ dividend: Int, _ divisor: Int) -> Int {
        if abs(dividend) < abs(divisor) { return 0 }
        if divisor == 1 { return dividend }
        var a: Int
        if (dividend > 0 && divisor > 0) || (dividend < 0 && divisor < 0) {
            a = 1
        } else {
            a = -1
        }
        var result = 0
        var time = 1
        var inoutDividend = abs(dividend)
        var inoutDivisor = abs(divisor)
        while inoutDividend >= abs(divisor) {
            if inoutDividend >= inoutDivisor {
                inoutDividend -= inoutDivisor
                inoutDivisor += inoutDivisor
                if Int(INT32_MAX) - time < result {
                    return Int(INT32_MAX)
                }
                result += time
                time += time
            } else {
                inoutDivisor = abs(divisor)
                time = 1
            }
            print("inoutDividend \(inoutDividend)   inoutDivisor \(inoutDivisor)  time \(time)")
        }
        return result * a
    }

    func strStr(_ haystack: String, _ needle: String) -> Int {
        if needle.isEmpty  { return 0 }
        let n1 = haystack.count
        let n2 = needle.count
        if n2 > n1 { return -1 }
        for i in 0 ..< n1 - n2 + 1 {
            if haystack[haystack.index(haystack.startIndex, offsetBy: i) ..< haystack.index(haystack.startIndex, offsetBy: i + n2)] == needle {
                return i
            }
        }
        return -1
    }
    
//    func strStr(_ haystack: String, _ needle: String) -> Int {
//        if needle.count > haystack.count { return -1 }
//        if needle.isEmpty  { return 0 }
//        if let index = haystack.range(of: needle)?.lowerBound {
//            let distance = haystack.distance(from: haystack.startIndex, to: index)
//            return distance
//        }
//        return -1
//    }
    
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var i = 0
        for num in nums {
            if num != val {
                nums[i] = num
                i += 1
            }
        }
        return i
    }
    
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        guard nums.count > 0 else {
            return 0
        }
        var i = 0
        for j in 1 ..< nums.count {
            if nums[i] != nums[j] {
                i += 1
                nums[i] = nums[j]
            }
        }
        return i + 1
    }
    
    
    func generateParenthesis(_ n: Int) -> [String] {
        var result = [String]()
        func helper(l: Int, r: Int, s: String) {
            var r_count = r
            var str = s
            if l == n {
                while r_count < n {
                    r_count += 1
                    str += ")"
                }
                result += [str]
                return
            }
            if l == r_count {
                helper(l: l + 1, r: r_count, s: str + "(")
            }
            if l > r_count {
                helper(l: l + 1, r: r_count, s: str + "(")
                helper(l: l, r: r_count + 1, s: str + ")")
            }
        }
        helper(l: 0, r: 0, s: "")
        return result
    }
    
    func isValid(_ s: String) -> Bool {
        if s.count == 0 { return true }
        if s.count % 2 != 0 { return false }
        var hash = ["{" : "}", "[" : "]", "(" : ")",]
        var stack = [String]()
        for char in s {
            if hash.keys.contains(String(char)) {
                stack.append(String(char))
            } else {
                guard let last = stack.last else {
                    return false
                }
                if String(char) != hash[last] {
                    return false
                } else {
                    stack.removeLast()
                }
            }
        }
        if stack.count == 0 {
            return true
        }
        return false
    }
    
    
    //给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var storeDic = [Int: Int]()
        for (i, num) in nums.enumerated() {
            if let anotherIndex = storeDic[num] {
                return [anotherIndex, i]
            }
            storeDic[target - num] = i
        }
        return []
    }
    
    //给定一个字符串，请你找出其中不含有重复字符的 最长子串 的长度。
    func lengthOfLongestSubstring(_ s: String) -> Int {
        if s.count == 0 { return 0 }
        var result = 1
        let strings = s.map{ String($0) }
        var start = 0
        var end = 1
        while end < strings.count {
            if strings[start ..< end].contains(strings[end]) {
                result = max(end - start, result)
                if result >= (strings.count + 1) / 2, end >= (strings.count + 1) / 2 {
                    break
                }
                //发生重复
                //找到重复数字的索引，+ 1，并赋值给 start
                start = strings[start ..< end].firstIndex(of: strings[end])! + 1
            }
            end += 1
        }
        result = max(end - start, result)
        return result
    }
    
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        var nums3: [Int] = []
        if nums1.count > 0, nums2.count > 0 {
            if nums1.last! < nums2.first! {
                nums3 = nums1 + nums2
            } else if nums1.first! > nums2.last! {
                nums3 = nums2 + nums1
            } else {
                var num1_L_Max = 0, num1_R_Min = 0, num2_L_Max = 0, num2_R_Min = 0
                if nums1.count%2 == 0 {
                    num1_L_Max = nums1[nums1.count/2-1]
                    num1_R_Min = nums1[nums1.count/2]
                } else {
                    num1_L_Max = nums1[nums1.count/2]
                    num1_R_Min = nums1[nums1.count/2]
                }
                if nums2.count%2 == 0 {
                    num2_L_Max = nums2[nums2.count/2-1]
                    num2_R_Min = nums2[nums2.count/2]
                } else {
                    num2_L_Max = nums2[nums2.count/2]
                    num2_R_Min = nums2[nums2.count/2]
                }
                if num1_L_Max < num2_R_Min, num2_L_Max < num1_R_Min {
                } else {
                    if num1_L_Max > num2_R_Min {
                        //1向左偏移，2向右偏移
                        while num1_L_Max < num2_R_Min {
                            num1_L_Max = nums1.index(before: nums1.firstIndex(of: num1_L_Max)!)
                            num2_R_Min = nums2.index(after: nums2.firstIndex(of: num2_R_Min)!)
                        }
                    } else if num2_L_Max > num1_R_Min {
                        //1向右偏移，2向左偏移
                        while num2_L_Max < num1_R_Min {
                            num1_R_Min = nums1.index(after: nums1.firstIndex(of: num1_R_Min)!)
                            num2_L_Max = nums2.index(before: nums2.firstIndex(of: num2_L_Max)!)
                        }
                    }
                }
                let L_Max = max(num1_L_Max, num2_L_Max)
                let R_Min = min(num1_R_Min, num2_R_Min)
                if L_Max == R_Min {
                    return Double(L_Max)
                } else {
                    return Double(R_Min)
                }
            }
        } else {
            nums3 = nums1 + nums2
        }
        
        if nums3.count > 0 {
            if nums3.count%2 == 0 {
                return Double((nums3[nums3.count/2] + nums3[nums3.count/2-1]))/2.0
            } else {
                return Double(nums3[(nums3.count-1)/2])
            }
        }
        
        return Double(0)
    }
    
    
    // 5 最长回文子串 中心扩展算法
    private func expandAroundCenter(strings: [String], L: Int, R: Int) -> Int{
        var left = L, right = R
        while left >= 0 && right < strings.count && strings[left] == strings[right] {
            left -= 1
            right += 1
        }
        return (right-1) - (left+1) + 1
    }
    
    func longestPalindrome(_ s: String) -> String {
        let strings = s.map{ String($0) }
        if strings.count < 1 { return "" }
        var start = 0, end = 0
        for i in 0..<strings.count {
            let len1 = expandAroundCenter(strings: strings, L: i, R: i)
            let len2 = expandAroundCenter(strings: strings, L: i, R: i+1)
            let lenMax = max(len1, len2)
            if lenMax > (end - start) {
                start = i - (lenMax-1)/2
                end = i + lenMax/2
            }
        }
        var maxSub = ""
        for chart in strings[start...end] {
            maxSub += chart
        }
        return maxSub
    }
    
    
    func convert(_ s: String, _ numRows: Int) -> String {
        if numRows == 1 { return s }
        var result: [[String]] = []
        for _ in 0..<min(s.count, numRows) {
            result.append([String]())
        }
        var curRow = 0
        var isDown = true
        for char in s.map({ String($0) }) {
            result[curRow].append(char)
            if curRow == 0 {
                isDown = true
            } else if curRow == numRows - 1 {
                isDown = false
            }
            if isDown {
                curRow += 1
            } else {
                curRow -= 1
            }
        }
        var resultString = ""
        for rowArray in result {
            resultString += rowArray.joined()
        }
        return resultString
    }
    
//    func reverse(_ x: Int) -> Int {
//        var result = 0
//        var input = abs(x)
//        while input != 0 {
//            let pop = input % 10
//            input /= 10
//            if (result > INT32_MAX / 10 || (result == INT32_MAX / 10 && pop > 7)) { return 0 }
//            result = result * 10 + pop
//        }
//        if x < 0 {
//            result = -result
//        }
//        return result
//    }
    
    
    func myAtoi(_ str: String) -> Int {
        var isPositive: Bool?
        var nums = [Character]()
        for char in str {
            if (String(char) == "-" || String(char) == "+" || String(char) == " "), isPositive == nil, nums.count == 0 {
                if (String(char) == "-") {
                    isPositive = false
                } else if (String(char) == "+") {
                    isPositive = true
                }
                continue
            }
            if let _ = Int(String(char)), nums.count >= 0 {
                nums.append(char)
            } else {
                break
            }
        }
        var result = 0
        for i in nums {
            if (result > INT32_MAX / 10 || (result == INT32_MAX / 10 && Int(String(i))! > 7)) {
                if isPositive == false {
                    result = -Int(INT32_MAX)-1
                } else {
                    result = Int(INT32_MAX)
                }
                return result
            }
            result = result * 10 + Int(String(i))!
        }
        if isPositive == false {
            result = -result
        }
        return result
    }
    
    func isPalindrome(_ x: Int) -> Bool {
        if x < 0 {
            return false
        }
        let xStr = String(x)
        let xStrR = String(xStr.reversed())
        if xStr == xStrR {
            return true
        }
        return false
    }
    
    
    func maxArea(_ height: [Int]) -> Int {
        var maxSize = 0
        var left_index = 0
        var right_index = height.count-1
        maxSize = (right_index - left_index) * min(height[left_index], height[right_index])
        while left_index < right_index {
            if height[left_index] > height[right_index] {
                right_index -= 1
            } else {
                left_index += 1
            }
            maxSize = max(maxSize, (right_index - left_index) * min(height[left_index], height[right_index]))
        }
        return maxSize
    }
    
    func intToRoman(_ num: Int) -> String {
        if num == 0 { return "0" }
        let all = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I",]
        let allValues = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1,]
        var result = ""
        var tmpNum = num
        for i in 0 ... 12 {
            while tmpNum >= allValues[i] {
                tmpNum -= allValues[i]
                result = result + all[i]
            }
        }
        return result
    }
    
    
    func romanToInt(_ s: String) -> Int {
        if s.count == 0 { return 0 }
        let dic = ["M":1000, "D":500, "C":100, "L":50, "X":10, "V":5, "I":1, "CM":800, "CD":300, "XC":80, "XL":30, "IX":8, "IV":3]
        var result = 0
        for (i, char) in s.enumerated() {
            let key = String(char)
            if let tmpSingle = dic[key] {
                let stringIndex = s.index(s.startIndex, offsetBy: max(i - 1, 0))
                let lastSingle = String(s[stringIndex])
                if let tmpDouble = dic[lastSingle + key] {
                    result += tmpDouble
                } else {
                    result += tmpSingle
                }
            }
        }
        return result
    }
    
    func longestCommonPrefix(_ strs: [String]) -> String {
        if strs.count == 0 { return "" }
        if strs.count == 1 { return strs.first! }
        //找到长度最小的字符串
        var minStrLength = INTPTR_MAX
        for str in strs {
            minStrLength = min(minStrLength, str.count)
        }
        if minStrLength == 0 { return "" }
        //二分查找
        var left = 0
        var right = minStrLength - 1
        var mid = 0
        let firstStr = strs.first!
        var isDiff = false
        var common = ""
        func helpToIndex(num: Int) -> String.Index {
            return firstStr.index(firstStr.startIndex, offsetBy: num)
        }
        func helpDiff(common: String) -> Bool {
            for str in strs {
                guard str.hasPrefix(common) else {
                    return true
                }
            }
            return false
        }
        while left <= right {
            isDiff = false
            mid = (right - left) / 2 + left
            let midIndex = helpToIndex(num: mid)
            common = String(firstStr[...midIndex])
            isDiff = helpDiff(common: common)
            if isDiff {
                right = mid - 1
            } else {
                left = mid + 1
            }
        }
        mid = (right - left) / 2 + left - 1
        if mid < 0 { return "" }
        return String(firstStr[helpToIndex(num: 0) ... helpToIndex(num: mid)])
    }
    
    func threeSum(_ nums: [Int]) -> [[Int]] {
        guard nums.count >= 3 else {
            return []
        }
        let input = nums.sorted()
        if input.first! > 0 || input.last! < 0 { return [] }
        var res = Set<[Int]>()
        
        for (i, num1) in input[0 ..< nums.count - 2].enumerated() {
            if num1 > 0 {
                break
            }
            if i > 0, num1 == input[i - 1] {
                continue
            }
            var j = i + 1, k = input.count - 1
            while input[k] >= 0, j < k {
                let sum = num1 + input[j] + input[k]
                if sum == 0 {
                    res.insert([num1, input[j], input[k]])
                    k -= 1
                    j += 1
                } else if sum > 0 {
                    k -= 1
                } else if sum < 0 {
                    j += 1
                }
            }
        }
        return Array(res)
    }
    
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        if nums.count < 3 { return 0 }
        var input = Array(nums)
        input = input.sorted()
        if input.first == input.last { return input.first! * 3 }
        var result = input[0] + input[1] + input[2]
        for i in 0 ..< input.count {
            var startIndex = i+1, endIndex = input.count - 1
            while startIndex < endIndex {
                let sum = input[i] + input[startIndex] + input[endIndex]
                if abs(target - sum) < abs(target - result) {
                    result = sum
                } else if target - sum < 0 {
                    endIndex -= 1
                } else if target - sum > 0 {
                    startIndex += 1
                } else {
                    //target = sum
                    return sum
                }
            }
        }
        return result
    }
    
    
    
    func letterCombinations(_ digits: String) -> [String] {
        if digits.count == 0 {
            return []
        }
        let dic = [
            2 : "abc",
            3 : "def",
            4 : "ghi",
            5 : "jkl",
            6 : "mno",
            7 : "pqrs",
            8 : "tuv",
            9 : "wxyz",
        ];
        var result = [String]()
        func helper(_ i: Int, _ tmp: String) {
            if i == digits.count {
                result.append(tmp)
            } else {
                let key = digits[digits.index(digits.startIndex, offsetBy: i)]
                for char in dic[Int(String(key))!]! {
                    helper(i + 1, tmp + String(char))
                }
            }
        }
        helper(0, "")
        return result
    }
    
    
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        if nums.count < 4 { return [] }
        var input = nums.sorted()
        var tmpSum = 0
        var res = Set<[Int]>()
        var threeSum = 0
        var threeInput = [Int]()
        for (i, num1) in input.enumerated() {
            //转化为三数之和
            threeSum = target - num1
            threeInput = Array(input[i + 1 ..< input.count])
            for (j, _) in threeInput.enumerated() {
                var start = j + 1, end = threeInput.count - 1
                while start < end {
                    tmpSum = threeInput[j] + threeInput[start] + threeInput[end]
                    if tmpSum == threeSum {
                        res.insert([input[i], threeInput[j], threeInput[start], threeInput[end]])
                        start += 1
                        end -= 1
                    } else if tmpSum > threeSum {
                        end -= 1
                    } else if tmpSum < threeSum {
                        start += 1
                    }
                }
            }
        }
        return Array(res)
    }
}
