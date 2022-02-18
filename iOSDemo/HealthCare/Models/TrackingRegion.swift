//
//  TrackingRegion.swift
//  HealthCare
//
//  Created by zhangwen on 2022/1/21.
//  Copyright © 2022 Legrand Intelligent Electrical (Huizhou) Co., Ltd. All rights reserved.
//

import Foundation

// 检测区域，以设备为中心
struct TrackingRegion: Codable, Equatable {
    // 设备的左边
    var xMax: Float
    // 设备的右边
    var xMin: Float
    // 最大向前 4
    var yMax: Float
    // 0
    let yMin: Float = 0
    // 高度
    var zMax: Float
    // 0
    let zMin: Float = 0
    // 0 - 4
    var locationZ: Float

    enum CodingKeys: String, CodingKey {
        case xMax = "Xmax"
        case xMin = "Xmin"
        case yMax = "Ymax"
        case yMin = "Ymin"
        case zMax = "Zmax"
        case zMin = "Zmin"
        case locationZ
    }
}
