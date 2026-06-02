//
//  AudioDevice+Collection.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

// MARK: - Map

extension Sequence<AudioDevice> {
    /// Returns the collection with each element wrapped in an ``AnyAudioDevice`` case.
    nonisolated
    public var asAnyAudioDevices: [AnyAudioDevice] {
        map { .device($0) }
    }
}

#endif
