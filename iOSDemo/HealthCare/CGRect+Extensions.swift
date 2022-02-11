//
//  CGRect+Extensions.swift
//  iOSDemo
//
//  Created by zhangwen on 2022/2/11.
//

import UIKit

extension CGRect {
    var x: CGFloat {
        get { origin.x }
        set { origin = CGPoint(x: newValue, y: origin.y) }
    }

    var y: CGFloat {
        get { origin.y }
        set { origin = CGPoint(x: origin.x, y: newValue) }
    }
}

extension CGRect {
    // 中心点+宽高
    init(center: CGPoint, width: CGFloat, height: CGFloat) {
        self = CGRect(x: center.x - width/2, y: center.y - height/2, width: width, height: height)
    }

    // 中心点移动
    func to(center: CGPoint) -> CGRect {
        CGRect(center: center, width: width, height: height)
    }

    // 中心点移动
    mutating func centerTo(_ center: CGPoint) {
        self = CGRect(center: center, width: width, height: height)
    }

//    mutating func trim(width: CGFloat, height: height) {
//        self =
//    }

}

extension CGPoint {
    mutating func trim(){

    }
}

