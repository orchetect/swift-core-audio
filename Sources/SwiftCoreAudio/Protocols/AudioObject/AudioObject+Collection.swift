//
//  AudioObject+Collection.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

// MARK: - Map

extension Sequence where Element: AudioObject {
    /// Returns the object IDs of the audio objects in the sequence.
    nonisolated
    public var ids: [Element.ID] {
        map(\.id)
    }

    /// Returns the object IDs of the audio objects in the sequence, type-erased as `AnyAudioObject.ID` instances.
    nonisolated
    public var idsAsAnyAudioObjectIDs: [AnyAudioObject.ID] {
        map(\.id.asAnyAudioObjectID)
    }

    /// Internal:
    /// Returns the raw Core Audio object IDs of the objects in the sequence.
    nonisolated
    var objectIDs: [AudioObjectID] {
        map(\.objectID)
    }
}

// MARK: - Equality

nonisolated
public func == (lhs: some Sequence<some AudioObject>, rhs: some Sequence<some AudioObject>) -> Bool {
    lhs.objectIDs == rhs.objectIDs
}

nonisolated
public func != (lhs: some Sequence<some AudioObject>, rhs: some Sequence<some AudioObject>) -> Bool {
    lhs.objectIDs != rhs.objectIDs
}

#endif
