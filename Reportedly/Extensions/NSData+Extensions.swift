//
//  UIView.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/8/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import CommonCrypto
import UIKit

// MARK: - CCOperationType Enums
enum CCOperationType: Int {
    case encrypt = 0 // kCCEncrypt
    case decrypt = 1 // kCCDecrypt
}

extension NSData {

    // MARK: - Public Functions
    func performAES128Operation(type: CCOperationType, key: String) -> NSData? {
        var keyPtr = [CChar](repeating: 0, count: kCCKeySizeAES128 + 1)
        bzero(&keyPtr, keyPtr.count)
        guard !key.isEmpty, key.getCString(&keyPtr, maxLength: keyPtr.count, encoding: .utf8) else { return nil }

        let bufferSize = length + kCCBlockSizeAES128
        guard let buffer = malloc(bufferSize) else { return nil }

        var numBytesEncrypted = 0
        let cryptStatus = CCCrypt(CCOperation(type.rawValue), CCAlgorithm(kCCAlgorithmAES128), CCOptions(kCCOptionECBMode) | CCOptions(kCCOptionPKCS7Padding), keyPtr, kCCBlockSizeAES128, nil, bytes, length, buffer, bufferSize, &numBytesEncrypted)

        // bytesNoCopy will transfer ownership to the NSData object returned, so we don't need to explicitly call free here
        if cryptStatus == CCCryptorStatus(kCCSuccess) { return NSData(bytesNoCopy: buffer, length: numBytesEncrypted) }

        // If the operation failed, we never transferred memory ownership, so free the buffer
        free(buffer)

        return nil
    }
}
