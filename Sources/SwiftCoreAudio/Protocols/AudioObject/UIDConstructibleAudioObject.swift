//
//  UIDConstructibleAudioObject.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

/// Audio objects that are constructible from a persistent unique string identifier.
public protocol UIDConstructibleAudioObject: UIDIdentifiableAudioObject {
    /// Construct from a strongly-typed audio object unique identifier.
    ///
    /// This initializer queries Core Audio to return the object's ephemeral numeric ID.
    ///
    /// If an object with the given UID does not exist, `nil` is returned.
    /// If an error occurs, the error is thrown.
    nonisolated
    init?(uid: UID) throws(SwiftCoreAudioError)
}

// MARK: - Internal

extension UIDConstructibleAudioObject {
    /// Internal convenience:
    /// Construct from a raw Core Audio persistent unique string identifier.
    ///
    /// This initializer queries Core Audio to return the object's ephemeral numeric ID.
    ///
    /// If an object with the given UID does not exist, `nil` is returned.
    /// If an error occurs, the error is thrown.
    nonisolated
    init?(uid: String) throws(SwiftCoreAudioError) {
        try self.init(uid: UID(uid))
    }
}

// MARK: - Properties

extension AudioUID where Object: UIDIdentifiableAudioObject & UIDConstructibleAudioObject {
    /// Returns a strongly-typed audio object with the given UID by querying Core Audio for its ID.
    /// Throws an error if no object can be found with the UID.
    public var object: Object? {
        get throws(SwiftCoreAudioError) {
            try AudioSystem.shared.object(forUID: self)
        }
    }
}

#endif
