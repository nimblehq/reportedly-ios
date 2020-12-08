//
//  Cryptor.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/8/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Foundation

class Cryptor {

    // MARK: - Public Functions
    func decrypt(encryptedText: String) -> String {
        guard encryptedText.count > 0,
            let encryptedData = NSData(base64Encoded: encryptedText, options: NSData.Base64DecodingOptions.init(rawValue: 0)),
            let decryptedData = encryptedData.performAES128Operation(type: .decrypt, key: String().appSecretKey()) else { return "" }
        return String(data: decryptedData as Data, encoding: .utf8) ?? ""
    }
}
