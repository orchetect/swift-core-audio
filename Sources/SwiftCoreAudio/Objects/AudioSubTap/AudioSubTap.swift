//
//  AudioSubTap.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

/// Represents an individual audio subtap.
///
/// A subtap represents the relationship that an existing tap has to a specific aggregate
/// that is has been added to. The taps's properties are provided by its `AudioTap` implementation,
/// and the relationship it has to its containing aggregate device is provided by its `AudioSubTap`
/// implementation.
///
/// The `AudioSubTap` class is a subclass of `AudioObject` class and has the same
/// scope and element structure. However, `AudioSubTap` objects do not implement an
/// IO path of their own and as such do not implement any `AudioDevice` properties
/// associated with the IO path. They also don't have any streams.
public struct AudioSubTap {
    nonisolated
    public let id: ID

    nonisolated
    public init(id: ID) {
        self.id = id
    }
}

extension AudioSubTap: Equatable { }

extension AudioSubTap: Hashable { }

extension AudioSubTap: Sendable { }

// MARK: - CustomStringConvertible

extension AudioSubTap: CustomStringConvertible {
    public var description: String {
        "AudioSubTap(\(id))"
    }
}

#endif
