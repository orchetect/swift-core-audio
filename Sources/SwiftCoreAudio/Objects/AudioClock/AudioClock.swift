//
//  AudioClock.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

/// Represents an individual audio clock.
///
/// All audio devices inherit from the audio clock class, which provides several base properties
/// and contains a list of control objects. Clock objects can be used as a time source when run in
/// an aggregate device, but contain no IO streams.
///
/// The `AudioClockDevice` class is a subclass of the `AudioObject` class.
///
/// The class has just the global scope (`kAudioObjectPropertyScopeGlobal`) and only a main element.
public struct AudioClock {
    nonisolated
    public let id: ID

    nonisolated
    public init(id: ID) {
        self.id = id
    }
}

extension AudioClock: Equatable { }

extension AudioClock: Hashable { }

extension AudioClock: Sendable { }

// MARK: - CustomStringConvertible

extension AudioClock: CustomStringConvertible {
    public var description: String {
        "AudioClock(\(id))"
    }
}

#endif
