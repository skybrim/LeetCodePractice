import UIKit

var str = "Hello, playground"

//给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    for i in 0..<nums.count {
        for j in i+1..<nums.count {
            if nums[i] + nums[j] == target {
                return [i, j]
            }
        }
    }
    return []
}

twoSum([2, 7, 11, 15], 9)

//给定一个字符串，请你找出其中不含有重复字符的 最长子串 的长度。
func lengthOfLongestSubstring(_ s: String) -> Int {
    let strings = s.map{ String($0) }
    var start = 0
    var end = 0
    for _ in 0..<strings.count {
        if Set(strings[start...end]).count == strings[start...end].count {
            end += 1
        } else {
            start += 1
            end += 1
        }
    }
    return end-start
}

lengthOfLongestSubstring("pwwkew")

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

convert("LEETCODEISHIRING", 4)

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

reverse(-1234)

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

maxArea([1,8,6,2,5,4,8,3,7])

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

intToRoman(3)

func romanToInt(_ s: String) -> Int {
    if s.count == 0 { return 0 }
    let singleStrs = ["M", "D", "C", "L", "X", "V", "I",]
    let doubleStrs = ["CM", "CD", "XC", "XL", "IX", "IV", ]
    let singleValues = [1000, 500, 100, 50, 10, 5, 1,]
    let doubleValues = [900, 400, 90, 40, 9, 4,]
    var romanStr = s
    var result = 0
    for i in 0 ..< doubleStrs.count {
        if romanStr.contains(doubleStrs[i]) {
            romanStr = romanStr.replacingOccurrences(of: doubleStrs[i], with: "")
            result += doubleValues[i]
        }
    }
    var leftStrings = romanStr.map{ String($0) }
    for j in 0 ..< singleStrs.count {
        if leftStrings.contains(singleStrs[j]) {
            repeat {
                result += singleValues[j]
                if leftStrings.count == 0 { break }
                leftStrings.removeFirst()
            } while leftStrings.first == singleStrs[j]
        }
    }
    return result
}

romanToInt("MCMXCIV")

func longestCommonPrefix(_ strs: [String]) -> String {
    if strs.count == 0 { return "" }
    var isDiff = false
    var count = 0
    var char: Character
    while isDiff != true {
        if strs.first!.count == count { return "" }
        char = strs.first![strs.first!.index(strs.first!.startIndex, offsetBy: count)]
        for string in strs {
            if count < string.count {
                if string[string.index(string.startIndex, offsetBy: count)] != char {
                    isDiff = true
                    break
                }
            } else {
                isDiff = true
                break
            }
        }
        if isDiff == false {
            count += 1
        }
        if strs.first!.count == count {
            isDiff = true
        }
    }
    count -= 1
    if count < 0 {
        return ""
    }
    return String(strs.first![strs.first!.startIndex ... strs.first!.index(strs.first!.startIndex, offsetBy: count)])
}

longestCommonPrefix(["a"])

func threeSum(_ nums: [Int]) -> [[Int]] {
    if nums.count < 3 { return [] }
    var input = Array(nums)
    input = input.sorted()
    if input.first == input.last, input.first == 0 { return [[0, 0, 0]] }
    if input.first! >= 0, input.last! <= 0 { return [] }
    var result = [[Int]]()
    for i in 0 ..< input.count {
        var hash = [Int:[Int]]()
        for j in i+1 ..< input.count {
            if let _ = hash[input[j]] {
                var res = Array(hash[input[j]]!)
                res.append(input[j])
                result.append(res)
                hash[input[j]] = nil
            } else {
                let tmp = input[i] + input[j]
                hash[-tmp] = [input[i],input[j]]
            }
        }
    }
    return Array(Set(result))
}
