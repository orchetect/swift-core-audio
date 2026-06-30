//
//  AudioSystemProperties+Devices.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// MARK: - Object Enumeration

extension AudioSystemProperties {
    /// Returns an array of UIDs for devices currently available to the system by looking up their UIDs.
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

    /// Returns an array of devices currently available to the system matching the given UIDs.
    ///
    /// - Parameters:
    ///   - uids: Audio device UIDs to look up.
    ///   - uidLookupErrorHandler: Optionally supply an error handler that will be called for any UIDs that fail lookup.
    ///     If this closure is `nil`, failures are silently ignored but will still be logged.
    nonisolated
    public func devices<Device: AudioDeviceProperties & UIDConstructibleAudioObject>(
        forUIDs uids: some Collection<Device.UID>,
        uidLookupErrorHandler: ((_ uid: Device.UID, _ error: SwiftCoreAudioError) -> ())? = nil
    ) -> [Device] {
        objects(forUIDs: uids, uidLookupErrorHandler: uidLookupErrorHandler)
    }

    /// Returns an array of devices currently available to the system that have at least one stream for the
    /// given direction.
    /// The order of devices in the array matches the order of devices as seen in Audio MIDI Setup.
    ///
    /// - Parameters:
    ///   - direction: Input or output audio stream direction.
    ///   - streamLookupErrorHandler: Optionally supply an error handler that will be called for any UIDs that fail lookup.
    ///     If this closure is `nil`, failures are silently ignored but will still be logged.
    /// - Throws: Throws an error if device enumeration fails. Individual failures on a per-device basis are
    ///   passed to the `streamLookupErrorHandler` closure and do not cause this method itself to throw.
    nonisolated
    public func devices(
        with direction: AudioStream.Direction,
        streamLookupErrorHandler: ((_ device: AnyAudioDevice, _ error: SwiftCoreAudioError) -> ())? = nil
    ) throws(SwiftCoreAudioError) -> [AnyAudioDevice] {
        let allDevices = try devices

        var includedDevices: [AnyAudioDevice] = []
        for device in allDevices {
            do throws(SwiftCoreAudioError) {
                if try device.hasStreams(for: direction) {
                    includedDevices.append(device)
                }
            } catch {
                CoreAudioLogging.log(.error, "Error looking up \(direction) stream information for audio device with ID \(device.id): \(error)")
                streamLookupErrorHandler?(device, error)
            }
        }

        return includedDevices
    }
}

#endif
