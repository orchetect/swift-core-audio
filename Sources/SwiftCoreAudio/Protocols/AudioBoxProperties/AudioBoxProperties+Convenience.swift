//
//  AudioBoxProperties+Convenience.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// MARK: - Object Enumeration

extension AudioBoxProperties {
    /// Returns an array of UIDs for devices in the box by looking up their UIDs.
    /// Note that until a box is enabled, this list will be empty.
    ///
    /// - Parameters:
    ///   - uidLookupErrorHandler: Optionally supply an error handler that will be called for any UIDs that fail lookup.
    ///     If this closure is `nil`, failures are silently ignored but will still be logged.
    /// - Throws: Throws an error if device enumeration fails. Individual failures on a per-device basis are
    ///   passed to the `streamLookupErrorHandler` closure and do not cause this method itself to throw.
    nonisolated
    public func deviceUIDs(
        uidLookupErrorHandler: ((_ device: AnyAudioDevice, _ error: SwiftCoreAudioError) -> ())? = nil
    ) throws(SwiftCoreAudioError) -> [AnyAudioDevice.UID] {
        let devices = try devices
        return devices.uids(uidLookupErrorHandler: uidLookupErrorHandler)
    }

    /// Returns an array of UIDs for clocks in the box by looking up their UIDs.
    /// Note that until a box is enabled, this list will be empty.
    ///
    /// - Parameters:
    ///   - uidLookupErrorHandler: Optionally supply an error handler that will be called for any UIDs that fail lookup.
    ///     If this closure is `nil`, failures are silently ignored but will still be logged.
    /// - Throws: Throws an error if device enumeration fails. Individual failures on a per-device basis are
    ///   passed to the `streamLookupErrorHandler` closure and do not cause this method itself to throw.
    nonisolated
    public func clockUIDs(
        uidLookupErrorHandler: ((_ clock: AudioClock, _ error: SwiftCoreAudioError) -> ())? = nil
    ) throws(SwiftCoreAudioError) -> [AudioClock.UID] {
        let clocks = try clocks
        return clocks.uids(uidLookupErrorHandler: uidLookupErrorHandler)
    }
}

// MARK: - Properties

extension AudioBoxProperties {
    /// Returns `true` if the box is present in the boxes currently available to the system.
    ///
    /// > Note: Avoid calling this method repeatedly for each element in a collection of boxes.
    /// > Instead, get the value of `AudioSystem.shared.boxes` once and check for the presence of
    /// > each box in the returned array.
    nonisolated
    public var isPresent: Bool {
        // TODO: there may be a direct Core Audio call that can do this faster than this method...
        guard let ids = try? AudioSystem.shared.boxes.map(\.id.rawValue) else { return false }
        return ids.contains(id.rawValue)
    }
}

#endif
