//
//  SubRegionSettingsView.swift
//  iOSDemo
//
//  Created by zhangwen on 2022/2/15.
//

import SwiftUI


struct SubRegionTag: View {
    let title: String
    let isSelected: Bool
    var body: some View {
        if isSelected {
            Text(title)
                .padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
                .foregroundColor(Color(0x55C4BD))
                .font(.system(size: 14))
                .background(
                    Capsule().fill(Color(0xF2FCFB))
                )
                .overlay(Capsule().strokeBorder(Color(0x55C4BD)))
        }
        else {
            Text(title)
                .padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
                .foregroundColor(Color(0x666666))
                .font(.system(size: 14))
                .background(
                    Capsule().fill(Color(0xF8F8F8))
                )
        }
    }
}

struct SubRegionSettingsPage: View {
    @State var name: String = "排除区域1"
    @State var length: String = "2"
    @State var width: String = "2"
    @State var distanceToA: String = "2"
    @State var distanceToB: String = "2"

    var body: some View {
        VStack(alignment:.leading, spacing: 0) {

            TextField("", text: $name)
                .withNameCell(title: "名称")
            TextField("", text: $length)
                .withDistanceCell(title: "长度")
            TextField("", text: $width)
                .withDistanceCell(title: "宽度")
            TextField("", text: $distanceToA)
                .withDistanceCell(title: "墙A距离")
            TextField("", text: $distanceToB)
                .withDistanceCell(title: "墙B距离")
        }
    }
}

struct SubRegionSettingsView: View {
    @State private var selectedIndex: Int = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 0){
                Text("排除区域：")
                    .padding(.leading, 17)
                    .foregroundColor(Color(0x666666))
                    .font(.system(size: 14))
                Spacer()
                Button("新增") {

                }
                .foregroundColor(Color(0x666666))
                .font(.system(size: 14))
                .padding(.trailing, 10)

                Button("删除") {

                }
                .foregroundColor(.red)
                .font(.system(size: 14))
                .padding(.trailing, 17)
            }
            .frame(height: 44)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 10) {

                    SubRegionTag(title: "排除区域1", isSelected: false)
                    SubRegionTag(title: "排除区域1", isSelected: true)
                    SubRegionTag(title: "排除区域1", isSelected: false)
                    SubRegionTag(title: "排除区域1", isSelected: true)
                    SubRegionTag(title: "排除区域1", isSelected: false)
                    SubRegionTag(title: "排除区域1", isSelected: true)
                }
            }
            .padding(.horizontal, 17)

            iPages(selection: $selectedIndex) {
                SubRegionSettingsPage()
                SubRegionSettingsPage()
                SubRegionSettingsPage()
                SubRegionSettingsPage()
            }
            .hideDots(true)
            .frame(height:230, alignment: .top)
            .background(Color.red)

        }
    }
}

struct SubRegionSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SubRegionTag(title: "排除区域1", isSelected: false)
            SubRegionTag(title: "排除区域1", isSelected: true)

            SubRegionSettingsView()
        }

    }
}
