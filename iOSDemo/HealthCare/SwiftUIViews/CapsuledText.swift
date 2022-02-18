//
//  CapsuledText.swift
//  iOSDemo
//
//  Created by zhangwen on 2022/2/10.
//

import SwiftUI

extension Text {
    // 圆角背景白色文本
    func capsuledStyle(backgroundColor: Color = .primaryGreen,
                       fontSize: CGFloat = 10.0) -> some View {
        self.padding(EdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 5))
            .background(Capsule().fill(backgroundColor))
            .foregroundColor(.white)
            .font(.system(size: fontSize))
    }
}

#if DEBUG
struct CapsuledText_Preview: PreviewProvider {
    static var previews: some View {
        Text("3.4m")
            .capsuledStyle()
            .previewLayout(.sizeThatFits)
    }
}
#endif
