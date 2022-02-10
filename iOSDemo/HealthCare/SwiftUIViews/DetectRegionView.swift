//
//  DetectRegionView.swift
//  iOSDemo
//
//  Created by zhangwen on 2022/2/10.
//

import SwiftUI

// 设备视图
struct DeviceView: View {
    // 紫色
    let hex: UInt32 = 0x985DFF
    
    var body: some View {
        GeometryReader { geo in
            let center = CGPoint(x: geo.size.width/2, y: 0)
            let radius: CGFloat = 8.0
            semiCircle(center, radius * 3)
                .fill(Color(hex, opacity: 0.2))
            semiCircle(center, radius * 2)
                .fill(Color(hex, opacity: 0.3))
            semiCircle(center, radius)
                .fill(Color(hex, opacity: 0.9))
        }
    }

    // 半圆
    func semiCircle(_ center: CGPoint, _ radius: CGFloat) -> Path {
        Path { path in
            path.addArc(center: center,
                        radius: radius,
                        startAngle: .degrees(0),
                        endAngle: .degrees(180),
                        clockwise: false)
            path.closeSubpath()
        }
    }

}

// 设备检测区域，最大为4m * 4m
// 设备可以拖动，检测区域
struct DetectRegionView: View {

    var body: some View {
        ZStack(alignment: .topLeading) {
            Rectangle()
                .fill(ceilingColor)
                .scaledToFill()
            DeviceView()
                .frame(width: 24, height: 14, alignment: .top)

        }
    }
}
