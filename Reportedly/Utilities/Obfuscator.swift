//
//  Obfuscator.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/8/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import UIKit

class Obfuscator {

    // MARK: - Private Variables
    private let _salt: String // The salt used to obfuscate and reveal the string.

    // MARK: - Init Functions
    init() {
        _salt = String(describing: AppDelegate.self) + String(describing: NSObject.self)
    }

    init(withSalt salt: String) {
        self._salt = salt
    }

    // MARK: - Public Functions
    /**
     This method obfuscates the string passed in using the salt
     that was used when the Obfuscator was initialized.
     - parameter string: the string to obfuscate
     - returns: the obfuscated string in a byte array
     */
    func bytesByObfuscatingString(string: String) -> [UInt8] {
        let cipher = [UInt8](_salt.utf8)
        return [UInt8](string.utf8).enumerated().map { $0.element ^ cipher[$0.offset % cipher.count] }
    }

    /**
     This method reveals the original string from the obfuscated
     byte array passed in. The salt must be the same as the one
     used to encrypt it in the first place.
     - parameter key: the byte array to reveal
     - returns: the original string
     */
    func reveal(key: [UInt8]) -> String {
        let cipher = [UInt8](_salt.utf8)
        return String(bytes: key.enumerated().map { $0.element ^ cipher[$0.offset % cipher.count] }, encoding: .utf8) ?? ""
    }
}
