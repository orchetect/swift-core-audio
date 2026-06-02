//
//  AudioStream.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

/// Represents an individual audio stream.
///
/// An audio stream represents a single buffer of data for transferring across the user/kernel boundary.
/// As such, audio streams are the gatekeepers of format information. Each has its own format and list of
/// available formats.
///
/// `AudioStream` is a subclass of `AudioObject` and has only the single scope,
/// `kAudioObjectPropertyScopeGlobal`.
///
/// They have a main element, and an element for each channel in the stream numbered upward from `1`.
public struct AudioStream {
    nonisolated
    public let id: ID

    nonisolated
    public init(id: ID) {
        self.id = id
    }
}

extension AudioStream: Equatable { }

extension AudioStream: Hashable { }

extension AudioStream: Sendable { }

// MARK: - CustomStringConvertible

extension AudioStream: CustomStringConvertible {
    public var description: String {
        "AudioStream(\(id))"
    }
}

#endif
