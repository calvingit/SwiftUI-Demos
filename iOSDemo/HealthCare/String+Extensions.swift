//
//  String+Extensions.swift
//  iOSDemo
//
//  Created by zhangwen on 2022/2/10.
//

import UIKit

extension String {
    // 计算文本的大小
    func sizeOf(_ font: UIFont, size: CGSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)) -> CGRect {
        let attributes = [NSAttributedString.Key.font: font]
        
        return  NSString(string: self).boundingRect(with: size,
                                                    options: .usesLineFragmentOrigin,
                                                    attributes: attributes, context: nil)
    }
}
