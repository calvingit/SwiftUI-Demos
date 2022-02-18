//
//  PlaceHolder.swift
//  iOSDemo
//
//  Created by zhangwen on 2022/2/17.
//

import SwiftUI

struct PlaceHolder<T: View>: ViewModifier {
    let placeHolder: T
    let show: Bool
    let alignment: HorizontalAlignment

    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if show {
                HStack(alignment: .center){
                    if alignment == .trailing {
                        Spacer()
                    }
                    placeHolder
                    if alignment == .leading {
                        Spacer()
                    }
                }
            }
            content
        }
    }
}

extension View {
    func placeHolder<T:View>(_ holder: T, show: Bool, alignment:HorizontalAlignment = .leading) -> some View {
        self.modifier(PlaceHolder(placeHolder:holder, show: show, alignment:alignment))
    }
}


#if DEBUG
struct PlaceHolder_Previews: PreviewProvider {
    struct PlaceHolderDemo: View {
        @State var text: String = "sfasf"
        var body: some View {
            TextField("", text: $text, onEditingChanged: { (changing) in
                print("Changing: \(changing)")
            }, onCommit: {
                print("Committed!")
            })
                .placeHolder(Text("Your placeholder").foregroundColor(.green), show: text.isEmpty)
        }
    }

    static var previews: some View {
        PlaceHolderDemo()
            .frame(height: 44)
            .background(Color.red)
            .clipShape(Capsule())
            .padding(.horizontal, 20)
    }
}
#endif
