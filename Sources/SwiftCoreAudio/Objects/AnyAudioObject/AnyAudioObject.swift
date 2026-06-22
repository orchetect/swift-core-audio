//
//  AnyAudioObject.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

/// Type-erased audio object prototype.
///
/// This type should be used sparingly, if ever. It is primarily intended for use as a mechanism
/// to access audio object properties in the absence of a specialized concrete ``AudioObject``
/// type is unknown or inaccessible in the current context.
///
/// For example, the ``AudioSystem/classID(forID:)`` utility function internally creates a temporary
/// instance of this struct in order to query its ``AudioObjectProperties/classID`` property.
public struct AnyAudioObject {
    nonisolated
    public let id: ID

    nonisolated
    public init(id: ID) {
        self.id = id
    }
}

extension AnyAudioObject: Equatable { }

extension AnyAudioObject: Hashable { }

extension AnyAudioObject: Sendable { }

// MARK: - CustomStringConvertible

extension AnyAudioObject: CustomStringConvertible {
    public var description: String {
        "AnyAudioObject(\(id))"
    }
}

// MARK: - Methods

extension AnyAudioObject {
    /// If the object exists and can be constructed, its concrete instance is returned type-erased
    /// as `any AudioObject`.
    public var concreteInstance: any AudioObject {
        get throws(SwiftCoreAudioError) {
            try AudioSystem.shared.object(forID: id.rawValue)
        }
    }
}

#endif
