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
        print(threeSum([0,0,0,]))
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
        var result = false
        if nums.count <= 1 {
            return true
        }
        func help(lastIndex: Int) {
            if lastIndex == 0 {
                result = true
                return
            }
            for i in (0 ..< lastIndex).reversed() {
                if nums[i] + i >= lastIndex {
                    help(lastIndex: i)
                    break
                }
            }
        }
        help(lastIndex: nums.count - 1)
        return result
    }
    
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
            if n % 2 == 0 {
                return half * half
            } else {
                return half * half * X
            }
        }
        
        return helper(X, N)
    }
    

    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var dic = [[String] : [String]]()
        for item in strs {
            let itemArray = item.map{ String($0) }.sorted()
            if dic.keys.contains(itemArray) {
                var value = dic[itemArray]
                value?.append(item)
                dic[itemArray] = value
            } else {
                dic[itemArray] = [item]
            }
        }
        var result = [[String]]()
        for key in dic.keys {
            result.append(dic[key]!)
        }
        return result
    }
    
    func rotate(_ matrix: inout [[Int]]) {
        for i in 0 ..< matrix[0].count {
            for j in i ..< matrix[0].count {
                var tmpA = matrix[i][j], tmpB = matrix[j][i]
                swap(&tmpA, &tmpB)
                matrix[i][j] = tmpA
                matrix[j][i] = tmpB
            }
        }
        for (index, tmp) in matrix.enumerated() {
            matrix[index] = tmp.reversed()
        }
        print(matrix)
    }
    
    
    func permute(_ nums: [Int]) -> [[Int]] {
        if nums.count == 0 || nums.count == 1 { return [nums] }
        var result = [[Int]]()
        func helper(orignNums: [Int], tmp: [Int]) {
            if orignNums.count == 0 {
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
        while i < nums.count {
            if nums[i] == val {
                nums[i] = nums[nums.count - 1]
                nums.removeLast()
            } else {
                i += 1
            }
        }
        return nums.count
    }
    
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        if nums.count == 0 { return 0 }
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
        for i in 0 ..< s.count {
            if let last = stack.last,
                hash.keys.contains(last),
                String(s[s.index(s.startIndex, offsetBy: i)]) == hash[last]
            {
                stack.removeLast()
            } else {
                stack.append(String(s[s.index(s.startIndex, offsetBy: i)]))
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
    
    func reverse(_ x: Int) -> Int {
        var result = 0
        var input = abs(x)
        while input != 0 {
            let pop = input % 10
            input /= 10
            if (result > INT32_MAX / 10 || (result == INT32_MAX / 10 && pop > 7)) { return 0 }
            result = result * 10 + pop
        }
        if x < 0 {
            result = -result
        }
        return result
    }
    
    
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
        var input = nums.sorted()
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
        var input = Array(nums)
        input = input.sorted()
        if input.first! > target, input.last! < target { return [] }
        var hash = [Int : [Int]]()
        var result = [[Int]]()
        for i in 0 ..< input.count {
            for j in i + 1 ..< input.count {
                for k in j + 1 ..< input.count {
                    if hash.keys.contains(nums[k]) {
                        var tmp = [nums[k]] + hash[nums[k]]!
                        tmp = tmp.sorted()
                        result.append(tmp)
                    } else {
                        hash[target - (nums[i] + nums[j] + nums[k])] = [nums[i], nums[j], nums[k]]
                    }
                    if k == input.count - 1 {
                        hash.removeAll()
                    }
                }
            }
        }
        let tmpResult = Set(result)
        return Array(tmpResult)
    }
}
