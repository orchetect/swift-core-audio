//
//  AudioObjectProperties.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

/// Properties offered by the Core Audio `AudioObject` class.
public protocol AudioObjectProperties where Self: AudioObject {
    // MARK: - CoreAudio/AudioHardwareBase.h

    /// A ``AudioObjectClassID`` case describing the `AudioClassID` that identifies the class from
    /// which the class of the audio object is derived.
    nonisolated
    var baseClassID: AudioObjectClassID { get throws(SwiftCoreAudioError) }

    /// A ``AudioObjectClassID`` case describing the `AudioClassID` that identifies the class of the
    /// object.
    nonisolated
    var classID: AudioObjectClassID { get throws(SwiftCoreAudioError) }

    /// Note that all audio objects are owned by some other audio object.
    /// The only exception is the System audio object.
    nonisolated
    var owner: any AudioObject { get throws(SwiftCoreAudioError) }

    /// A `String` that contains the human readable name of the object.
    nonisolated
    var name: String? { get throws(SwiftCoreAudioError) }

    /// A `String` that contains the human readable model name of the object.
    nonisolated
    var modelName: String? { get throws(SwiftCoreAudioError) }

    /// A `String` that contains the human readable name of the manufacturer of the
    /// hardware the object is a part of.
    nonisolated
    var manufacturer: String? { get throws(SwiftCoreAudioError) }

    // `elementName` is used on a per-object basis

    // `elementCategoryName` is used on a per-object basis

    // `elementNumberName` is used on a per-object basis

    /// An array of `any AudioObject` that represent all the objects owned by this object.
    /// To filter by a specific concrete object type, call ``ownedObjects(ofType:)`` instead.
    nonisolated
    var ownedObjects: [any AudioObject] { get throws(SwiftCoreAudioError) }

    /// An array of strongly-typed concrete `AudioObject` objects that represent all the objects
    /// owned by this object.
    nonisolated
    func ownedObjects<T: AudioObjectType>(
        ofType objectType: T
    ) throws(SwiftCoreAudioError) -> [T.Object]
    where T.Object: IDConstructibleAudioObject

    /// A boolean value indicating whether an object's hardware is drawing attention to itself.
    ///
    /// A value of `true` indicates that the object's hardware is drawing attention to itself,
    /// typically by flashing or lighting up its front panel display. A value of `false` indicates
    /// that this function is turned off.
    ///
    /// This makes it easy for a user to associate the physical hardware with its representation
    /// in an application. Typically, this property is only supported by audio devices and audio
    /// boxes.
    nonisolated
    var isIdentifying: Bool { get throws(SwiftCoreAudioError) }

    /// A `String` that contains the human readable serial number for the object.
    ///
    /// This property will typically be implemented by audio box and audio device
    /// objects.
    ///
    /// Note that the serial number is not defined to be unique in the same
    /// way that an audio box's or audio device's UID property are defined. This is
    /// purely an informational value.
    nonisolated
    var serialNumber: String? { get throws(SwiftCoreAudioError) }

    /// A `String` that contains the human readable firmware version for the object.
    ///
    /// This property will typically be implemented by audio box and audio device
    /// objects.
    ///
    /// Note that this is purely an informational value.
    nonisolated
    var firmwareVersion: String? { get throws(SwiftCoreAudioError) }

    // MARK: - CoreAudio/AudioHardware.h

    /// The `BundleID` of the plug-in that instantiated the object.
    nonisolated
    var creator: BundleID? { get throws(SwiftCoreAudioError) }
}

#endif
