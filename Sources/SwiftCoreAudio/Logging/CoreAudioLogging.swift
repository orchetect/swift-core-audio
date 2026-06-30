//
//  CoreAudioLogging.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import os.log

/// Global singleton for configuring SwiftCoreAudio debug logging.
public enum CoreAudioLogging {
    /// Using NSLock (instead of Mutex or an actor) as it's backwards compatible and avoids async/await friction.
    private static let lock = NSLock()

    private static var logClosure: (@Sendable (_ logLevel: OSLogType, _ message: String) -> Void)? {
        get { lock.withLock { _logClosure } }
        set { lock.withLock { _logClosure = newValue } }
    }

    nonisolated(unsafe)
    private static var _logClosure: (@Sendable (_ logLevel: OSLogType, _ message: String) -> Void)?

    /// Once bootstrapped, determines whether recovery errors are logged.
    static var isRecoveryErrorsEnabled: Bool {
        get { lock.withLock { _isRecoveryErrorsEnabled } }
        set { lock.withLock { _isRecoveryErrorsEnabled = newValue } }
    }

    nonisolated(unsafe)
    private static var _isRecoveryErrorsEnabled: Bool = true
}

// MARK: - Bootstrap

extension CoreAudioLogging {
    /// Enable SwiftCoreAudio logging using the default logging backend.
    public static func bootstrap(
        isRecoveryErrorsEnabled: Bool = true
    ) {
        self.isRecoveryErrorsEnabled = isRecoveryErrorsEnabled

        logClosure = { logLevel, message in
            if #available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *) {
                defaultLogger.log(level: logLevel, "\(message)")
            } else {
                defaultPrintLog(logLevel: logLevel, message: message)
            }
        }
    }

    /// Enable SwiftCoreAudio logging using a custom logging backend.
    nonisolated
    public static func bootstrap(
        isRecoveryErrorsEnabled: Bool = true,
        _ logger: (@Sendable (_ logLevel: OSLogType, _ message: String) -> Void)?
    ) {
        self.isRecoveryErrorsEnabled = isRecoveryErrorsEnabled

        logClosure = logger
    }
}

// MARK: - Internal Log Method

extension CoreAudioLogging {
    /// Log a message.
    static func log(_ logLevel: OSLogType = .default, _ message: String) {
        logClosure?(logLevel, message)
    }

    /// Log a message.
    /// The closure is only called if logging has been bootstrapped.
    /// This allows skipping evaluation of logic to assemble a log message when not necessary.
    static func log(_ logLevel: OSLogType = .default, _ message: () -> String) {
        logClosure?(logLevel, message())
    }
}

// MARK: - Default Logger Backend

extension CoreAudioLogging {
    @available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *)
    private static let defaultLogger = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? "com.orchetect.SwiftCoreAudio",
        category: "Core Audio"
    )

    private static func defaultPrintLog(logLevel: OSLogType, message: String) {
        var output = ""
        if let name = logLevel.name { output += "\(name): " }
        output += message

        print(output)
    }
}
