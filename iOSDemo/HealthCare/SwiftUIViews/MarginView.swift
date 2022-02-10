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
                    capsuledText(text)
                        .frame(alignment: .center)
                        .padding(.horizontal, 5)
                    Line.infinity(.horizontal)
                    Line.vertical(10)
                }
            case .vertical:
                VStack(spacing: 0) {
                    Line.horizontal(10)
                    Line.infinity(.vertical)
                    capsuledText(text)
                        .frame(alignment: .center)
                        .padding(.vertical, 5)
                    Line.infinity(.vertical)
                    Line.horizontal(10)
                }
        }
    }
}
