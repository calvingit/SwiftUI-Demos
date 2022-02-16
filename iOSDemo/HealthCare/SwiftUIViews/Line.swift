//
//  Line.swift
//  iOSDemo
//
//  Created by zhangwen on 2022/2/10.
//

import SwiftUI

// 直线或竖线
struct Line: View {

    let axes: Axis
    let color: Color
    let lineWidth: CGFloat

    init(_ axes: Axis, color: Color, lineWidth: CGFloat) {
        self.axes = axes
        self.color = color
        self.lineWidth = lineWidth
    }

    var body: some View {
        GeometryReader { reader in
            let w = reader.size.width
            let h = reader.size.height

            Path { path in
                switch axes {
                    case .horizontal:
                        path.move(to: CGPoint(x: 0, y: h/2))
                        path.addLine(to: CGPoint(x: w, y: h/2))
                    case .vertical:
                        path.move(to: CGPoint(x: w/2, y: 0))
                        path.addLine(to: CGPoint(x: w/2, y: h))
                }
            }
            .stroke(color, lineWidth: lineWidth)
        }
    }

    // 长度自动扩展
    static func infinity(_ axes: Axis = .horizontal, color: Color = .divider, lineWidth: CGFloat = 0.5) -> some View {
        switch axes {
            case .horizontal:
               return Line(axes, color: color, lineWidth: lineWidth)
                    .frame(width: .infinity, height: 1)

            case .vertical:
               return Line(axes, color: color, lineWidth: lineWidth)
                    .frame(width: 1, height: .infinity)
        }
    }

    // 水平，高度为1
    static func horizontal(_ width: CGFloat, color: Color = .divider, lineWidth: CGFloat = 0.5) -> some View {
        Line(.horizontal, color: color, lineWidth: lineWidth)
            .frame(width: width, height: 1)
    }

    // 垂直，宽度为1
    static func vertical(_ height: CGFloat, color: Color = .divider, lineWidth: CGFloat = 0.5) -> some View {
        Line(.vertical, color: color, lineWidth: lineWidth)
            .frame(width: 1, height: height)
    }
}

struct Line_Preview: PreviewProvider {
    static var previews: some View {
        Line.infinity(.horizontal, color: .red)
            .offset(y: 30)
    }
}
