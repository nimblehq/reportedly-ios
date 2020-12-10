//
//  Date+Extensions.swift
//  Reportedly
//
//  Created by Minh Pham on 10/12/2020.
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
