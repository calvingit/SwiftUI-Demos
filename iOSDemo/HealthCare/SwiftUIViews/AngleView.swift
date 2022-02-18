//
//  AngleView.swift
//  iOSDemo
//
//  Created by zhangwen on 2022/2/10.
//

import SwiftUI

// 选中区域的四个角
struct AngleView: View {
    // 选中区域的四个角位置
    let center: CGPoint
    // 半径
    let radius: CGFloat

    var body: some View {
        Circle()
            .fill(Color.red)
            .frame(width: radius * 2, height: radius * 2, alignment: .topLeading)
            .position(x: center.x, y: center.y)
    }
}

#if DEBUG
struct AngleView_Preview: PreviewProvider {
    static var previews: some View {
        ZStack(alignment: .leading) {
            AngleView(center: CGPoint(x: 80, y: 80), radius: 60)

        }
    }
}
#endif
