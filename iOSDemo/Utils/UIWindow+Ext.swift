//
//  UIWindow+Ext.swift
//  iOSDemo
//
//  Created by zw on 2022/1/26.
//

import UIKit

extension UIWindow {
    
    static func getKeyWindow() -> UIWindow {
        if let window = UIApplication.shared.windows.first {
            return window
        }
        
        if let window =  UIApplication.shared.connectedScenes.compactMap({ $0 as? UIWindowScene
        }).first?.windows.first  {
            return window
        }
        
        return UIWindow(frame: UIScreen.main.bounds)
    }
    
    var topSafeAreaHeight: CGFloat {
        safeAreaLayoutGuide.layoutFrame.minY
    }
    
    var bottomSafeAreaHeight: CGFloat {
        frame.maxY - safeAreaLayoutGuide.layoutFrame.maxY
    }
}
