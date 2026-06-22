//
//  AudioAggregateDevice.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

/// Represents an individual aggregate audio device.
///
/// An aggregate device is a virtual device that combines the input and output streams of
/// multiple real devices or taps. It also synchronizes the clocks of its subdevices and taps
/// when running I/O to ensure streams are aligned.
///
/// `AudioAggregateDevice` is a subclass of `AudioDevice` and has the same scope and
/// element structure.
public struct AudioAggregateDevice {
    nonisolated
    public let id: ID

    nonisolated
    public init(id: ID) {
        self.id = id
    }
}

extension AudioAggregateDevice: Equatable { }

extension AudioAggregateDevice: Hashable { }

extension AudioAggregateDevice: Sendable { }

// MARK: - CustomStringConvertible

extension AudioAggregateDevice: CustomStringConvertible {
    public var description: String {
        "AudioAggregateDevice(\(id))"
    }
}

// MARK: - Type Erasure

extension AudioAggregateDevice {
    /// Returns self wrapped in an ``AnyAudioDevice`` case.
    public var asAnyAudioDevice: AnyAudioDevice {
        .aggregate(self)
    }
}

#endif
