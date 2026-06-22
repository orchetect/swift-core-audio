//
//  OSStatus+AudioOSStatus.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import CoreAudio
import Foundation

extension OSStatus /* a.k.a. Int32 */ {
    /// Returns a new ``AudioOSStatus`` instance constructed from `self`
    ///
    /// This assumes `self` is an `OSStatus` code returned by a Core Audio or Audio Toolkit method.
    public func audioOSStatus() -> AudioOSStatus? {
        AudioOSStatus(rawValue: self)
    }
}
