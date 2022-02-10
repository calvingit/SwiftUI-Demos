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
        GeometryReader { geometry in
//            let pWidth = geometry.size.width
//            let pHeight = geometry.size.height

            ZStack(alignment: .topLeading) {

                Rectangle()
                    .fill(Color.white)
                    .frame(width: regionFrame.width, height: regionFrame.height, alignment: .topLeading)
                    .border(Color.primaryGreen)
                    .offset(x: regionFrame.minX, y: regionFrame.minY)


                if let widthText = widthText {
                    lengthText(widthText)
                        .offset(x: regionFrame.minX + regionFrame.width/2 - 5, y: regionFrame.minY + regionFrame.height)
                }

                if let heightText = heightText {
                    lengthText(heightText)
                        .offset(x: regionFrame.minX + regionFrame.width + 2, y: regionFrame.minY + regionFrame.height/2 - 5)
                }

                if let name = name {
                    centerTitle(name)
                }

                ArrowLine(.horizontal, text: "3.3m")
                    .frame(width: regionFrame.minX,  alignment: .leading)
                    .offset(x: 0,y: regionFrame.minY + regionFrame.height / 2)

                ArrowLine(.vertical, text: "4.3m")
                    .frame(height: regionFrame.minY)
                    .offset(x: regionFrame.minX + regionFrame.width / 2 - 13)
                if isSelected {
                    anchors()
                }
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
        let centerY = regionFrame.minY + regionFrame.height / 2
        let centerX = regionFrame.minX + regionFrame.width / 2
        let nameRect = name.sizeOf(.systemFont(ofSize: 10))
        return Text(name)
            .font(.system(size: 10))
            .offset(x: centerX - nameRect.width/2, y: centerY - nameRect.height / 2)
    }

    func anchors() -> some View {
        let centers = [
            CGPoint(x: regionFrame.minX, y: regionFrame.minY),
            CGPoint(x: regionFrame.minX + regionFrame.width, y: regionFrame.minY),
            CGPoint(x: regionFrame.minX, y: regionFrame.minY  + regionFrame.height),
            CGPoint(x: regionFrame.minX + regionFrame.width, y: regionFrame.minY + regionFrame.height),
        ]

        return  ForEach([0,1,2,3], id: \.self) { index in

            AngleView(point: centers[index])
        }
    }
}
