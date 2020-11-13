//
//  Logger.swift
//  Reportedly
//
//  Created by Mikey Pham on 11/13/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//


import Foundation
import NimbleExtension
import os.log

let log = Logger()

final class Logger {
    
    private let logger: OSLog
    
    init() {
        logger = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "no-bundle-id",
                       category: "Logger")
    }
    
    // MARK: - Logging
    
    /// Use to log items without any contextual infomation
    func info(_ items: Any...) {
        BuildConfiguration.performIfDebug { plainLog(items, type: .info) }
    }
    
    /// Use to log items with context
    func debug(file: StaticString = #file,
               function: StaticString = #function,
               line: Int32 = #line,
               dso: UnsafeRawPointer? = #dsohandle,
               _ items: Any...) {
        BuildConfiguration.performIfDebug { log(file, function, line, dso, items, type: .debug) }
    }
    
    func error(file: StaticString = #file,
               function: StaticString = #function,
               line: Int32 = #line,
               dso: UnsafeRawPointer? = #dsohandle,
               _ items: Any...) {
        BuildConfiguration.performIfDebug { log(file, function, line, dso, items, type: .error) }
    }
    
    func fault(file: StaticString = #file,
               function: StaticString = #function,
               line: Int32 = #line,
               dso: UnsafeRawPointer? = #dsohandle,
               _ items: Any...) {
        BuildConfiguration.performIfDebug { log(file, function, line, dso, items, type: .fault) }
    }
}

// MARK: - Private
    
extension Logger {
    
    private func filename(from file: StaticString) -> String {
        var filename = String(describing: file)
        if let index = filename.range(of: "/", options: .backwards)?.upperBound {
            filename = String(filename[index...])
        }
        if let index = filename.range(of: ".", options: .backwards)?.lowerBound {
            filename = String(filename[..<index])
        }
        return filename
    }
    
    private func plainFormat(_ items: [Any], _ type: OSLogType) -> String {
        let prefix: String
        switch type {
        case .debug:        prefix = "🍏"
        case .error:        prefix = "⚠️"
        case .fault:        prefix = "🚨"
        default:            prefix = "🍆"
        }
        let arguments = items
            .map { String(describing: $0) }
            .joined(separator: " ")
        return "> \(prefix) \(arguments)"
    }
    
    private func plainLog(_ items: [Any],
                          _ dso: UnsafeRawPointer? = #dsohandle,
                          type: OSLogType) {
        let message = plainFormat(items, type)
        os_log("%{public}@", dso: dso, log: logger, type: type, message)
    }
    
    private func format(_ file: StaticString = #file,
                        _ function: StaticString = #function,
                        _ line: Int32 = #line,
                        _ items: [Any],
                        _ type: OSLogType) -> String {
        return "\(filename(from: file)).\(function):\(line)\n"
            + plainFormat(items, type)
    }
    
    private func log(_ file: StaticString = #file,
                     _ function: StaticString = #function,
                     _ line: Int32 = #line,
                     _ dso: UnsafeRawPointer? = #dsohandle,
                     _ items: [Any],
                     type: OSLogType) {
        let message = format(file, function, line, items, type)
        os_log("%{public}@", dso: dso, log: logger, type: type, message)
    }
}
