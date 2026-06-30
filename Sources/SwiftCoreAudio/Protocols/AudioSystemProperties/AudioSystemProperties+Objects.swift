//
//  AudioSystemProperties+Objects.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// MARK: - Object Lookup by ID

extension AudioSystemProperties {
    /// Returns the audio class type (representing `AudioClassID`) of the object with the given object ID.
    nonisolated
    public func classID(forID id: AudioObjectID) throws(SwiftCoreAudioError) -> AudioObjectClassID {
        let object = AnyAudioObject(id: id)
        return try object.classID
    }

    /// Returns an audio object typed as `any AudioObject` with the given ID.
    /// Throws an error if it doesn't exist.
    nonisolated
    public func object(forID id: AudioObjectID) throws(SwiftCoreAudioError) -> any AudioObject {
        let ownerClassID = try AudioSystem.shared.classID(forID: id)

        // return early if class ID is the System class, which does not conform to `IDConstructibleAudioObject`
        if ownerClassID == .system {
            return self
        }

        let newInstance: any IDConstructibleAudioObject
        if let ownerConcreteType = ownerClassID.concreteType,
           let constructibleOwnerConcreteType = ownerConcreteType as? any IDConstructibleAudioObject
        {
            newInstance = type(of: constructibleOwnerConcreteType).init(id: id)
        } else {
            CoreAudioLogging.log(.error, "Concrete type for \(ownerClassID) class type not yet implemented substituting with AnyAudioObject.")
            newInstance = AnyAudioObject(id: id)
        }

        return newInstance
    }

    /// Returns a strongly-typed audio object with the given ID if it matches the given concrete type.
    /// Throws an error if it doesn't exist.
    nonisolated
    public func object<ObjectType: AudioObjectType>(
        forID id: AudioObjectID,
        ofType objectType: ObjectType
    ) throws(SwiftCoreAudioError) -> ObjectType.Object where ObjectType.Object: IDConstructibleAudioObject {
        let ownerClassID = try AudioSystem.shared.classID(forID: id)

        guard let ownerConcreteType = ownerClassID.concreteType else {
            throw .notYetImplemented(message: "Concrete type for \(ownerClassID) class type not yet implemented.")
        }

        guard ownerConcreteType.self == ObjectType.Object.self else {
            throw .incorrectObjectType(
                message: "Expected class type \(objectType) for object ID \(id) but actual class type reported by Core Audio is \(ownerClassID)."
            )
        }

        let newInstance = ObjectType.Object(id: id)

        return newInstance
    }

    /// Returns a strongly-typed audio object with the given ID.
    /// This method always succeeds regardless whether an object with the ID actually exists.
    nonisolated
    public func object<Object: AudioObject & IDConstructibleAudioObject>(
        forID id: Object.ID
    ) -> Object {
        Object(id: id)
    }

    /// Returns an array of strongly-typed objects with the given IDs.
    /// This method always succeeds regardless whether any objects with the IDs actually exist.
    nonisolated
    public func objects<Object: AudioObject & IDConstructibleAudioObject>(
        forIDs ids: some Collection<AudioID<Object>>
    ) -> [Object] {
        ids.map { id in Object(id: id) }
    }
}

// MARK: - Object Lookup by UID

extension AudioSystemProperties {
    /// Returns a strongly-typed audio object with the given UID by querying Core Audio for its ID.
    /// Throws an error if no object can be found with the UID.
    nonisolated
    public func object<Object: AudioObject & UIDConstructibleAudioObject>(
        forUID uid: Object.UID
    ) throws(SwiftCoreAudioError) -> Object? {
        try Object(uid: uid)
    }

    /// Returns an array of strongly-typed objects currently available to the system matching the given UIDs.
    ///
    /// - Parameters:
    ///   - uids: Audio object UIDs to look up.
    ///   - uidLookupErrorHandler: Optionally supply an error handler that will be called for any UIDs that fail lookup.
    ///     If this closure is `nil`, failures are silently ignored but will still be logged.
    nonisolated
    public func objects<Object: AudioObject & UIDConstructibleAudioObject>(
        forUIDs uids: some Collection<AudioUID<Object>>, // a.k.a. `some Collection<Object.UID>`
        uidLookupErrorHandler: ((_ uid: Object.UID, _ error: SwiftCoreAudioError) -> ())? = nil
    ) -> [Object] {
        var objects: [Object] = []
        for uid in uids {
            do throws(SwiftCoreAudioError) {
                if let device = try Object(uid: uid) { objects.append(device) }
            } catch {
                CoreAudioLogging.log(.error, "Error resolving UID for \(Object.self) to object ID: \(error)")
                uidLookupErrorHandler?(uid, error)
            }
        }
        return objects
    }
}

#endif
