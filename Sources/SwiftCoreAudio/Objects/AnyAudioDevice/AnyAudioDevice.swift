//
//  AnyAudioDevice.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

/// Type-erased audio device subclass prototype.
public enum AnyAudioDevice {
    case device(AudioDevice)
    case aggregate(AudioAggregateDevice)
    // TODO: add AudioEndPointDevice?
}

extension AnyAudioDevice: Equatable { }

extension AnyAudioDevice: Hashable { }

extension AnyAudioDevice: Sendable { }

// MARK: - CustomStringConvertible

extension AnyAudioDevice: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .device(device): "AnyAudioDevice(.device(\(device.id)))"
        case let .aggregate(aggregate): "AnyAudioDevice(.aggregate(\(aggregate.id)))"
        }
    }
}

// MARK: - Properties

extension AnyAudioDevice {
    /// Internal: Returns the raw Core Audio object ID.
    nonisolated
    var objectID: AudioObjectID {
        switch self {
        case let .device(device): device.id.rawValue
        case let .aggregate(aggregate): aggregate.id.rawValue
        }
    }
}

#endif
