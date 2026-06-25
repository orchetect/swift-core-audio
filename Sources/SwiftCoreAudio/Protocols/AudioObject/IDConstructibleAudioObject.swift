//
//  IDConstructibleAudioObject.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

/// Audio objects that are constructible from a numeric audio object identifier.
///
/// All constructible object types in Swift Core Audio conform to this type.
public protocol IDConstructibleAudioObject: AudioObject, Codable {
    /// Construct from a strongly-typed audio object identifier.
    nonisolated
    init(id: ID)
}

// MARK: - Internal

extension IDConstructibleAudioObject {
    /// Internal convenience:
    /// Construct from a raw CoreAudio audio object identifier.
    @_disfavoredOverload
    nonisolated
    init(id: AudioObjectID) {
        assert(id != kAudioObjectUnknown)
        self.init(id: ID(id))
    }
}

// MARK: - Codable Implementation

extension IDConstructibleAudioObject {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(Int.self)
        guard let uInt32Value = UInt32(exactly: value) else {
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Invalid value. Value must fit in UInt32."
                )
            )
        }
        self.init(id: ID(uInt32Value))
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(Int(id.rawValue))
    }
}

// MARK: - Properties

extension AudioID where Object: AudioObject & IDConstructibleAudioObject {
    /// Returns a strongly-typed audio object with the given ID.
    /// This method always succeeds regardless whether any objects with the IDs actually exist.
    public var object: Object {
        Object(id: self)
    }
}

#endif
