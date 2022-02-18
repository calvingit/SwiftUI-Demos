//
//  SubRegion.swift
//  HealthCare
//
//  Created by zhangwen on 2022/1/21.
//  Copyright © 2022 Legrand Intelligent Electrical (Huizhou) Co., Ltd. All rights reserved.
//

import Foundation

// 子区域
struct SubRegion: Codable, Equatable {
    // 设备的左边
    var xMax: Float
    // 设备的右边
    var xMin: Float
    // 最大向前 4
    var yMax: Float
    // 0
    let yMin: Float = 0
    // 0 - 4
    var id: Float

    enum CodingKeys: String, CodingKey {
        case xMax = "subXmax"
        case xMin = "subXmin"
        case yMax = "subYmax"
        case yMin = "subYmin"
        case id = "subID"
    }
}
