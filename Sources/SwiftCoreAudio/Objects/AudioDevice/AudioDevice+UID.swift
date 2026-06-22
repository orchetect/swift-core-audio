//
//  AudioDevice+UID.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

// MARK: - Type Erasure

extension AudioUID<AudioDevice> /* a.k.a. AudioDevice.UID */ {
    /// Returns self wrapped in an `AnyAudioDevice.UID` case.
    nonisolated
    public var asAnyAudioDeviceUID: AnyAudioDevice.UID {
        .init(rawValue: rawValue)
    }
}

extension Sequence<AudioDevice.UID> {
    /// Returns the collection with each element wrapped in an `AnyAudioDevice.UID` case.
    nonisolated
    public var asAnyAudioDeviceUIDs: [AnyAudioDevice.UID] {
        map(\.asAnyAudioDeviceUID)
    }
}

#endif
