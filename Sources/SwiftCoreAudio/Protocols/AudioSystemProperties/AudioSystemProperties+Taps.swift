//
//  AudioSystemProperties+Taps.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// MARK: - Audio Tap Enumeration

extension AudioSystemProperties {
    /// Returns an array of UIDs for devices currently available to the system by looking up their UIDs.
    ///
    /// - Parameters:
    ///   - uidLookupErrorHandler: Optionally supply an error handler that will be called for any UIDs that fail lookup.
    ///     If this closure is `nil`, failures are silently ignored but will still be logged.
    /// - Throws: Throws an error if device enumeration fails. Individual failures on a per-device basis are
    ///   passed to the `streamLookupErrorHandler` closure and do not cause this method itself to throw.
    nonisolated
    public func tapUIDs(
        uidLookupErrorHandler: ((_ device: AudioTap, _ error: SwiftCoreAudioError) -> ())? = nil
    ) throws(SwiftCoreAudioError) -> [AudioTap.UID] {
        let taps = try taps
        return taps.uids(uidLookupErrorHandler: uidLookupErrorHandler)
    }
}

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
