//
//  URLOpener.swift
//  Reportedly
//
//  Created by Mikey Pham on 11/13/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import UIKit

protocol URLOpener: AnyObject {
    
    func open(
        _ url: URL,
        options: [UIApplication.OpenExternalURLOptionsKey: Any],
        completionHandler completion: Completion<Bool>?
    )
    
    func canOpenURL(_ url: URL) -> Bool
}

extension URLOpener {
    
    func open(_ url: URL) {
        open(url, options: [:], completionHandler: nil)
    }
    
    func safelyOpen(_ url: URL) {
        if canOpenURL(url) {
            open(url)
        } else {
            log.error("cannot open url", url)
        }
    }
}

extension UIApplication: URLOpener {}
