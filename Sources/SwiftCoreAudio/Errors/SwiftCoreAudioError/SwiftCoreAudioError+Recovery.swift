//
//  SwiftCoreAudioError+Recovery.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import CoreAudio
import Foundation

/// A wrapper for methods that return a value and may throw ``SwiftCoreAudioError``, allowing
/// conditional error recovery.
///
/// - Parameters:
///   - block: Auto-closure containing the throwing method call.
///   - fallback: Closure that is invoked only in the event that `block` throws an error. The
///     closure allows you to conditionally return a substitute/recovery value, or `nil` to rethrow
///     the error if no substitute value is appropriate.
/// - Throws: Rethrows the error thrown by `block` if both `block` throws an error and `nil` is
///   returned by the `fallback` closure.
/// - Returns: Returns the value returned by `block` if `block` does not throw an error, otherwise
///   returns the value returned by the `fallback` closure if it is non-`nil`.
public func withRecovery<T>(
    _ block: @autoclosure () throws(SwiftCoreAudioError) -> T,
    _ fallback: (_ osStatus: AudioOSStatus) -> T?
) throws(SwiftCoreAudioError) -> T {
    do throws(SwiftCoreAudioError) {
        return try block()
    } catch {
        // only attempt to recover OSStatus errors
        guard case let .osStatus(osStatusError, message: message) = error else { throw error }

        // it's possible to encounter an OSStatus we don't know about yet; just ignore it here
        // since it's unlikely that we will need/want to reason on it in this context.
        // this helper method is mostly intended for recovering from known OSStatus cases.
        guard let status = osStatusError.status else { throw error }

        // if a substitute/recovery value is returned (non-`nil`), return it without throwing
        guard let value = fallback(status) else {
            throw error
        }

        CoreAudioLogging.log(.error) {
            var logMessage = "Core Audio error: \(osStatusError)."
            if let message { logMessage += " (\(message))" }
            logMessage += " Recovering with substitute \(T.self) value: \(value)."
            return logMessage
        }

        return value
    }
}

/// A wrapper for methods that return a value and may throw ``SwiftCoreAudioError``, allowing
/// ``AudioOSStatus/unknownProperty`` error recovery by providing a default value.
public func withRecovery<T>(
    _ block: @autoclosure () throws(SwiftCoreAudioError) -> T,
    unknownPropertyDefault defaultValue: @autoclosure () -> T
) throws(SwiftCoreAudioError) -> T {
    try withRecovery(block()) { osStatus in
        if osStatus == .unknownProperty {
            defaultValue()
        } else {
            nil
        }
    }
}
