//
//  UIFont+Extensions.swift
//  Reportedly
//
//  Created by Mikey Pham on 11/16/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import UIKit

extension UIFont {
    
    enum FontSize: CGFloat {
        /**size = 38*/
        case xLarge = 38.0
        /**size = 32*/
        case large = 32.0
        /**size = 28*/
        case title = 28.0
        /**size = 24*/
        case headline = 24.0
        /**size = 20*/
        case medium = 20.0
        /**size = 16*/
        case regular = 16.0
        /**size = 15*/
        case small = 15.0
        /**size = 13*/
        case xSmall = 13.0
        /**size = 11*/
        case xxSmall = 11.0
        /**size = 8*/
        case xxxSmall = 8.0
    }
    
    static func appFont(ofSize size: FontSize) -> UIFont {
        return UIFont.systemFont(ofSize: size.rawValue)
    }
    
    static func appBoldFont(ofSize size: FontSize) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size.rawValue)
    }
}
