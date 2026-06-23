//
//  AudioStream Direction.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

extension AudioStream {
    /// Type representing the direction of an audio stream.
    /// An audio stream can have one of two directions: input or output.
    public enum Direction {
        // MARK: CoreAudio/AudioHardwareBase.h

        /// Input stream direction (a.k.a. source) that receives audio.
        case input

        /// Output stream direction (a.k.a. destination) where audio is sent to.
        case output
    }
}

extension AudioStream.Direction: Equatable { }

extension AudioStream.Direction: Hashable { }

extension AudioStream.Direction: CaseIterable { }

extension AudioStream.Direction: Codable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        guard let decoded = Self(encodedValue: value) else {
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Unrecognized value: \(value)"
                )
            )
        }
        self = decoded
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(encodedValue)
    }

    init?(encodedValue: String) {
        guard let match = Self.allCases.first(where: { $0.encodedValue == encodedValue.lowercased() })
        else { return nil }
        self = match
    }

    var encodedValue: String {
        switch self {
        case .input: "input"
        case .output: "output"
        }
    }
}

extension AudioStream.Direction: Sendable { }

// MARK: - Inits

extension AudioStream.Direction {
    /// Same as ``init(rawValue:)`` but throws an error instead of returning `nil` when a match is not found.
    nonisolated
    public init(tryingRawValue rawValue: UInt32) throws(SwiftCoreAudioError) {
        guard let match = Self(rawValue: rawValue) else {
            throw .notYetImplemented(message: "Unhandled/unrecognized audio stream terminal type value: \(rawValue)")
        }
        self = match
    }
}

// MARK: - RawRepresentable

extension AudioStream.Direction: RawRepresentable {
    nonisolated
    public init?(rawValue: UInt32) {
        guard let match = Self.allCases
            .first(where: { $0.rawValue == rawValue })
        else {
            return nil
        }
        self = match
    }

    nonisolated
    public var rawValue: UInt32 {
        switch self {
        // MARK: CoreAudio/AudioHardwareBase.h

        case .input: 1
        case .output: 0
        }
    }
}

// MARK: - CustomStringConvertible

extension AudioStream.Direction: CustomStringConvertible {
    nonisolated
    public var description: String {
        switch self {
        // MARK: CoreAudio/AudioHardwareBase.h

        case .input: "Input"
        case .output: "Output"
        }
    }
}

#endif
