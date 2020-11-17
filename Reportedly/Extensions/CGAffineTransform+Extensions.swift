//
//  CGAffineTransform+Extensions.swift
//  Reportedly
//
//  Created by Mikey Pham on 11/17/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import CoreGraphics

extension CGAffineTransform {

    static func scale(_ value: CGFloat) -> CGAffineTransform {
        return CGAffineTransform(scaleX: value, y: value)
    }

    static func scale(x: CGFloat = 1.0, y: CGFloat = 1.0) -> CGAffineTransform {
        return CGAffineTransform(scaleX: x, y: y)
    }

    static func translation(x: CGFloat = 0.0, y: CGFloat = 0.0) -> CGAffineTransform {
        return CGAffineTransform(translationX: x, y: y)
    }

    static func rotation(_ angle: CGFloat) -> CGAffineTransform {
        return CGAffineTransform(rotationAngle: angle)
    }
}
