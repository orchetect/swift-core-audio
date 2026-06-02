//
//  AnyAudioDevice+Static.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import Foundation
import SwiftCoreAudio

// MARK: - Built-In Devices

extension AnyAudioDevice {
    /// `BuiltInSpeakerDevice`: Audio device UID common on many Macs for built-in speakers (has outputs).
    ///
    /// - Name on Mac Pro is "Mac Pro Speakers"
    /// - Name on MacBook Pro is "MacBook Pro Speakers"
    static var builtInSpeakerDevice: Self? {
        try? Self(uid: .builtInSpeakerDevice)
    }

    /// `BuiltInMicrophoneDevice`: Audio device UID common on many Macs for built-in microphone (has input).
    ///
    /// - Name on MacBook Pro is "MacBook Pro Microphone"
    static var builtInMicrophoneDevice: Self? {
        try? Self(uid: .builtInMicrophoneDevice)
    }
}

// MARK: - BlackHole

extension AnyAudioDevice {
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

#endif
