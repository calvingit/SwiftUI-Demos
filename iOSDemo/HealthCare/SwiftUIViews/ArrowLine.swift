//
//  ArrowLine.swift
//  iOSDemo
//
//  Created by zhangwen on 2022/2/10.
//

import SwiftUI

// 子区域的箭头
struct ArrowLine: View {

    let axes: Axis
    let text: String

    init(_ axes: Axis, text: String) {
        self.axes = axes
        self.text = text
    }

    var body: some View {
        GeometryReader { reader in
            let pWidth = reader.size.width
            let pHeight = reader.size.height

            switch axes {
            case .horizontal:
                VStack(spacing: 0)  {
                    HStack(spacing: 0) {
                        if pWidth > 5 {
                            Arrow.to(.leading)
                        }
                        Line.infinity(color: .primaryGreen)
                        if pWidth > 10 {
                            Arrow.to(.trailing)
                        }
                    }
                    // 宽度太小了，不显示
                    if pWidth > 35 {
                        Text(text)
                            .capsuledStyle(fontSize: 8)
                    }
                }

            case .vertical:
                VStack(spacing: 0) {
                    if pHeight > 5 {
                        Arrow.to(.top)
                    }

                    Line.infinity(.vertical, color: .primaryGreen)

                    if pHeight > 26 {
                        Text(text)
                            .capsuledStyle(fontSize: 8)
                        Line.infinity(.vertical, color: .primaryGreen)
                    }

                    if pHeight > 10 {
                        Arrow.to(.bottom)
                    }
                }
            }
        }
    }
}

#if DEBUG
struct ArrowLine_Preview: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .center) {
            ArrowLine(.horizontal, text: "2.3m")
                .frame(width: 200, height: 30)

            ArrowLine(.vertical, text: "2.3m")
                .frame(height: 100)
                .offset(x: 100, y: 0)
        }
    }
}
#endif
