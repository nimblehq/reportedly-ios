//
//  Thread+Extensions.swift
//  Reportedly
//
//  Created by Minh Pham on 20/11/2020.
//

import Foundation

extension Thread {
    
    static func executeOnMainThread(_ execution: @escaping EmptyCallback) {
        guard !Thread.isMainThread else { return execution() }
        DispatchQueue.main.async { execution() }
    }
}
