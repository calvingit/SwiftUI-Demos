//
//  MarginView.swift
//  iOSDemo
//
//  Created by zhangwen on 2022/2/10.
//

import SwiftUI

// 外边框的长度和宽度提示
struct MarginView: View {

    let axes: Axis
    let text: String

    init(_ axes: Axis, text: String) {
        self.axes = axes
        self.text = text
    }

    var body: some View {
        switch axes {
            case .horizontal:
                HStack(spacing: 0) {
                    Line.vertical(10)
                    Line.infinity(.horizontal)
                    Text(text)
                        .capsuledStyle()
                        .frame(alignment: .center)
                        .padding(.horizontal, 3)
                    Line.infinity(.horizontal)
                    Line.vertical(10)
                }
            case .vertical:
            VStack(alignment: .center, spacing: 0) {
                    Line.horizontal(10)
                    Line.infinity(.vertical)
                    Text(text)
                        .capsuledStyle()
                        .frame(alignment: .center)
                        .padding(.vertical, 3)
                    Line.infinity(.vertical)
                    Line.horizontal(10)
                }
        }
    }
}

#if DEBUG
struct MarginView_Preview: PreviewProvider {
    static var previews: some View {
        VStack {
            MarginView(.horizontal, text: "3.4m")
                .frame(width: 200, height: 20, alignment: .topLeading)
                .padding(.top, 10)
                .padding(.horizontal, 8)

            MarginView(.vertical, text: "2.3m")
                .frame(height: 200)
                .background(Color.black.opacity(0.1))
        }
    }
}
#endif
