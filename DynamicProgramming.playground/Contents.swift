import UIKit

var str = "Hello, playground"

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

