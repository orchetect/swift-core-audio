//
//  AudioDevice.UID+Static.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import Foundation
import SwiftCoreAudio

extension AudioUID<AudioDevice> /* a.k.a. AudioDevice.UID */ {
    // MARK: - Built-In Devices
    
    /// `BuiltInSpeakerDevice`: Audio device UID common on many Macs for built-in speakers (has outputs).
    ///
    /// - Name on Mac Pro is "Mac Pro Speakers"
    /// - Name on MacBook Pro is "MacBook Pro Speakers"
    static var builtInSpeakerDevice: Self {
        Self("BuiltInSpeakerDevice")
    }
    
    /// `BuiltInMicrophoneDevice`: Audio device UID common on many Macs for built-in microphone (has input).
    ///
    /// - Name on MacBook Pro is "MacBook Pro Microphone"
    static var builtInMicrophoneDevice: Self {
        Self("BuiltInMicrophoneDevice")
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
