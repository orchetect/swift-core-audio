//
//  IDConstructibleAudioObject.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

/// Audio objects that are constructible from a numeric audio object identifier.
///
/// All constructible object types in Swift Core Audio conform to this type.
nonisolated
public protocol IDConstructibleAudioObject: AudioObject {
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
        self.init(id: ID(id))
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
