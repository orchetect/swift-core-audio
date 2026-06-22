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
    /// Returns an array of devices currently available to the system matching the given UIDs.
    nonisolated
    public func devices<Device: AudioDeviceProperties & UIDConstructibleAudioObject>(
        forUIDs uids: some Collection<Device.UID>
    ) throws(SwiftCoreAudioError) -> [Device] {
        try objects(forUIDs: uids)
    }

    /// Returns an array of devices currently available to the system that have at least one stream for the
    /// given direction.
    /// The order of devices in the array matches the order of devices as seen in Audio MIDI Setup.
    nonisolated
    public func devices(with direction: AudioStream.Direction) throws(SwiftCoreAudioError) -> [AnyAudioDevice] {
        let allDevices = try devices

        var includedDevices: [AnyAudioDevice] = []
        for device in allDevices {
            if try device.hasStreams(for: direction) {
                includedDevices.append(device)
            }
        }

        return includedDevices
    }
}

#endif
