//
//  AudioProcessProperties.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

/// Properties offered by the Core Audio `AudioProcess` class.
nonisolated
public protocol AudioProcessProperties where Self: AudioObject {
    // MARK: CoreAudio/AudioHardware.h

    /// Returns the process ID (PID) associated with the process.
    nonisolated
    var pid: PID { get throws(SwiftCoreAudioError) }

    /// Returns the bundle ID string associated with the process.
    nonisolated
    var bundleID: BundleID? { get throws(SwiftCoreAudioError) }

    /// Returns an array of devices currently used by the process for input and/or output.
    nonisolated
    var devices: [AnyAudioDevice] { get throws(SwiftCoreAudioError) }

    /// Returns an array of devices in the process for the given direction.
    nonisolated
    func devices(for direction: AudioStream.Direction) throws(SwiftCoreAudioError) -> [AnyAudioDevice]

    /// Returns a boolean value indicating whether the process is running IO and there is at least
    /// one active stream.
    nonisolated
    var isRunning: Bool { get throws(SwiftCoreAudioError) }

    /// Returns a boolean value indicating whether the process is running IO and there is at least
    /// one active stream for the given direction.
    nonisolated
    func isRunning(for direction: AudioStream.Direction) throws(SwiftCoreAudioError) -> Bool
}

#endif
