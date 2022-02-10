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
            ForEach(3..<Int(w/l)) { i in
                drawLine(CGPoint(x: CGFloat(i) * l , y: 0),
                         end: CGPoint(x: CGFloat(i) * l , y: h))
            }

            // 横线
            ForEach(3..<Int(h/l)) { i in
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
