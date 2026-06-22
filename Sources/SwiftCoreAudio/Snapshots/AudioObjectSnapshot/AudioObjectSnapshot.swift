//
//  AudioObjectSnapshot.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

/// Snapshot of Core Audio object properties state.
///
/// A catalog of diagnostic information for Core Audio.
/// Useful for debugging or system information gathering for end-user bug reporting.
///
/// > Note: This type is not meant to be used in production for any reason other than diagnostics.
public struct AudioObjectSnapshot {
    /// Unique identifier used only for `Identifiable`.
    /// Not related to any Core Audio property.
    public let id: UUID

    /// Version of the snapshot data format.
    public internal(set) var dataVersion: Int = 1

    /// `AudioObjectID` identifier of the audio object.
    public let objectID: Int

    /// Timestamp of when the snapshot was captured.
    public var date: Date

    /// Properties.
    public var properties: [AnyPropertyKey: String]

    /// Child objects.
    public var children: [AudioObjectSnapshot]

    /// Any errors encountered while reading Core Audio object properties.
    /// Keyed by property name with values containing the error.
    public var errors: [String]

    /// Initialize from pre-captured data.
    public init(
        objectID: Int,
        date: Date = Date(),
        properties: [AnyPropertyKey: String] = [:],
        children: [AudioObjectSnapshot] = []
    ) {
        id = UUID()
        self.objectID = objectID
        self.date = date
        self.properties = properties
        self.children = children
        errors = []
    }
}

extension AudioObjectSnapshot: Equatable { }

extension AudioObjectSnapshot: Hashable { }

extension AudioObjectSnapshot: Sendable { }

extension AudioObjectSnapshot: Codable { }

extension AudioObjectSnapshot: Identifiable {
    // `id` requirement is a stored property in the struct body
}

extension AudioObjectSnapshot {
    /// Creates a full Core Audio system snapshot of the audio object.
    public init(of object: some AudioObject) {
        let objectID = Int(object.id.rawValue)
        let properties = Self._properties(of: object)
        let children = Self._children(of: object)
        self.init(objectID: objectID, properties: properties, children: children)
    }

    // This method is functionally identical to the one above it, except it uses concurrency for improved performance
    /// Creates a full Core Audio system snapshot of the audio object.
    public init(of object: some AudioObject) async {
        let objectID = Int(object.id.rawValue)
        async let properties = Self._properties(of: object)
        async let children = Self._children(of: object)
        await self.init(objectID: objectID, properties: properties, children: children)
    }
}

#endif
