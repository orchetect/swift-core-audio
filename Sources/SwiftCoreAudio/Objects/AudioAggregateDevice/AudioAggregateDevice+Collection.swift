//
//  AudioAggregateDevice+Collection.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

extension Sequence<AudioAggregateDevice> {
    /// Returns the collection with each element wrapped in an ``AnyAudioDevice`` case.
    public var asAnyAudioDevices: [AnyAudioDevice] {
        map { .aggregate($0) }
    }
}

#endif
