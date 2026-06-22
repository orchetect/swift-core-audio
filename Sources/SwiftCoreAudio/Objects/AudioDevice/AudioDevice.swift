//
//  AudioDevice.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

/// Represents an individual audio device.
///
/// An audio device serves as the basic unit of I/O.
///
/// The `AudioDevice` class is a subclass of the `AudioObject` class.
///
/// The class has four scopes: `kAudioObjectPropertyScopeGlobal`, `kAudioObjectPropertyScopeInput`,
/// `kAudioObjectPropertyScopeOutput`, and `kAudioObjectPropertyScopePlayThrough`.
///
/// The class has a main element and an element for each channel in each stream
/// numbered according to the starting channel number of each stream.
public struct AudioDevice {
    nonisolated
    public let id: ID

    nonisolated
    public init(id: ID) {
        self.id = id
    }
}

extension AudioDevice: Equatable { }

extension AudioDevice: Hashable { }

extension AudioDevice: Sendable { }

// MARK: - CustomStringConvertible

extension AudioDevice: CustomStringConvertible {
    public var description: String {
        "AudioDevice(\(id))"
    }
}

// MARK: - Type Erasure

extension AudioDevice {
    /// Returns self wrapped in an ``AnyAudioDevice`` case.
    nonisolated
    public var asAnyAudioDevice: AnyAudioDevice {
        .device(self)
    }
}

#endif
