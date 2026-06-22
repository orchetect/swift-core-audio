//
//  AudioEndPointDevice.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

/// Represents an individual audio endpoint device.
///
/// `AudioEndPointDevice` is a subclass of `AudioDevice` and has the same scope and
/// element structure.
public struct AudioEndPointDevice {
    nonisolated
    public let id: ID

    nonisolated
    public init(id: ID) {
        self.id = id
    }
}

extension AudioEndPointDevice: Equatable { }

extension AudioEndPointDevice: Hashable { }

extension AudioEndPointDevice: Sendable { }

// MARK: - CustomStringConvertible

extension AudioEndPointDevice: CustomStringConvertible {
    public var description: String {
        "AudioEndPointDevice(\(id))"
    }
}

#endif
