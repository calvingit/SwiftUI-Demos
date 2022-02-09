//
//  MarginView.swift
//  iOSDemo
//
//  Created by zw on 2022/2/1.
//

import SwiftUI

extension Color {
    // 绿色
    static let primaryGreen = Color(0x55C4BD)
    // 灰色
    static let divider = Color(0x979797)
}


// 圆角背景白色文本
struct CapsuleText: View {
    let text: String
    let backgroundColor: Color
    let fontSize: CGFloat
    
    init(_ text: String,
         backgroundColor: Color = .primaryGreen,
         fontSize: CGFloat = 10.0
    ) {
        self.text = text
        self.backgroundColor = backgroundColor
        self.fontSize = fontSize
    }
    
    var body: some View {
        Text(text)
            .padding(EdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 5))
            .background(Capsule().fill(backgroundColor))
            .foregroundColor(.white)
            .font(.system(size: fontSize))
    }
}

// 直线或竖线
struct Line: View {
    
    let axes: Axis
    let color: Color
    let lineWidth: CGFloat
    
    init(_ axes: Axis = .horizontal, color: Color = .divider, lineWidth: CGFloat = 0.5) {
        self.axes = axes
        self.color = color
        self.lineWidth = lineWidth
    }
    
    var body: some View {
        GeometryReader { reader in
            let w = reader.size.width
            let h = reader.size.height
            
            Path { path in
                switch axes {
                    case .horizontal:
                        path.move(to: CGPoint(x: 0, y: h/2))
                        path.addLine(to: CGPoint(x: w, y: h/2))
                    case .vertical:
                        path.move(to: CGPoint(x: w/2, y: 0))
                        path.addLine(to: CGPoint(x: w/2, y: h))
                }
            }
            .stroke(color, lineWidth: lineWidth)
        }
    }
    
    // 长度自动扩展
    static func infinity(_ axes: Axis = .horizontal, color: Color = .divider) -> some View {
        switch axes {
            case .horizontal:
               return Line(axes, color: color)
                    .frame(width: .infinity, height: 1)
                
            case .vertical:
               return Line(axes, color: color)
                    .frame(width: 1, height: .infinity)
        }
    }
    
    // 水平，高度为1
    static func horizontal(_ width: CGFloat, color: Color = .divider) -> some View {
        Line(.horizontal, color: color)
            .frame(width: width, height: 1)
    }
    
    // 垂直，宽度为1
    static func vertical(_ height: CGFloat, color: Color = .divider) -> some View {
        Line(.vertical, color: color)
            .frame(width: 1, height: height)
    }
}

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
                    CapsuleText(text)
                        .frame(alignment: .center)
                        .padding(.horizontal, 5)
                    Line.infinity(.horizontal)
                    Line.vertical(10)
                }
            case .vertical:
                VStack(spacing: 0) {
                    Line.horizontal(10)
                    Line.infinity(.vertical)
                    CapsuleText(text)
                        .frame(alignment: .center)
                        .padding(.vertical, 5)
                    Line.infinity(.vertical)
                    Line.horizontal(10)
                }
        }
    }
}

// 网格图
struct GridBackground: View {
    let color = Color(0xDEE5E6)
    let l: CGFloat = 5 // 格子间距
    
    var body: some View {
        GeometryReader { reader in
            let w = reader.size.width
            let h = reader.size.height
            
            // 竖线
            ForEach(3..<Int(w/l)) { i in
                drawLine(CGPoint(x: CGFloat(i) * l , y: 0),
                         end: CGPoint(x: CGFloat(i) * l , y: h))
            }
            
            // 横线
            ForEach(3..<Int(h/l)) { i in
                drawLine(CGPoint(x: 0 , y: CGFloat(i) * l),
                         end: CGPoint(x: w , y: CGFloat(i) * l))
            }
        }
        .background(Color(0xF0FDF8))
    }
    
    func drawLine(_ start: CGPoint, end: CGPoint) -> some View {
        Path { p in
            p.move(to: start)
            p.addLine(to: end)
        }
        .stroke(
            color,
            style: StrokeStyle(
                lineWidth: 0.7,
                lineCap: .square,
                lineJoin: .miter,
                miterLimit: 0,
                dash: [0, l],
                dashPhase: 0
            )
        )
    }
}

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
                    .foregroundColor(wallColor)
                    .frame(width: 16, height: 16)
            }
            
        }
    }
}

// 外边框
struct OuterBorder: View {
    
    let text: String
    let color: Color
    
    init(_ text: String, color: Color = Color(0xCACACA)) {
        self.text = text
        self.color = color
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .fill(color)
            Text(text)
                .foregroundColor(.black)
                .font(.system(size: 8))
        }
    }
}

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
                        CapsuleText(text, fontSize: 8)
                    }
                }

            case .vertical:
                VStack(spacing: 0) {
                    if pHeight > 5 {
                        Arrow.to(.top)
                    }
                    
                    Line.infinity(.vertical, color: .primaryGreen)
                    
                    if pHeight > 26 {
                        CapsuleText(text, fontSize: 8)
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

// 选中区域的四个角
struct AngleView: View {
    // 半径
    let radius: CGFloat = 8
    // 选中区域的四个角位置
    let point: CGPoint
    
    var body: some View {
        Circle()
            .fill(Color.red)
            .frame(width: radius * 2, height: radius * 2, alignment: .topLeading)
            .offset(x: point.x - radius, y: point.y - radius)
    }
}

// 子区域
struct SubRegion: View {
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
        GeometryReader { reader in
            let pWidth = reader.size.width
            let pHeight = reader.size.height
            
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
        let nameRect = sizeWithText(text: name, font: .systemFont(ofSize: 10))
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

// 设备
struct DeviceView: View {
    // 紫色
    let hex: UInt32 = 0x985DFF
    var body: some View {
        GeometryReader { geo in
            let center = CGPoint(x: geo.size.width/2, y: 0)
            let radius: CGFloat = 8.0
            semiCircle(center, radius * 3)
                .fill(Color(hex, opacity: 0.2))
            semiCircle(center, radius * 2)
                .fill(Color(hex, opacity: 0.3))
            semiCircle(center, radius)
                .fill(Color(hex, opacity: 0.9))
        }
    }
    
    // 半圆
    func semiCircle(_ center: CGPoint, _ radius: CGFloat) -> Path {
        Path { path in
            path.addArc(center: center,
                        radius: radius,
                        startAngle: .degrees(0),
                        endAngle: .degrees(180),
                        clockwise: false)
            path.closeSubpath()
        }
    }
    
}

// 设备检测区域
struct DeviceRegionView: View {
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Rectangle()
                .fill(ceilingColor)
                .scaledToFill()
            DeviceView()
                .frame(width: 24, height: 14, alignment: .top)
            
        }
    }
}

struct MarginView_Previews: PreviewProvider {
    static var previews: some View {
        // 房间长度
        let roomWidth: CGFloat = 200.0
        // 房间宽度
        let roomHeight: CGFloat = 200.0
        // 墙边框厚度
        let marginWidth: CGFloat = 8.0
        
        ScrollView(.vertical) {
            
            GeometryReader { _ in
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 0) {
                        TipsBar()
                            .frame(width: roomWidth + marginWidth, height: 24)
                            .padding(.leading, 5)
                        
                        OuterBorder("A", color: .init(0xC6AD9D)).frame(width: roomWidth + marginWidth * 2, height: marginWidth)
                        
                        HStack(alignment: .center,spacing: 0) {
                            OuterBorder("B").frame(width: marginWidth, height: roomHeight)
                            GridBackground().frame(width: roomWidth, height: roomHeight)
                            OuterBorder("D").frame(width: marginWidth, height: roomHeight)
                            MarginView(.vertical, text: "9.9m")
                                .frame(height: roomHeight)
                                .padding(.leading, 5)
                        }
                        
                        OuterBorder("C").frame(width: roomWidth + marginWidth * 2, height: marginWidth)
                        MarginView(.horizontal, text: "4.5m").frame(width: roomWidth, height: roomHeight, alignment: .topLeading)
                            .padding(EdgeInsets(top: 10, leading: marginWidth, bottom: 0, trailing: marginWidth))
                    }
                }
            }
            .frame(width: roomWidth + 80, height: roomHeight + 80, alignment: .center)
            //.background(Color.red)
            .padding(EdgeInsets(top: 80, leading: 60, bottom: 0, trailing: 0))
            
            Divider()
                .background(Color.red)
                .frame(width: .infinity, height: 1, alignment: .top)
            
            HStack {
                ForEach(Edge.allCases, id: \.self) { item in
                    Arrow(item).frame(width: 6, height: 6, alignment: .top)
                }
            }
            
            HStack(spacing: 0) {
                Arrow.to(.top)
                Line(color: .primaryGreen).frame(width: 100, height: 1, alignment: .leading)
            }
            
            ZStack {
                DeviceRegionView()
                    .frame(width: 100, height: 50, alignment: .topTrailing)
                    .offset(x: 40, y: 0)

                SubRegion(CGRect(x: 20, y: 20, width: 50, height: 50), name: "书桌", widthText: "2m", heightText: "1m", isSelected: true)
                    
            }
            .frame(width: 200, height: 200, alignment: .center)
            .background(Color(UIColor.green.withAlphaComponent(0.1)))
     
                
        }
        .previewLayout(.sizeThatFits)
    }
}
