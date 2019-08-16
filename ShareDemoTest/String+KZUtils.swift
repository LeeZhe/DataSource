//
//  String+KZUtils.swift
//  ShareDemoTest
//
//  Created by KiddieBao on 2019/8/15.
//  Copyright © 2019 Kiddie. All rights reserved.
//

import Foundation
extension String {
    var isInt : Bool {
        let digits = CharacterSet.decimalDigits
        if let x = unicodeScalars.first {
            return digits.contains(x)
        }
        return false
    }
    
    /// 是否是运算符
    var isPriority : Bool {
        let priority_list = ["+", "-", "*", "/"];
        return priority_list.contains(self)
    }
}
