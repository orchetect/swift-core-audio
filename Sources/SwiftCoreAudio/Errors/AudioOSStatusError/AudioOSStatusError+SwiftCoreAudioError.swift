//
//  AudioOSStatusError+SwiftCoreAudioError.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

extension AudioOSStatusError {
    /// Throws the `OSStatus` error wrapped in a new ``SwiftCoreAudioError`` instance.
    public func throwSwiftCoreAudioError(
        message: String? = nil,
        file: String = #file,
        line: Int = #line
    ) throws(SwiftCoreAudioError) {
        let metadata = "(\(file):\(line))"

        let errorMessage = if let message {
            "\(message) \(metadata)"
        } else {
            metadata
        }

        throw .osStatus(self, message: errorMessage)
    }
}
