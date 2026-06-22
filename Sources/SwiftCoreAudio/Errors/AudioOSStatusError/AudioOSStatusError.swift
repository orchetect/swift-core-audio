//
//  AudioOSStatusError.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import CoreAudio
import Foundation

/// Type-safe descriptive wrapper for `OSStatus` errors returned by Core Audio and Audio Toolkit methods.
public struct AudioOSStatusError: RawRepresentable {
    @inline(__always) nonisolated
    public let rawValue: OSStatus

    /// Construct from a raw `OSStatus` value.
    ///
    /// This initializer only returns `nil` if the value is equal to the `OSStatus` `noErr` constant (value of `0`).
    /// As such, it should not be possible for an error type to be constructed from a non-error `OSStatus` value.
    @inline(__always)
    nonisolated
    public init?(rawValue: OSStatus) {
        guard rawValue != noErr else { return nil }
        self.rawValue = rawValue
    }

    /// Construct from an ``AudioOSStatus`` instance.
    ///
    /// This constructor only returns `nil` if the status is ``AudioOSStatus/noError`` (the `OSStatus` `noErr` constant).
    ///
    /// ``AudioOSStatus`` is designed to 1:1 correspond to `OSStatus` status values, but the statuses include a `noErr`
    /// constant. This constant is not actually an error, but rather represents the absence of an error.
    /// As such, it should not be possible for an error type to be constructed from a non-error `OSStatus` value.
    @inline(__always)
    nonisolated
    public init?(status: AudioOSStatus) {
        guard status != .noError else { return nil }
        rawValue = status.rawValue
    }

    /// Internal:
    /// Construct from an ``OSStatus`` instance without checking for `noErr`.
    @inline(__always)
    nonisolated
    init(unsafe rawValue: OSStatus) {
        self.rawValue = rawValue
    }

    /// Internal:
    /// Construct from an ``AudioOSStatus`` instance without checking for `noErr`.
    @inline(__always)
    nonisolated
    init(unsafe status: AudioOSStatus) {
        rawValue = status.rawValue
    }
}

extension AudioOSStatusError: Equatable { }

extension AudioOSStatusError: Hashable { }

extension AudioOSStatusError: Sendable { }

extension AudioOSStatusError: LocalizedError {
    public var errorDescription: String? {
        status?.description
            ?? "Unknown OSStatus error code: \(rawValue)"
    }
}

extension AudioOSStatusError: CustomStringConvertible {
    public var description: String {
        localizedDescription
    }
}

extension AudioOSStatusError: CustomDebugStringConvertible {
    public var debugDescription: String {
        localizedDescription
    }
}

// MARK: - Properties

extension AudioOSStatusError {
    /// Returns the strongly-typed `AudioOSStatus` case that corresponds to the `OSStatus` code.
    ///
    /// If the code is `noErr` (`0`) or an unrecognized code, this method returns `nil`.
    ///
    /// If `nil` is returned, you may inspect the raw status value by reading the ``rawValue`` property.
    @inline(__always)
    nonisolated
    public var status: AudioOSStatus? {
        AudioOSStatus(rawValue: rawValue)
    }
}

// MARK: - Methods

extension AudioOSStatusError {
    /// Convenience method that throws `self`.
    ///
    /// This allows conditional throwing after initialization. For example:
    ///
    /// ```swift
    /// try SomeNonThrowingMethodReturningOSStatus()
    ///     .audioOSStatusError()?
    ///     .throw() // throws only if error is non-nil
    /// ```
    public func `throw`() throws(AudioOSStatusError) {
        throw self
    }
}
