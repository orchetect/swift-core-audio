//
//  AudioSystemProperties+Boxes.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// MARK: - Audio Processes Enumeration

extension AudioSystemProperties {
    /// Returns an array of UIDs for audio boxes currently available to the system by looking up their UIDs.
    ///
    /// - Parameters:
    ///   - uidLookupErrorHandler: Optionally supply an error handler that will be called for any UIDs that fail lookup.
    ///     If this closure is `nil`, failures are silently ignored but will still be logged.
    /// - Throws: Throws an error if device enumeration fails. Individual failures on a per-device basis are
    ///   passed to the `streamLookupErrorHandler` closure and do not cause this method itself to throw.
    nonisolated
    public func boxUIDs(
        uidLookupErrorHandler: ((_ box: AudioBox, _ error: SwiftCoreAudioError) -> ())? = nil
    ) throws(SwiftCoreAudioError) -> [AudioBox.UID] {
        let boxes = try boxes
        return boxes.uids(uidLookupErrorHandler: uidLookupErrorHandler)
    }
}

#endif
