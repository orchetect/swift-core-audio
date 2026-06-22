//
//  AudioObjectConcreteType.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import Foundation

/// Lightweight type that wraps ``AudioObjectClassID`` and adds strongly-typed concrete type
/// by way of an `Object` generic constraint.
///
/// These can be accessed by using the static properties on ``AudioObjectType``
/// that represent each class type.
public struct AudioObjectConcreteType<Object: AudioObject> {
    /// The ``AudioObjectType`` case that corresponds to the concrete object type.
    public let classID: AudioObjectClassID

    /// Internal:
    /// Init used for static constructors.
    init(classID: AudioObjectClassID) {
        self.classID = classID
    }
}

extension AudioObjectConcreteType: AudioObjectType { }

extension AudioObjectConcreteType: Equatable { }

extension AudioObjectConcreteType: Hashable { }

extension AudioObjectConcreteType: Sendable { }

extension AudioObjectConcreteType: CustomStringConvertible {
    nonisolated
    public var description: String {
        classID.description
    }
}

#endif
