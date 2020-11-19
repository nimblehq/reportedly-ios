//
//  LanguageSystem.swift
//  Reportedly
//
//  Created by Mikey Pham on 11/19/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Foundation

protocol LanguageSystemDelegate {
    
    var currentLanguage: LanguageSystem.Language { get }
    
    func switchLanguage()
}

final class LanguageSystem {
    
    static let shared = LanguageSystem()
    
    private let userDefault = UserDefaults.standard
    
    private(set) var currentLanguage: Language {
        didSet {
            userDefault.setValue([currentLanguage.locale.identifier], forKey: UserDefaultsKey.appleLanguage)
            NotificationCenter.default.post(name: PushNotification.languageDidChange, object: nil)
        }
    }
    
    init() {
        if let firstIdentifier = userDefault.stringArray(forKey: UserDefaultsKey.appleLanguage)?.first {
            currentLanguage = Language(identifier: firstIdentifier) ?? .english
        } else {
            if let deviceLanguage = Locale.preferredLanguages.first,
               deviceLanguage.contains(LanguageCode.th) {
                currentLanguage = .thai
            } else {
                currentLanguage = .english
            }
        }
    }
}

// MARK: - LanguageSystemProtocol

extension LanguageSystem: LanguageSystemDelegate {
    
    func switchLanguage() {
        switch currentLanguage {
        case .english:
            currentLanguage = .thai
        case .thai:
            currentLanguage = .english
        }
    }
}

// MARK: - LanguageSystem.Language
extension LanguageSystem {
    
    enum Language: CaseIterable {
        
        case thai
        case english
        
        init?(identifier: String) {
            guard let languageCode = Locale(identifier: identifier).languageCode,
                  let matchedLocale = Language.allCases.first(where: { $0.locale.languageCode == languageCode })
            else { return nil }
            self = matchedLocale
        }
        
        var locale: Locale {
            switch self {
            case .thai:
                return Locale(identifier: LanguageCode.th)
            case .english:
                return Locale(identifier: LanguageCode.en)
            }
        }
        
        var calendar: Calendar {
            switch self {
            case .thai:
                return Calendar(identifier: .buddhist)
            case .english:
                return Calendar(identifier: .gregorian)
            }
        }
        
        var path: String? { Bundle.main.path(forResource: resource, ofType: FileType.lproj) }
        
        /// This is the name of localization file.
        private var resource: String {
            switch self {
            case .thai:
                return LanguageCode.thTH
            case .english:
                return LanguageCode.en
            }
        }
    }
}
