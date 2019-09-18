import UIKit

var str = "Hello, playground"

//子集 位运算
// [1, 2, 3] 的子集
// 用 0 和 1 表示元素该子集是否存在
// 【000】【001】【010】【100】【011】【101】【110】【111】
// 转换成十进制
//   0      1     2     3     4      5     6     7
func subsets(_ nums: [Int]) -> [[Int]] {
    
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

//给定一个非空整数数组，除了某个元素只出现一次以外，其余每个元素均出现两次。找出那个只出现了一次的元素
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
