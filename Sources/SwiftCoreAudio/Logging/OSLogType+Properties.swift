//
//  OSLogType+Properties.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import os.log

// MARK: - OSLogType Extensions

extension OSLogType {
    var name: String? {
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
