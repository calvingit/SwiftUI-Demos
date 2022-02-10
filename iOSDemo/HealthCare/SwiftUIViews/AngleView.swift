//
//  AngleView.swift
//  iOSDemo
//
//  Created by zhangwen on 2022/2/10.
//

import SwiftUI

// 选中区域的四个角
struct AngleView: View {
    // 半径
    let radius: CGFloat = 8
    // 选中区域的四个角位置
    let point: CGPoint

    var body: some View {
        Circle()
            .fill(Color.red)
            .frame(width: radius * 2, height: radius * 2, alignment: .topLeading)
            .offset(x: point.x - radius, y: point.y - radius)
    }
}
