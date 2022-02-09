//
//  Then.swift
//  iOSDemo
//
//  Created by zw on 2022/1/26.
//

import Foundation

protocol Then { }

extension Then where Self: AnyObject {
    
    /// Makes it available to set properties with closures just after initializing.
    ///
    ///     let label = UILabel().then {
    ///       $0.textAlignment = .center
    ///       $0.textColor = UIColor.black
    ///       $0.text = "Hello, World!"
    ///     }
    func then(_ block: (Self) throws -> Void) rethrows -> Self {
        try block(self)
        return self
    }
    
}
