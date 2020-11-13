//
//  BuildConfiguration.swift
//  Reportedly
//
//  Created by Mikey Pham on 11/13/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

enum BuildConfiguration {
    
    static func based<T>(debug: T, release: T) -> T {
        #if DEBUG
        return debug
        #elseif RELEASE
        return release
        #endif
    }
    
    static func performIfDebug(_ callback: () -> Void) {
        #if DEBUG
        callback()
        #endif
    }
    
    static func performIfRelease(_ callback: () -> Void) {
        #if RELEASE
        callback()
        #endif
    }
}
