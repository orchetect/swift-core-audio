//
//  OSStatus+SwiftCoreAudioError.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

extension OSStatus /* a.k.a. Int32 */ {
    /// Throws if the `OSStatus` code returned by a Core Audio or Audio Toolkit method is `!= noErr`.
    /// If `self` equals `noErr` (`0`), this method returns without throwing.
    ///
    /// This method may be chained onto a method that returns an `OSStatus` value, in essence converting
    /// it to a throwing method. For example:
    ///
    /// ```swift
    /// try SomeNonThrowingMethodReturningOSStatus()
    ///     .throwingSwiftCoreAudioError()
    /// ```
    public func throwingSwiftCoreAudioError(
        message: String? = nil,
        file: String = #file,
        line: Int = #line
    ) throws(SwiftCoreAudioError) {
        guard let error = AudioOSStatusError(rawValue: self) else {
            return
        }
        
        try error.throwSwiftCoreAudioError(message: message, file: file, line: line)
    }
}
