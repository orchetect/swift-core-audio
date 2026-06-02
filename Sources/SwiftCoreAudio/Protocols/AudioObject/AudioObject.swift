//
//  AudioObject.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

/// Audio objects.
///
/// Analogous to the Core Audio `AudioObject` class, which is the base class for all classes.
/// As such, all classes inherit its properties.
///
/// All audio object types in Swift Core Audio conform to this protocol.
///
/// ## Ephemeral Identification
///
/// Audio objects are identifiable to Core Audio by a an ephemeral numerical ID.
///
/// This identifier is assigned by Core Audio at runtime and changes every session.
/// As such, this identifier should not be stored long-term.
///
/// All entities conform to this protocol as all are ephemerally identifiable.
nonisolated
public protocol AudioObject: Equatable, Hashable, Sendable {
    /// Strongly-typed audio object identifier.
    typealias ID = AudioID<Self>
    
    /// Strongly-typed audio object identifier.
    nonisolated
    var id: ID { get }
}

// MARK: - Type Erasure

extension AudioObject {
    /// Returns the object type-erased as an ``AnyAudioObject`` instance.
    nonisolated
    public var asAnyAudioObject: AnyAudioObject {
        AnyAudioObject(id: id.rawValue)
    }
}

// MARK: - Snapshot

extension AudioObject {
    /// Returns a snapshot data structure of Core Audio properties state.
    ///
    /// A catalog of diagnostic information for Core Audio.
    /// Useful for debugging or system information gathering for end-user bug reporting.
    ///
    /// > Note: This type is not meant to be used in production for any reason other than diagnostics.
    nonisolated
    public func snapshot() -> AudioObjectSnapshot {
        AudioObjectSnapshot(of: self)
    }
}

// MARK: - Properties

extension AudioObject {
    /// Internal:
    /// Proxy to return the raw Core Audio object ID.
    ///
    /// This allows mapping raw IDs of a collection of `any AudioObject` by using `.map(\.objectID)` where
    /// the compiler would otherwise reject `.map(\.id.rawValue)` due to mixed generics.
    nonisolated
    var objectID: AudioObjectID {
        id.rawValue
    }
}

#endif
