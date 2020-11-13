//
//  UITextField+Extensions.swift
//  Reportedly
//
//  Created by Mikey Pham on 11/16/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import UIKit

extension UITextField {
    
    func addHorizontalPadding(withValue padding: CGFloat) {
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        leftViewMode = .always
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        rightViewMode = .always
    }
}
