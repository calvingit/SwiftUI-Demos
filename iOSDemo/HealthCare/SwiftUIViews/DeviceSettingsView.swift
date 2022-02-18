//
//  DeviceSettingsView.swift
//  iOSDemo
//
//  Created by zhangwen on 2022/2/15.
//

import SwiftUI


let installTipsText = """
 安装提示：
     1、必须安装在距离地面1.5m，电源线朝下。
     2、监测范围：最大4m*4m，最小0.5m*0.5m。
     3、说明：排除区域内设备不进行检测。
"""



struct DeviceSettingsView: View {
    //@StateObject
    @State var name: String = "跌倒"
    @State var frontDistance: String = ""
    @State var leftDistance: String = "2"
    @State var floorDistance: String = "2"
    var body: some View {
        VStack(alignment:.leading, spacing: 0) {
            Line.infinity(.horizontal, color: Color(0xEEEEEE), lineWidth: 1)

            NameTextFieldCell(title: "设备名称", text: name, placeHolder: "请输入名称")
            DistanceTextfieldCell(title: "右侧距离", text: frontDistance, placeHolder: "哈哈")
            DistanceTextfieldCell(title: "边距离", text: leftDistance)
            DistanceTextfieldCell(title: "地面距离", text: frontDistance)

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
