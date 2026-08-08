//
//  AudioDevice.UID+Static.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import Foundation
import SwiftCoreAudio

extension AudioUID<AudioDevice> /* a.k.a. AudioDevice.UID */ {
    // MARK: - Built-In Devices

    /// `BuiltInSpeakerDevice`: Audio device UID common on many Macs for built-in speakers (has outputs).
    ///
    /// See the `BuiltInSpeakers` enum for known static metadata.
    static var builtInSpeakerDevice: Self {
        Self("BuiltInSpeakerDevice")
    }

    /// `BuiltInMicrophoneDevice`: Audio device UID common on many Macs for built-in microphone (has input).
    ///
    /// See the `BuiltInMic` enum for known static metadata.
    static var builtInMicrophoneDevice: Self {
        Self("BuiltInMicrophoneDevice")
    }

    /// `AVIODevice`: Audio device UID common on macOS virtual machine installations (has inputs & outputs).
    ///
    /// See the `VMAudioDevice` enum for known static metadata.
    static var vmAudioDevice: Self {
        Self("AVIODevice")
    }

    // MARK: - BlackHole

    /// `BlackHole2ch_UID`: BlackHole (2-channel variant).
    ///
    /// BlackHole is an open-source audio loopback driver for macOS.
    /// See: https://github.com/ExistentialAudio/BlackHole
    ///
    /// Its simplicity and ability to be installed from the shell in a CI pipeline makes it suitable
    /// for being used as a test audio device in automated testing.
    static var blackHole2Ch: Self {
        Self("BlackHole2ch_UID")
    }
}

#endif
