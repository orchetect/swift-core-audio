//
//  AudioObjectType.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

/// Strongly-typed enumeration of audio objects.
public protocol AudioObjectType: Equatable, Hashable, Sendable, CustomStringConvertible {
    associatedtype Object: AudioObject
    
    /// The class ID belonging to the audio object type.
    var classID: AudioObjectClassID { get }
}

#endif
