//
//  StringResource+Extensions.swift
//  Reportedly
//
//  Created by Mikey Pham on 11/19/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Rswift

extension StringResource {
    
    func localized() -> String {
        let currentLanguage = LanguageSystem.shared.currentLanguage
        guard let path = currentLanguage.path, let bundle = Bundle(path: path) else {
            return NSLocalizedString(key, comment: "")
        }
        return bundle.localizedString(forKey: key, value: key, table: tableName)
    }
    
    func localized(with arguments: CVarArg...) -> String {
        return String(format: localized(), locale: .current, arguments: arguments)
    }
}
