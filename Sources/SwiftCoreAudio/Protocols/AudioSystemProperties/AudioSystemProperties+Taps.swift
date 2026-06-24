//
//  AudioSystemProperties+Taps.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// MARK: - Audio Tap Lifecycle

extension AudioSystemProperties {
    /// Creates an audio tap and returns a new ``AudioTap`` instance if successful.
    @available(macOS 14.2, *)
    @available(macCatalyst, unavailable)
    @discardableResult
    nonisolated
    public func makeTap(using tapDescription: CATapDescription) throws(SwiftCoreAudioError) -> AudioTap {
        var tapID: AudioObjectID = kAudioObjectUnknown
        try AudioHardwareCreateProcessTap(tapDescription, &tapID)
            .throwingSwiftCoreAudioError(message: "Failed to create audio tap.")

        guard tapID != kAudioObjectUnknown else {
            throw .tapCreationFailed(message: "Returned object ID is 0 (invalid).")
        }

        return AudioTap(id: tapID)
    }

    /// Destroys an audio tap.
    @available(macOS 14.2, *)
    @available(macCatalyst, unavailable)
    nonisolated
    public func destroyTap(_ tap: some AudioTapProperties) throws(SwiftCoreAudioError) {
        let tapID: AudioObjectID = tap.id.rawValue
        try AudioHardwareDestroyProcessTap(tapID)
            .throwingSwiftCoreAudioError(message: "Failed to destroy audio tap.")
    }
}

#endif
