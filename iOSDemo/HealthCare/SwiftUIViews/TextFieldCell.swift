//
//  TextFieldCell.swift
//  iOSDemo
//
//  Created by zhangwen on 2022/2/17.
//

import SwiftUI

private let cellfont = Font.system(size: 14)
private let cellTitleColor = Color(0x333333)
private let cellValueColor = Color(0x6A6A6A)

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

// 数字输入
struct TextFieldWithPlaceholder: View {
    let text: Binding<String>
    var placeHolder: String?
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        TextField("", text: text, onEditingChanged: { (changing) in
            print("Changing: \(changing)")
        }, onCommit: {
            print("Committed!")
        })
            .keyboardType(keyboardType)
            .placeHolder(Text(placeHolder ?? "")
                            .foregroundColor(cellValueColor.opacity(0.6))
                            .font(.system(size: 14)),
                         show: text.wrappedValue.isEmpty,
                         alignment: .trailing)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .multilineTextAlignment(.trailing)
            .foregroundColor(cellValueColor)
            .font(.system(size: 14))
    }
}

// 将任何View 变成 cell样式，添加底部直线
struct WrappedForCell: ViewModifier {
    let height: CGFloat
    let horizontalPadding: CGFloat

    init(height: CGFloat = 44, horizontalPadding: CGFloat = 17) {
        self.height = height
        self.horizontalPadding = horizontalPadding
    }
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            content
                .padding(.horizontal, horizontalPadding)
                .frame(height: height)
            // 直线
            Line.infinity(.horizontal, color: Color(0xF8F8F8), lineWidth: 1)
        }
    }
}


// 名称的cell
struct NameTextFieldCell: View {
    let title:String
    @State var text: String

    var placeHolder: String?
    var body: some View {
        HStack(spacing: 0) {
            Text(title)
                .cellTitleStyle()
                .padding(.trailing, 50)
            TextFieldWithPlaceholder(text: $text, placeHolder: placeHolder)
        }
        .modifier(WrappedForCell(height: 44, horizontalPadding: 17))
    }
}

// 距离的cell
struct DistanceTextfieldCell: View {
    let title:String
    @State var text: String

    var subTitle: String?
    var placeHolder: String?

    var body: some View {
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
            Spacer()
            TextFieldWithPlaceholder(text: $text, placeHolder: placeHolder, keyboardType: .decimalPad)
            Text(text.isEmpty ? "": "m")
                .foregroundColor(cellValueColor)
                .font(.system(size: 14))
            ChevronRightArrow()
                .padding(.leading, 8)
        }

        .modifier(WrappedForCell(height: 44, horizontalPadding: 17))

    }
}


struct TextFieldCell_Previews: PreviewProvider {

    struct TextFieldCellDemo: View {
        @State var name: String = ""
        @State var distance: String = ""
        var body: some View {
            VStack {
                NameTextFieldCell(title: "名称", text: name, placeHolder: "请输入名称")
                DistanceTextfieldCell(title: "左侧距离", text: distance, placeHolder: "请输入距离")
            }
        }
    }

    static var previews: some View {
        TextFieldCellDemo()
    }
}
