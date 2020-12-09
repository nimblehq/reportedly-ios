//
//  ColorSystem.swift
//  Reportedly
//
//  Created by Mikey Pham on 11/13/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import UIKit

public class ColorSystem {
    
    enum ColorTheme: String {
        case light
        case dark
    }
    
    static let colorThemeDidChangeNotification = Notification.Name("colorThemeDidChangeNotification")
    static let shared = ColorSystem(userDefaults: .standard)
    static private let COLOR_THEME_KEY = "COLOR_THEME_KEY"
    
    private let userDefaults: UserDefaults
    private(set) var colorTheme: ColorTheme {
        didSet {
            let transition = CATransition()
            transition.type = .fade
            transition.duration = 0.2
            UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.layer.add(transition, forKey: "transition")
            
            updateColors(colorTheme: colorTheme)
            userDefaults.set(colorTheme, forKey: ColorSystem.COLOR_THEME_KEY)
            NotificationCenter.default.post(name: ColorSystem.colorThemeDidChangeNotification, object: nil)
        }
    }
    
    private(set) var backgroundColor: UIColor!
    private(set) var formsColor: UIColor!
    private(set) var overlayColor: UIColor!
    private(set) var overlayLightColor: UIColor!
    private(set) var primaryColor: UIColor!
    private(set) var textPrimaryColor: UIColor!
    private(set) var textHighlightedColor: UIColor!
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
        // Find last set ColorTheme in userDefault or set it for the first time
        colorTheme = (userDefaults.object(forKey: ColorSystem.COLOR_THEME_KEY) as? ColorTheme) ?? .dark
        updateColors(colorTheme: colorTheme)
    }
    
    func switchColorTheme() {
        switch colorTheme {
        case .light:    colorTheme = .dark
        case .dark:     colorTheme = .light
        }
    }
    
    private func updateColors(colorTheme: ColorTheme) {
        primaryColor = UIColor(hex: 0xFFFFFF)
        switch colorTheme {
        case .dark: // TODO: To be updated, for now it should be the same with light mode
            backgroundColor = UIColor(hex: 0x999999)
            formsColor = UIColor(hex: 0xFFFFFF).withAlphaComponent(0.2)
            overlayColor = UIColor(hex: 0x000000).withAlphaComponent(0.75)
            overlayLightColor = UIColor(hex: 0x000000).withAlphaComponent(0.2)
            textHighlightedColor = UIColor(hex: 0x007AFF)
            textPrimaryColor = UIColor(hex: 0xFFFFFF)
        case .light:
            backgroundColor = UIColor(hex: 0x999999)
            formsColor = UIColor(hex: 0xFFFFFF).withAlphaComponent(0.2)
            overlayColor = UIColor(hex: 0x000000).withAlphaComponent(0.75)
            overlayLightColor = UIColor(hex: 0x000000).withAlphaComponent(0.2)
            textHighlightedColor = UIColor(hex: 0x007AFF)
            textPrimaryColor = UIColor(hex: 0xFFFFFF)
        }
    }
}
