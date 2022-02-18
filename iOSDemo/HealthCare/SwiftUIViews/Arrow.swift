//
//  Arrow.swift
//  iOSDemo
//
//  Created by zhangwen on 2022/2/10.
//

import SwiftUI

// 三角形箭头
struct Arrow: View {
    let direction: Edge
    let color: Color
    init(_ direction: Edge = .leading, color: Color = .primaryGreen) {
        self.direction = direction
        self.color = color
    }
    var body: some View {
        GeometryReader { reader in
            let w = reader.size.width
            let h = reader.size.height
            Path { path in
                path.move(to: CGPoint(x: 0, y: h/2))
                path.addLine(to: CGPoint(x: w, y: h/4))
                path.addLine(to: CGPoint(x: w, y: h*3/4))
                path.addLine(to: CGPoint(x: 0, y: h/2))
            }
            .fill(color)
            .rotationEffect(angleWithEdge(direction))
        }
    }

    func angleWithEdge(_ direction: Edge) -> Angle {
        switch direction {
            case .top:
                return .degrees(90)
            case .leading:
                return .degrees(0)
            case .bottom:
                return .degrees(270)
            case .trailing:
                return .degrees(180)
        }
    }

    static func to(_ e: Edge = .leading) -> some View {
        Arrow(e)
            .frame(width: 6, height: 6)
    }
}

#if DEBUG
struct Arrow_Preview: PreviewProvider {
    static var previews: some View {
        VStack {
            Arrow()
                .frame(width: 40, height: 40)
            Arrow(.trailing, color: .red)
                .frame(width: 40, height: 40)
            Arrow(.top, color: .green)
                .frame(width: 40, height: 40)
            Arrow(.bottom, color: .purple)
                .frame(width: 40, height: 40)
        }
    }
}
#endif
