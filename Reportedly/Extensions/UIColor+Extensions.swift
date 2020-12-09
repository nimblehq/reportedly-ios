//
//  UIColor+Extension.swift
//  Reportedly
//
//  Created by Mikey Pham on 11/13/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import UIKit

extension UIColor {
    
    static var background: UIColor { ColorSystem.shared.backgroundColor }
    
    static var forms: UIColor { ColorSystem.shared.formsColor }
    
    static var overlay: UIColor { ColorSystem.shared.overlayColor }
    
    static var overlayLight: UIColor { ColorSystem.shared.overlayLightColor }
    
    static var primary: UIColor { ColorSystem.shared.primaryColor }
    
    static var textHighlighted: UIColor { ColorSystem.shared.textHighlightedColor }
    
    static var textPrimary: UIColor { ColorSystem.shared.textPrimaryColor }
    
    var hexString: String {
        guard let components = cgColor.components else { fatalError("Invalid Color") }
        let red = components[0]
        let green = components[1]
        let blue = components[2]
        return String(format: "%02X%02X%02X", (Int)(red * 255), (Int)(green * 255), (Int)(blue * 255))
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex: Int) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF
        )
    }
}
