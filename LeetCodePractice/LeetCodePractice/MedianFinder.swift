//
//  MedianFinder.swift
//  LeetCodePractice
//
//  Created by wiley on 2019/12/3.
//  Copyright © 2019 Wiley. All rights reserved.
//

import Foundation

class MedianFinder {

    /** initialize your data structure here. */
    var array = [Int]()
    
    init() {
        
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
    
    func addNum(_ num: Int) {
        if array.count == 0 {
            array.append(num)
        } else {
            let insertIndex = searchInsert(array, num)
            array.insert(num, at: insertIndex)
        }
    }
    
    func findMedian() -> Double {
        let n = array.count
        if n == 0 {
            return Double(0)
        }
        if n & 1 == 0 {
            // 偶数
            return Double(array[n / 2] + array[n / 2 - 1]) * 0.5
        } else {
            return Double(array[n / 2])
        }
    }
}
