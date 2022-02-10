//
//  CapsuledText.swift
//  iOSDemo
//
//  Created by zhangwen on 2022/2/10.
//

import SwiftUI

// 圆角背景白色文本
func capsuledText(_ text: String,
                  backgroundColor: Color = .primaryGreen,
                  fontSize: CGFloat = 10.0) -> some View {
    Text(text)
        .padding(EdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 5))
        .background(Capsule().fill(backgroundColor))
        .foregroundColor(.white)
        .font(.system(size: fontSize))
}
