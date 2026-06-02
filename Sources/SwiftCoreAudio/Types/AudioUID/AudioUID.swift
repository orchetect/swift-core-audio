//
//  AudioUID.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

/// Lightweight wrapper for a persistent unique identifier string used to refer to an audio object.
///
/// This identifier can be passed to CoreAudio in order too look up the ephemeral numeric ID (``AudioID``)
/// that the object has been assigned by CoreAudio for the session.
public struct AudioUID<Object: UIDIdentifiableAudioObject> {
    /// Raw identifier string.
    @inline(__always) nonisolated
    public let rawValue: String

    @inline(__always) nonisolated
    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
}

extension AudioUID: Equatable { }

extension AudioUID: Hashable { }

extension AudioUID: Sendable { }

// MARK: - RawRepresentable

extension AudioUID: RawRepresentable {
    public typealias RawValue = String

    @inline(__always) nonisolated
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

// MARK: - CustomStringConvertible

extension AudioUID: CustomStringConvertible {
    @inline(__always) nonisolated
    public var description: String {
        rawValue
    }
}

// MARK: - CustomDebugStringConvertible

extension AudioUID: CustomDebugStringConvertible {
    public var debugDescription: String {
        "AudioUID<\(Object.self)>(\"\(rawValue)\")"
    }
}

#endif
