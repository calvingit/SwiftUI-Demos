//
//  OuterBorder.swift
//  iOSDemo
//
//  Created by zhangwen on 2022/2/10.
//

import SwiftUI

// 外边框
struct OuterBorder: View {

    let text: String
    let color: Color

    init(_ text: String, color: Color = Color(0xCACACA)) {
        self.text = text
        self.color = color
    }

    var body: some View {
        Rectangle()
            .fill(color)
            .overlay (
                Text(text)
                    .foregroundColor(.black)
                    .font(.system(size: 8))
            )
    }
}

#if DEBUG
struct OuterBorder_Preview: PreviewProvider {
    static var previews: some View {
        VStack {
            OuterBorder("2.3m")
                .frame(width: 200, height: 10, alignment: .center)
        }
    }
}
#endif
