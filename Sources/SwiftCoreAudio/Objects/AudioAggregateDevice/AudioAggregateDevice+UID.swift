//
//  AudioAggregateDevice+UID.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

// MARK: - Type Erasure

extension AudioUID<AudioAggregateDevice> /* a.k.a. AudioAggregateDevice.UID */ {
    /// Returns self wrapped in an `AnyAudioDevice.UID` case.
    public var asAnyAudioDeviceUID: AnyAudioDevice.UID {
        .init(rawValue: rawValue)
    }
}

extension Sequence<AudioAggregateDevice.UID> {
    /// Returns the collection with each element wrapped in an `AnyAudioDevice.UID` case.
    public var asAnyAudioDeviceUIDs: [AnyAudioDevice.UID] {
        map(\.asAnyAudioDeviceUID)
    }
}

#endif
