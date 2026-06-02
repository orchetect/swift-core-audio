//
//  AudioObjectProperties+Implementation.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

extension AudioObjectProperties {
    // MARK: - CoreAudio/AudioHardwareBase.h
    
    nonisolated
    public var baseClassID: AudioObjectClassID {
        get throws(SwiftCoreAudioError) {
            let classID = try getPropertyValue(property: ObjectProperty.baseClassID)
            let type = try AudioObjectClassID(tryingRawValue: classID)
            return type
        }
    }
    
    nonisolated
    public var classID: AudioObjectClassID {
        get throws(SwiftCoreAudioError) {
            let classID = try getPropertyValue(property: ObjectProperty.classID)
            let type = try AudioObjectClassID(tryingRawValue: classID)
            return type
        }
    }
    
    nonisolated
    public var owner: any AudioObject {
        get throws(SwiftCoreAudioError) {
            let id = try getPropertyValue(property: ObjectProperty.owner)
            guard id != kAudioObjectUnknown else {
                // throw an error instead of returning an Optional `nil` since the only time this
                // should happen is if you ask for the `AudioSystem`'s owner.
                throw .objectHasNoOwner
            }
            return try AudioSystem.shared.object(forID: id)
        }
    }
    
    nonisolated
    public var name: String? {
        get throws(SwiftCoreAudioError) {
            // gracefully return `nil` if object does not have the property
            let string = try withRecovery(
                try getPropertyValue(property: ObjectProperty.name),
                unknownPropertyDefault: nil
            )
            
            // interpret empty string as `nil`
            guard let string, !string.isEmpty else { return nil }
            return string
        }
    }
    
    nonisolated
    public var modelName: String? {
        get throws(SwiftCoreAudioError) {
            // gracefully return `nil` if object does not have the property
            let string = try withRecovery(
                try getPropertyValue(property: ObjectProperty.modelName),
                unknownPropertyDefault: nil
            )
            
            // interpret empty string as `nil`
            guard let string, !string.isEmpty else { return nil }
            return string
        }
    }
    
    nonisolated
    public var manufacturer: String? {
        get throws(SwiftCoreAudioError) {
            // gracefully return `nil` if object does not have the property
            let string = try withRecovery(
                try getPropertyValue(property: ObjectProperty.manufacturer),
                unknownPropertyDefault: nil
            )
            
            // interpret empty string as `nil`
            guard let string, !string.isEmpty else { return nil }
            return string
        }
    }
    
    // `elementName` is implemented directly on object subclasses for properties that use it
    
    // `elementCategoryName` is implemented directly on object subclasses for properties that use it
    
    // `elementNumberName` is implemented directly on object subclasses for properties that use it
    
    nonisolated
    public var ownedObjects: [any AudioObject] {
        get throws(SwiftCoreAudioError) {
            let ids = try getPropertyValue(property: ObjectProperty.ownedObjects, qualifier: .init(initialValue: []))
            var objects: [any AudioObject] = []
            for id in ids {
                let object = try AudioSystem.shared.object(forID: id)
                objects.append(object)
            }
            return objects
        }
    }
    
    nonisolated
    public func ownedObjects<T: AudioObjectType>(
        ofType objectType: T
    ) throws(SwiftCoreAudioError) -> [T.Object]
    where T.Object: IDConstructibleAudioObject
    {
        let ids = try getPropertyValue(
            property: ObjectProperty.ownedObjects,
            qualifier: .init(initialValue: [objectType.classID.rawValue])
        )
        var objects: [T.Object] = []
        for id in ids {
            let object = try AudioSystem.shared.object(forID: id, ofType: objectType)
            objects.append(object)
        }
        return objects
    }
    
    nonisolated
    public var isIdentifying: Bool {
        get throws(SwiftCoreAudioError) {
            try withRecovery(
                try getPropertyValue(property: ObjectProperty.identify),
                unknownPropertyDefault: false
            )
        }
    }
    
    nonisolated
    public var serialNumber: String? {
        get throws(SwiftCoreAudioError) {
            // gracefully return `nil` if object does not have the property
            let string = try withRecovery(
                try getPropertyValue(property: ObjectProperty.serialNumber),
                unknownPropertyDefault: nil
            )
            
            // interpret empty string as `nil`
            guard let string, !string.isEmpty else { return nil }
            return string
        }
    }
    
    nonisolated
    public var firmwareVersion: String? {
        get throws(SwiftCoreAudioError) {
            // gracefully return `nil` if object does not have the property
            let string = try withRecovery(
                try getPropertyValue(property: ObjectProperty.firmwareVersion),
                unknownPropertyDefault: nil
            )
            
            // interpret empty string as `nil`
            guard let string, !string.isEmpty else { return nil }
            return string
        }
    }
    
    // MARK: - CoreAudio/AudioHardware.h
    
    nonisolated
    public var creator: BundleID? {
        get throws(SwiftCoreAudioError) {
            // gracefully return `nil` if object does not have the property
            let string = try withRecovery(
                try getPropertyValue(property: ObjectProperty.creator),
                unknownPropertyDefault: nil
            )
            
            // interpret empty string as `nil`
            guard let string, !string.isEmpty else { return nil }
            return BundleID(string)
        }
    }
}

#endif
