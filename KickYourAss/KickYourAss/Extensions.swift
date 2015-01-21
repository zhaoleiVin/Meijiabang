//
//  Extensions.swift
//  KickYourAss
//
//  Created by eagle on 15/1/21.
//  Copyright (c) 2015年 Li Chaoyi. All rights reserved.
//

import Foundation

let screenWidth = UIScreen.mainScreen().bounds.size.width

extension UIColor {
    /// 主题粉红色
    class func themeRedColor() -> UIColor {
        return UIColor(red: 250.0 / 255.0, green: 100.0 / 255.0, blue: 111.0 / 255.0, alpha: 1.0)
    }
    
    /// 主题橘黄
    class func themeOrangeColor() -> UIColor {
        return UIColor(red: 251.0 / 255.0, green: 164.0 / 255.0, blue: 98.0 / 255.0, alpha: 1.0)
    }
    
}

extension UIViewController {
    func alert(message: String) {
        let alertView = UIAlertView(title: nil, message: message, delegate: nil, cancelButtonTitle: nil)
        alertView.show()
    }
}

extension Dictionary {
    /**
    扩展可变字典
    
    :param: content 要扩充的内容
    */
    mutating func extend(content: Dictionary) {
        for (key, value) in content {
            self.updateValue(value, forKey: key)
        }
    }
}
