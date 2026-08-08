//
//  AudioDevice+Static.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import Foundation
import SwiftCoreAudio

// MARK: - Built-In Devices

extension AudioDevice {
    /// `BuiltInSpeakerDevice`: Audio device UID common on many Macs for built-in speakers (has outputs).
    ///
    /// See the `BuiltInSpeakers` enum for known static metadata.
    static var builtInSpeakerDevice: Self? {
        try? Self(uid: .builtInSpeakerDevice)
    }

    /// `BuiltInMicrophoneDevice`: Audio device UID common on many Macs for built-in microphone (has input).
    ///
    /// See the `BuiltInMic` enum for known static metadata.
    static var builtInMicrophoneDevice: Self? {
        try? Self(uid: .builtInMicrophoneDevice)
    }

    /// `AVIODevice`: Audio device UID common on macOS virtual machine installations (has inputs & outputs).
    ///
    /// See the `VMAudioDevice` enum for known static metadata.
    static var vmAudioDevice: Self? {
        try? Self(uid: .vmAudioDevice)
    }
}

// MARK: - BlackHole

extension AudioDevice {
    /// `BlackHole2ch_UID`: BlackHole (2-channel variant).
    ///
    /// BlackHole is an open-source audio loopback driver for macOS.
    /// See: https://github.com/ExistentialAudio/BlackHole
    ///
    /// Its simplicity and ability to be installed from the shell in a CI pipeline makes it suitable
    /// for being used as a test audio device in automated testing.
    static var blackHole2Ch: Self? {
        try? Self(uid: .blackHole2Ch)
    }
}

// MARK: - AirPods Pro 3

extension AudioDevice {
    /// AirPods Pro 3 - Input Device.
    /// For local testing.
    ///
    /// Apple splits the AirPods Pro 3 into two separate devices -
    /// one with input (mic), and one with outputs (L/R earbud speakers).
    static func airPodsPro3(_ direction: AudioStream.Direction) -> Self? {
        try? AudioSystem.shared
            .devices(with: direction)
            .audioDevices
            .first(where: { (try? $0.name)?.starts(with: "AirPods Pro 3") == true })
    }
}

#endif
