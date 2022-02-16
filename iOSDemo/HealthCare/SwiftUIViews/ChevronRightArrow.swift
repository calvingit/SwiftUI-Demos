//
//  ChevronRightArrow.swift
//  iOSDemo
//
//  Created by zhangwen on 2022/2/15.
//

import SwiftUI

// 向右的箭头">"
struct ChevronRightArrow: View {
    var body: some View {
        Image(systemName:"chevron.right")
            .resizable()
            .foregroundColor(Color(0xCCCCCC))
            .frame(width: 5, height: 9)
    }
}

struct ChevronRightArrow_Previews: PreviewProvider {
    static var previews: some View {
        ChevronRightArrow()
    }
}
