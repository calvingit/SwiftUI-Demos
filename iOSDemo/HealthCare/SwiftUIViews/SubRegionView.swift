//
//  SubRegionView.swift
//  iOSDemo
//
//  Created by zhangwen on 2022/2/10.
//

import SwiftUI


// 子区域
struct SubRegionView: View {
    // 子区域
    let regionFrame: CGRect
    // 子区域名称
    let name: String?
    // 长度m
    let widthText: String?
    // 宽度m
    let heightText: String?

    let isSelected: Bool

    init(_ regionFrame: CGRect = .zero, name: String, widthText: String?, heightText: String?, isSelected: Bool = false) {
        self.regionFrame = regionFrame
        self.name = name
        self.widthText = widthText
        self.heightText = heightText
        self.isSelected = isSelected
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            Rectangle()
                .fill(Color.white)
                .frame(width: regionFrame.width, height: regionFrame.height)
                .border(Color.primaryGreen)
                .position(regionFrame.center)

            if let widthText = widthText {
                lengthText(widthText)
                    .offset(x: regionFrame.x + regionFrame.width/2 - 5, y: regionFrame.y + regionFrame.height)
            }

            if let heightText = heightText {
                lengthText(heightText)
                    .offset(x: regionFrame.x + regionFrame.width + 2, y: regionFrame.y + regionFrame.height/2 - 5)
            }

            if let name = name {
                centerTitle(name)
            }

            ArrowLine(.horizontal, text: "3.3m")
                .frame(width: regionFrame.x,  alignment: .leading)
                .offset(x: 0,y: regionFrame.y + regionFrame.height / 2)

            ArrowLine(.vertical, text: "4.3m")
                .frame(height: regionFrame.y, alignment: .top)
                .offset(x: regionFrame.x + regionFrame.width / 2 - 13)

            if isSelected {
                anchors()
            }
        }
    }

    // 长度和宽度
    func lengthText(_ text: String) -> some View {
        return Text(text)
            .foregroundColor(Color(0x6A6A6A))
            .font(.system(size: 10))
    }

    // 名称
    func centerTitle(_ name: String) -> some View {
        let centerY = regionFrame.y + regionFrame.height / 2
        let centerX = regionFrame.x + regionFrame.width / 2
        let nameRect = name.sizeOf(.systemFont(ofSize: 10))
        return Text(name)
            .font(.system(size: 10))
            .offset(x: centerX - nameRect.width/2, y: centerY - nameRect.height / 2)
    }

    // 四个角
    func anchors() -> some View {
        let centers = [
            CGPoint(x: regionFrame.x, y: regionFrame.y),
            CGPoint(x: regionFrame.x + regionFrame.width, y: regionFrame.y),
            CGPoint(x: regionFrame.x, y: regionFrame.y  + regionFrame.height),
            CGPoint(x: regionFrame.x + regionFrame.width, y: regionFrame.y + regionFrame.height),
        ]

        return  ForEach([0,1,2,3], id: \.self) { index in
            AngleView(center: centers[index], radius: 8)
        }
    }
}

#if DEBUG
struct SubRegionView_Preview: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading, spacing: 0) {
            GeometryReader { _ in
                SubRegionView(CGRect(center: CGPoint(x: 150, y: 150), width: 100, height: 100), name: "客厅", widthText: "2.3", heightText: "3.4", isSelected: true)

            }
            .frame(width: 300, height: 300)

        }
        .background(Color.gray)
        //.previewLayout(.sizeThatFits)
    }
}
#endif
