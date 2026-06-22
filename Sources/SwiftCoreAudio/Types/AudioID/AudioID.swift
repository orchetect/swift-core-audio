//
//  AudioID.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

/// Lightweight wrapper for an ephemeral numerical identifier used to refer to an audio object.
///
/// The raw value represents a CoreAudio `AudioObjectID`.
/// Audio objects are identifiable to CoreAudio by this ephemeral numerical ID.
///
/// > Note:
/// >
/// > This identifier is assigned by CoreAudio at runtime and changes every session.
/// > As such, this identifier should not be stored long-term.
public struct AudioID<Object: AudioObject> {
    /// The raw value representing a CoreAudio `AudioObjectID`.
    @inline(__always) nonisolated
    public let rawValue: UInt32

    @inline(__always)
    nonisolated
    public init(_ rawValue: UInt32) {
        self.rawValue = rawValue
    }
}

extension AudioID: Equatable { }

extension AudioID: Hashable { }

extension AudioID: Sendable { }

// MARK: - RawRepresentable

extension AudioID: RawRepresentable {
    public typealias RawValue = UInt32

    @inline(__always)
    nonisolated
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }
}

// MARK: - CustomStringConvertible

extension AudioID: CustomStringConvertible {
    public var description: String {
        "\(rawValue)"
    }
}

// MARK: - CustomDebugStringConvertible

extension AudioID: CustomDebugStringConvertible {
    public var debugDescription: String {
        "AudioID<\(Object.self)>(\(rawValue))"
    }
}

#endif
