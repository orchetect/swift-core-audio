//
//  AnyAudioDevice+Collection.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

// MARK: - Filter

extension Sequence<AnyAudioDevice> {
    /// Returns all ``AudioDevice`` instances in the collection.
    nonisolated
    public var audioDevices: [AudioDevice] {
        compactMap {
            guard case let .device(device) = $0 else { return nil }
            return device
        }
    }

    /// Returns all ``AudioAggregateDevice`` instances in the collection.
    nonisolated
    public var audioAggregateDevices: [AudioAggregateDevice] {
        compactMap {
            guard case let .aggregate(device) = $0 else { return nil }
            return device
        }
    }
}

#endif
