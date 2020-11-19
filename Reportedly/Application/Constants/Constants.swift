//
//  Constants.swift
//  Reportedly
//
//  Created by Mikey Pham on 11/13/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Foundation

// MARK: - General Enums Constants

enum FileType {
    static let lproj = "lproj"
}

enum LanguageCode {
    static let th = "th"
    static let thTH = "th-TH"
    static let en = "en"
}

enum PushNotification {
    static let languageDidChange = Notification.Name("LanguageSystem.languagedidChangeNotification")
}

enum UserDefaultsKey {
    static let appleLanguage = "AppleLanguage"
}

