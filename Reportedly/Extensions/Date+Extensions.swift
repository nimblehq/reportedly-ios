//
//  Date+Extensions.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/11/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Foundation

extension Date {
    
    func toString(withFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = withFormat
        dateFormatter.locale = Locale(identifier: LanguageSystem.shared.currentLanguage.locale.identifier)
        return dateFormatter.string(from: self)
    }
}
