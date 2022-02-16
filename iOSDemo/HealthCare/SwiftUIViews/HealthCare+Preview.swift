//
//  MarginView.swift
//  iOSDemo
//
//  Created by zw on 2022/2/1.
//

import SwiftUI

struct HealthCare: View {
    var body: some View {
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
            

            ZStack {
                DetectRegionView()
                    .frame(width: 100, height: 50, alignment: .topTrailing)
                    .offset(x: 40, y: 0)

                SubRegionView(CGRect(x: 20, y: 20, width: 50, height: 50), name: "书桌", widthText: "2m", heightText: "1m", isSelected: true)

            }
            .frame(width: 200, height: 200, alignment: .center)
            .background(Color(UIColor.green.withAlphaComponent(0.1)))


        }
    }
}


struct HealthCare_Previews: PreviewProvider {
    static var previews: some View {
        HealthCare()
            .previewLayout(.sizeThatFits)
    }
}
