//
//  GridBackground.swift
//  iOSDemo
//
//  Created by zhangwen on 2022/2/10.
//

import SwiftUI

// 网格图
struct GridBackground: View {
    let color = Color(0xDEE5E6)
    let l: CGFloat = 5 // 格子间距

    var body: some View {
        GeometryReader { reader in
            let w = reader.size.width
            let h = reader.size.height

            // 竖线
            let maxW = Int(w/l) + 1
            ForEach(0..<maxW) { i in
                drawLine(CGPoint(x: CGFloat(i) * l , y: 0),
                         end: CGPoint(x: CGFloat(i) * l , y: h))
            }

            // 横线
            let maxH = Int(h/l) + 1
            ForEach(0..<maxH) { i in
                drawLine(CGPoint(x: 0 , y: CGFloat(i) * l),
                         end: CGPoint(x: w , y: CGFloat(i) * l))
            }
        }
        .background(Color(0xF0FDF8))
    }

    func drawLine(_ start: CGPoint, end: CGPoint) -> some View {
        Path { p in
            p.move(to: start)
            p.addLine(to: end)
        }
        .stroke(
            color,
            style: StrokeStyle(
                lineWidth: 0.7,
                lineCap: .square,
                lineJoin: .miter,
                miterLimit: 0,
                dash: [0, l],
                dashPhase: 0
            )
        )
    }
}

#if DEBUG
struct GridBackground_Preview: PreviewProvider {
    static var previews: some View {
        GridBackground()
            .frame(width: 200, height: 100, alignment: .center)
            .background(Color.red)
    }
}
#endif
