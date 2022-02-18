//
//  TipsBar.swift
//  iOSDemo
//
//  Created by zhangwen on 2022/2/10.
//

import SwiftUI

// 顶部颜色提示
struct TipItem: View {
    let color: Color
    let text: String

    var body: some View {
        HStack(spacing: 5) {
            Rectangle()
                .fill(color)
                .frame(width: 10, height: 10, alignment: .leading)
            Text(text)
                .foregroundColor(.black)
                .font(.system(size: 10))
        }
    }
}

// 墙面
let wallColor = Color(0xCACACA)
// 天花板
let ceilingColor = Color(0xCCECE0)
// 检测范围
let detectionRangeColor = Color(0x688DFF, opacity: 0.2)

// 顶部颜色提示部分
struct TipsBar: View {
    var body: some View {
        HStack {
            TipItem(color: wallColor, text: "墙面")
            TipItem(color: ceilingColor, text: "天花板")
            TipItem(color: detectionRangeColor, text: "检测范围")
            Spacer()
            Button {
                //
            } label: {
                Image(systemName: "questionmark.circle")
                    .resizable()
                    .renderingMode(.template)
                    .accentColor(.primaryGreen)
                    .frame(width: 16, height: 16)
            }

        }
    }
}

#if DEBUG
struct TipsBar_Preview: PreviewProvider {
    static var previews: some View {
        TipsBar()
            .frame(width: 200, alignment: .center)
    }
}
#endif
