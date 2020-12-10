//
//  String+Extensions.swift
//  Reportedly
//
//  Created by Mikey Pham on 11/13/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Foundation

extension String {
    
    // MARK: - Public Variables
    
    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: self)
    }
    var isValidURL: Bool {
        // It is a link if the match covers the whole string
        guard let match = (try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue))?.firstMatch(in: self, range: NSRange(location: 0, length: utf16.count)) else { return false }
        return match.range.length == utf16.count
    }
    func toDate(withFormat: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = withFormat
        dateFormatter.locale = Locale(identifier: LanguageSystem.shared.currentLanguage.locale.identifier)
        return dateFormatter.date(from: self) ?? Date(timeIntervalSince1970: 0)
    }
    var toJSONArray: [JSONDictionary] {
        guard !isEmpty, let data = data(using: .utf8) else { return [] }
        do {
            return try JSONSerialization.jsonObject(with: data) as? [JSONDictionary] ?? []
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    var toJSONDictionary: JSONDictionary? {
        guard !isEmpty, let data = data(using: .utf8) else { return nil }
        do {
            return try JSONSerialization.jsonObject(with: data) as? JSONDictionary
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    var toURL: URL? { URL(string: self) }

    // MARK: - Public Functions
    
    func appSecretKey() -> String {
        let appDelegateType = AppDelegate.self
        let objectType = NSObject.self
        let stringType = NSString.self
        let obfuscator = Obfuscator(withSalt: String(describing: appDelegateType) + String(describing: objectType) + String(describing: stringType))
        return obfuscator.reveal(key: [18, 5, 2, 50, 0, 21, 68, 70, 64, 16, 0, 45, 33, 54, 18, 30]) // Reveal the obfuscated secret key at run time
    }
}
