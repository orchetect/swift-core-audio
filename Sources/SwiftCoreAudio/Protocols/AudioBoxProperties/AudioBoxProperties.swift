//
//  AudioBoxProperties.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

/// Properties offered by the Core Audio `AudioBox` class.
public protocol AudioBoxProperties where Self: AudioObject & UIDIdentifiableAudioObject {
    // MARK: CoreAudio/AudioHardwareBase.h

    /// A `String` that contains a persistent identifier for the `AudioBox`.
    nonisolated
    var boxUID: UID { get throws(SwiftCoreAudioError) }

    /// A ``AudioDevice/TransportType`` instance indicating how the box is connected to the system.
    nonisolated
    var transportType: AudioDevice.TransportType { get throws(SwiftCoreAudioError) }

    /// A boolean value indicating whether the box supports audio.
    nonisolated
    var hasAudio: Bool { get throws(SwiftCoreAudioError) }

    /// A boolean value indicating whether the box supports video.
    nonisolated
    var hasVideo: Bool { get throws(SwiftCoreAudioError) }

    /// A boolean value indicating whether the box supports MIDI.
    nonisolated
    var hasMIDI: Bool { get throws(SwiftCoreAudioError) }

    /// A boolean value indicating whether the box requires authentication to use.
    nonisolated
    var isProtected: Bool { get throws(SwiftCoreAudioError) }

    /// A boolean value indicating whether the box has been enabled (acquired).
    nonisolated
    var isEnabled: Bool { get throws(SwiftCoreAudioError) }

    /// Enables or disables the audio box (acquires or unacquires).
    nonisolated
    func setIsEnabled(_ state: Bool) throws(SwiftCoreAudioError)

    // note: acquisitionFailed can be read after a call to acquire it fails, which should happen in `setEnabled()`

    /// Returns an array of devices in the box.
    /// Note that until a box is enabled, this list will be empty.
    nonisolated
    var devices: [AnyAudioDevice] { get throws(SwiftCoreAudioError) }

    /// Returns an array of clocks in the box.
    /// Note that until a box is enabled, this list will be empty.
    nonisolated
    var clocks: [AudioClock] { get throws(SwiftCoreAudioError) }
}

#endif
