//
//  OSStatus+AudioOSStatusError.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import CoreAudio
import Foundation

extension OSStatus /* a.k.a. Int32 */ {
    /// Throws a new ``AudioOSStatusError`` instance if the `OSStatus` code returned by a Core Audio or
    /// Audio Toolkit method.
    /// If the value equals `noErr` (`0`), this method returns without throwing.
    ///
    /// This method may be chained onto a method that returns an `OSStatus` value in essence converting
    /// it to a throwing method. For example:
    ///
    /// ```swift
    /// try SomeNonThrowingMethodReturningOSStatus()
    ///     .throwingAudioOSStatusError()
    /// ```
    public func throwingAudioOSStatusError() throws(AudioOSStatusError) {
        guard let error = AudioOSStatusError(rawValue: self) else {
            return
        }
        throw error
    }
    
    /// Construct a new ``AudioOSStatusError`` instance from a raw `OSStatus` value returned by a Core Audio
    /// or Audio Toolkit method.
    /// This initializer only returns `nil` if the value equals `noErr` (`0`).
    ///
    /// This method may be chained onto a method that returns an `OSStatus` value.
    ///
    /// ```swift
    /// let statusError = SomeNonThrowingMethodReturningOSStatus()
    ///     .audioOSStatusError()
    ///
    /// if let statusError {
    ///     // handle error...
    /// }
    /// ```
    ///
    /// This method may also be chained to throw the ``AudioOSStatusError`` if it is non-nil. For example:
    ///
    /// ```swift
    /// try SomeNonThrowingMethodReturningOSStatus()
    ///     .audioOSStatusError()?
    ///     .throw() // throws only if error is non-nil
    /// ```
    ///
    /// Additionally, a similar method is available to throw the ``AudioOSStatusError`` wrapped in a new
    /// ``SwiftCoreAudioError`` instance if the OSStatus error is non-nil. For example:
    ///
    /// ```swift
    /// try SomeNonThrowingMethodReturningOSStatus()
    ///     .audioOSStatusError()?
    ///     .throwSwiftCoreAudioError() // throws only if error is non-nil
    /// ```
    public func audioOSStatusError() -> AudioOSStatusError? {
        AudioOSStatusError(rawValue: self)
    }
}
