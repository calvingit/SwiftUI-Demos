//
//  DeviceSettingsView.swift
//  iOSDemo
//
//  Created by zhangwen on 2022/2/15.
//

import SwiftUI

private let cellfont = Font.system(size: 14)
private let cellTitleColor = Color(0x333333)
private let cellValueColor = Color(0x6A6A6A)


let installTipsText = """
 安装提示：
     1、必须安装在距离地面1.5m，电源线朝下。
     2、监测范围：最大4m*4m，最小0.5m*0.5m。
     3、说明：排除区域内设备不进行检测。
"""

// cell标题样式
struct CellTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(cellTitleColor)
            .font(cellfont)
    }
}

extension View {
    func cellTitleStyle() -> some View {
        modifier(CellTitle())
    }
}

// 输入框样式
struct CellInput: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width:.infinity)
            .padding(.trailing, 18)
            .foregroundColor(cellTitleColor)
            .font(.system(size: 14))
    }
}

extension View {
    func cellInputStyle() -> some View {
        modifier(CellInput())
    }
}

// 名称的cell
struct NameTextFieldCell: ViewModifier {
    let title:String

    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text(title)
                    .cellTitleStyle()
                    .padding(.leading, 17)
                    .padding(.trailing, 50)
                content
                    .frame(width:.infinity)
                    .padding(.trailing, 18)
                    .foregroundColor(cellTitleColor)
                    .font(.system(size: 14))
            }
            .frame(height: 44)

            Line.infinity(.horizontal, color: Color(0xF8F8F8), lineWidth: 1)
        }
    }
}

extension View {
    func withNameCell(title: String) -> some View {
        modifier(NameTextFieldCell(title: title))
    }
}

// 距离的cell
struct DistanceTextfieldCell: ViewModifier {
    let title:String
    let subTitle: String?

    func body(content: Content) -> some View {

        VStack(spacing: 0) {
            HStack(spacing: 0) {
                VStack(alignment:.leading, spacing: 3) {
                    Text(title)
                        .cellTitleStyle()

                    if let subTitle = subTitle {
                        Text(subTitle)
                            .font(.system(size: 10))
                            .foregroundColor(cellValueColor)
                    }
                }
                .padding(.leading, 17)

                content
                    .frame(width: .infinity, alignment: .trailing)
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(cellValueColor)
                    .font(.system(size: 14))
                Text("m")
                    .foregroundColor(cellValueColor)
                    .font(.system(size: 14))
                ChevronRightArrow()
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 18))
            }
            .frame(height: 44)

            Line.infinity(.horizontal, color: Color(0xF8F8F8), lineWidth: 1)
        }
    }
}

extension View {
    func withDistanceCell(title: String, subTitle: String? = nil) -> some View {
        modifier(DistanceTextfieldCell(title: title, subTitle: subTitle))
    }
}

struct DeviceSettingsView: View {
    //@StateObject
    @State var name: String = "跌倒"
    @State var frontDistance: String = "2"
    @State var leftDistance: String = "2"
    @State var floorDistance: String = "2"
    var body: some View {
        VStack(alignment:.leading, spacing: 0) {
            Line.infinity(.horizontal, color: Color(0xEEEEEE), lineWidth: 1)
            TextField("", text: $name)
                .withNameCell(title: "设备名称")
            TextField("", text: $frontDistance)
                .withDistanceCell(title: "左边距离")
            TextField("", text: $leftDistance)
                .withDistanceCell(title: "左边距离")
            TextField("", text: $floorDistance)
                .withDistanceCell(title: "地面距离", subTitle: "（范围2.3-3m之间）")
            HStack(alignment:.center) {
                Text(installTipsText)
                    .font(.system(size: 12))
                    .foregroundColor(Color(0x565454))
                    .padding(EdgeInsets(top: 10, leading: 17, bottom: 10, trailing: 10))
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width)
            .background(Color(0xF9F9F9))

        }
    }
}

struct DeviceSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceSettingsView()
    }
}
