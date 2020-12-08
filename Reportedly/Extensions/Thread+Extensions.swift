//
//  Thread+Extensions.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/8/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Foundation

extension Thread {
    
    static func executeOnMainThread(_ execution: @escaping EmptyCompletion) {
        guard !Thread.isMainThread else { return execution() }
        DispatchQueue.main.async { execution() }
    }
}
