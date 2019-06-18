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
