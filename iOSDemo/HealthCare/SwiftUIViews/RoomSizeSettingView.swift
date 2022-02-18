//
//  RoomSizeSettingView.swift
//  iOSDemo
//
//  Created by zhangwen on 2022/2/16.
//

import SwiftUI

struct ClearView: View {
    var body: some View {
        Spacer()
    }
}


// 房间大小
struct RoomSize {

    let width: CGFloat // 长度m
    let height: CGFloat // 宽度m


    // 水平最大宽度
    let maxWidth: CGFloat = UIScreen.main.bounds.width - 140

    // 水平
    var ptWidth: CGFloat {
        if width >= height  {
            return maxWidth
        }
        else {
            return ptHeight * width / height
        }
    }

    // 垂直
    var ptHeight: CGFloat {
        if width >= height {
            return ptWidth * height / width
        }
        else {
            return maxWidth
        }
    }
}

struct RoomBackground: ViewModifier {

    let roomSize: RoomSize
    let widthString: String
    let heightString: String

    let marginWidth: CGFloat = 8.0

    func body(content: Content) -> some View {
        HStack(alignment: .top, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                OuterBorder("A", color: .init(0xC6AD9D))
                    .frame(width: roomSize.ptWidth + marginWidth * 2, height: marginWidth)

                HStack(alignment: .center,spacing: 0) {
                    OuterBorder("B")
                        .frame(width: marginWidth, height: roomSize.ptHeight)

                    content
                        .frame(width: roomSize.ptWidth, height: roomSize.ptHeight)

                    OuterBorder("D")
                        .frame(width: marginWidth, height: roomSize.ptHeight)


                }

                OuterBorder("C")
                    .frame(width: roomSize.ptWidth + marginWidth * 2, height: marginWidth)

                MarginView(.horizontal, text: widthString)
                    .frame(width: roomSize.ptWidth, height: 20, alignment: .topLeading)
                    .padding(.top, 10)
                    .padding(.horizontal, marginWidth)
            }
            .layoutPriority(1)

            MarginView(.vertical, text: heightString)
                .frame(height: roomSize.ptHeight)
                .padding(.top, marginWidth)
                .padding(.leading, 5)
                .layoutPriority(0)
        }
        /// 水平需要偏移MarginView的width，否则中间部分不居中
        .padding(.leading, 5 + heightString.sizeOf(.systemFont(ofSize: 10)).width)
    }

}


struct RoomSizeSettingView: View {
    // 房间长度
    let roomWidth: CGFloat = 180
    // 房间宽度
    let roomHeight: CGFloat = 140
    // 墙边框厚度
    let marginWidth: CGFloat = 8.0

    @State private var width: String = ""
    @State private var height: String = ""

    var body: some View {

        VStack(alignment: .center, spacing: 0) {
            GridBackground()
                .modifier(RoomBackground(roomSize: RoomSize(width: 5, height: 2.2), widthString: "长度", heightString: "宽度"))
                .padding(.top, 120)

            ClearView().frame(height: 50)

            DistanceTextfieldCell(title: "长度", text: width, placeHolder: "请输入距离")
            DistanceTextfieldCell(title: "宽度", text: height, placeHolder: "请输入距离")

            //Spacer()
            //.padding(EdgeInsets(top: 80, leading: 60, bottom: 0, trailing: 0))
            Button {

            } label: {
                Capsule()
                    .fill(
                        LinearGradient(colors: [Color(0x55B3D6),
                                                Color(0x58DDA1)],
                                       startPoint: UnitPoint(x: 0, y: 1),
                                       endPoint: UnitPoint(x: 1, y: 1)
                                      )
                    )
                    .overlay(
                        Text("下一步")
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                    )
                    .frame(height: 46)
                    .padding(.horizontal, 20)
                    .padding(.top, 50)

            }
            Spacer()
        }
        .background(Color.white)
        .onTapGesture {
            UIApplication.shared.windows.forEach {
                $0.endEditing(true)
            }
        }
    }

    func nextAction() {
        print("\(width), \(height)")
    }
}

struct RoomSizeSettingView_Previews: PreviewProvider {
    static var previews: some View {
        RoomSizeSettingView()
    }
}
