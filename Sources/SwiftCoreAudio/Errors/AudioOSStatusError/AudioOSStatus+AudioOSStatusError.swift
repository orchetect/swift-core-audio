//
//  AudioOSStatus+AudioOSStatusError.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import CoreAudio
import Foundation

extension AudioOSStatus {
    /// Throws a new ``AudioOSStatusError`` containing the `OSStatus` if `self == .noError`.
    /// Otherwise, this method returns without throwing.
    public func `throw`() throws(AudioOSStatusError) {
        guard let error = AudioOSStatusError(status: self) else {
            return
        }
        throw error
    }

    /// Construct a new ``AudioOSStatusError`` instance from an ``AudioOSStatus`` value.
    /// This method only returns `nil` if `self == .noError`.
    public func error() -> AudioOSStatusError? {
        AudioOSStatusError(status: self)
    }
}
