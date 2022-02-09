//
//  Helper.swift
//  A small collection of quick helpers to avoid repeating the same old code.
//
//  Created by Paul Hudson on 23/06/2019.
//  Copyright © 2019 Hacking with Swift. All rights reserved.
//

import UIKit

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}


// 计算文本的大小
func sizeWithText(text: String, font: UIFont, size: CGSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)) -> CGRect {
    let attributes = [NSAttributedString.Key.font: font]

    return  text.boundingRect(with: size,
                              options: .usesLineFragmentOrigin,
                              attributes: attributes, context: nil)
}
