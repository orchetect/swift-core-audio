//
//  Logging.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import os.log

enum Logging {
    /// Main log method.
    static func log(_ logLevel: OSLogType = .default, _ message: String) {
        if #available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *) {
            _logger.log(level: logLevel, "\(message)")
        } else {
            _printLog(logLevel: logLevel, message: message)
        }
    }
}

// MARK: - Logger Backend

extension Logging {
    @available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *)
    private static let _logger = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? "com.orchetect.SwiftCoreAudio",
        category: "Core Audio"
    )
}

// MARK: - Print Backend

extension Logging {
    private static func _printLog(logLevel: OSLogType, message: String) {
        var output = ""
        if let name = logLevel.name { output += "\(name): "}
        output += message
        
        print(output)
    }
}

// MARK: - OSLogType Extensions

extension OSLogType {
    fileprivate var name: String? {
        switch self {
        case .debug: "DEBUG"
        case .default: nil
        case .error: "ERROR"
        case .fault: "FAULT"
        case .info: "INFO"
        default: nil
        }
    }
}
