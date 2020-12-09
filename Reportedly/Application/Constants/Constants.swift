//
//  Constants.swift
//  Reportedly
//
//  Created by Mikey Pham on 11/13/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Foundation

// MARK: - General Enums Constants

enum DateFormat {
    static let dd_MM_yyyy = "dd MM yyyy"
    static let dd_MMM = "dd MMM"
    static let dd_MMM_yyyy_hh_mm_a = "dd MMM yyyy, hh:mm a"
    static let dd_MMMM_yyyy = "dd MMMM yyyy"
    static let ddlMMlyyyy = "dd/MM/yyyy"
    static let MMM_d = "MMM d"
    static let MMM_d_YYYY = "MMM, d YYYY"
    static let MMMM_yyyy = "MMMM yyyy"
    static let EEEE_MMMM_dd_YYYY = "EEEE, MMMM dd YYYY"
    static let EE = "EE"
    static let hh_mm_a = "hh:mm a"
    static let hh_mm = "HH:mm"
    static let yyyy_MM_dd_T_HH_mm_ss = "yyyy-MM-dd'T'HH:mm:ss"
    static let yyyy_MM_DD_T_hh_mm_ssZ = "yyyy-MM-DD'T'hh:mm:ssZ"
    static let yyyy_MM_dd_T_HH_mm_ss_SSSZ = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
}

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
