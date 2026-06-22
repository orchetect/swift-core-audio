//
//  AudioObjectPropertySelectorConstant.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

/// Analogous to CoreAudio `kAudioObjectProperty*` selector constants.
///
/// `AudioObjectPropertySelector` values provided by objects of the `AudioObject` class.
public enum AudioObjectPropertySelectorConstant {
    // MARK: CoreAudio/AudioHardwareBase.h

    /// Base Class
    ///
    /// An `AudioClassID` that identifies the class from which the class of the
    /// audio object is derived.
    ///
    /// This value must always be one of the standard classes.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioObjectPropertyBaseClass`
    case baseClass

    /// Class
    ///
    /// An `AudioClassID` that identifies the class of the audio object.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioObjectPropertyClass`
    case `class`

    /// Owner
    ///
    /// An `AudioObjectID` that identifies the the audio object that owns the given audio object.
    ///
    /// Note that all audio objects are owned by some other audio object.
    /// The only exception is the System audio object, for which the value of this
    /// property is `kAudioObjectUnknown`.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioObjectPropertyOwner`
    case owner

    /// Name
    ///
    /// A `CFString` that contains the human readable name of the object.
    ///
    /// The caller is responsible for releasing the returned `CFObject`.
    ///
    /// > Tip:
    /// > `kAudioObjectPropertyName` and `kAudioDevicePropertyDeviceNameCFString` are the same
    /// > constant and both return `CFString`.
    /// >
    /// > `kAudioDevicePropertyDeviceName` returns a C-string.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioObjectPropertyName`
    case name

    /// Model Name
    ///
    /// A `CFString` that contains the human readable model name of the object.
    ///
    /// The model name differs from `kAudioObjectPropertyName` in that two objects of
    /// the same model will have the same value for this property but may have different
    /// values for `kAudioObjectPropertyName`.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioObjectPropertyModelName`
    case modelName

    /// Manufacturer
    ///
    /// A `CFString` that contains the human readable name of the manufacturer of the
    /// hardware the AudioObject is a part of.
    ///
    /// The caller is responsible for releasing the returned `CFObject`.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioObjectPropertyManufacturer`
    case manufacturer

    /// Element Name
    ///
    /// A `CFString` that contains a human readable name for the given element in the given scope.
    ///
    /// The caller is responsible for releasing the returned `CFObject`.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioObjectPropertyElementName`
    case elementName

    /// Element Category Name
    ///
    /// A `CFString` that contains a human readable name for the category of the given
    /// element in the given scope.
    ///
    /// The caller is responsible for releasing the returned `CFObject`.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioObjectPropertyElementCategoryName`
    case elementCategoryName

    /// Element Number Name
    ///
    /// A `CFString` that contains a human readable name for the number of the given
    /// element in the given scope.
    ///
    /// The caller is responsible for releasing the returned `CFObject`.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioObjectPropertyElementNumberName`
    case elementNumberName

    /// Owned Objects
    ///
    /// An array of `AudioObjectID`s that represent all the audio objects owned by the
    /// given object.
    ///
    /// The qualifier is an array of `AudioClassID`s. If it is non-empty, the returned array
    /// of `AudioObjectID`s will only refer to objects whose class is in the qualifier array
    /// or whose is a subclass of one in the qualifier array.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioObjectPropertyOwnedObjects`
    case ownedObjects

    /// Identify
    ///
    /// A `UInt32` indicating whether an object's hardware is drawing attention to itself.
    ///
    /// A value of `1` indicates that the object's hardware is drawing attention to itself,
    /// typically by flashing or lighting up its front panel display. A value of `0` indicates
    /// that this function is turned off.
    ///
    /// This makes it easy for a user to associate the physical hardware with its representation
    /// in an application. Typically, this property is only supported by audio devices and audio
    /// boxes.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioObjectPropertyIdentify`
    case identify

    /// Serial Number
    ///
    /// A `CFString` that contains the human readable serial number for the object.
    ///
    /// This property will typically be implemented by audio box and audio device
    /// objects.
    ///
    /// Note that the serial number is not defined to be unique in the same
    /// way that an audio box's or audio device's UID property are defined. This is
    /// purely an informational value.
    ///
    /// The caller is responsible for releasing the returned `CFObject`.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioObjectPropertySerialNumber`
    case serialNumber

    /// Firmware Version
    ///
    /// A `CFString` that contains the human readable firmware version for the object.
    ///
    /// This property will typically be implemented by audio box and audio device
    /// objects.
    ///
    /// Note that this is purely an informational value.
    ///
    /// The caller is responsible for releasing the returned `CFObject`.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioObjectPropertyFirmwareVersion`
    case firmwareVersion

    // MARK: CoreAudio/AudioHardware.h

    /// Creator
    ///
    /// A `CFString` that contains the bundle ID of the plug-in that instantiated the object.
    ///
    /// The caller is responsible for releasing the returned `CFObject`.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioObjectPropertyCreator`
    case creator

    // /// Listener Added
    // ///
    // /// An `AudioObjectPropertyAddress` indicating the address to which a new listener
    // /// was added.
    // ///
    // /// Note that this property is not for applications to use. Rather, this property is for
    // /// the HAL shell to notify `AudioObject`s implemented by an `AudioPlugIn` when a listener
    // /// is added.
    // ///
    // /// > File: CoreAudio/AudioHardware.h
    // ///
    // /// > Constant: `kAudioObjectPropertyListenerAdded`
    // case listenerAdded
    //
    // /// Listener Removed
    // ///
    // /// An `AudioObjectPropertyAddress` indicating the address to which a listener was removed.
    // ///
    // /// Note that this property is not for applications to use. Rather, this property is for
    // /// the HAL shell to notify AudioObjects implemented by an `AudioPlugIn` when a listener
    // /// is removed.
    // ///
    // /// > File: CoreAudio/AudioHardware.h
    // ///
    // /// > Constant: `kAudioObjectPropertyListenerRemoved`
    // case listenerRemoved
}

extension AudioObjectPropertySelectorConstant: AudioPropertySelectorConstant { }

extension AudioObjectPropertySelectorConstant: Equatable { }

extension AudioObjectPropertySelectorConstant: Hashable { }

extension AudioObjectPropertySelectorConstant: CaseIterable { }

extension AudioObjectPropertySelectorConstant: Sendable { }

// MARK: - Inits

extension AudioObjectPropertySelectorConstant {
    /// Same as ``init(rawValue:)`` but throws an error instead of returning `nil` when a match is not found.
    nonisolated
    public init(tryingRawValue rawValue: FourCharCode) throws(SwiftCoreAudioError) { // a.k.a. UInt32
        guard let match = Self(rawValue: rawValue) else {
            throw .notYetImplemented(
                message: "Unhandled/unrecognized audio object property selector constant value: \(rawValue)"
            )
        }
        self = match
    }
}

// MARK: - RawRepresentable

extension AudioObjectPropertySelectorConstant: RawRepresentable {
    nonisolated
    public init?(rawValue: FourCharCode) { // a.k.a. UInt32
        guard let match = Self.allCases
            .first(where: { $0.rawValue == rawValue })
        else {
            return nil
        }
        self = match
    }

    nonisolated
    public var rawValue: FourCharCode { // a.k.a. UInt32
        switch self {
        // MARK: CoreAudio/AudioHardwareBase.h

        case .baseClass: kAudioObjectPropertyBaseClass // "bcls"
        case .class: kAudioObjectPropertyClass // "clas"
        case .owner: kAudioObjectPropertyOwner // "stdv"
        case .name: kAudioObjectPropertyName // "lnam"
        case .modelName: kAudioObjectPropertyModelName // "lmod"
        case .manufacturer: kAudioObjectPropertyManufacturer // "lmak"
        case .elementName: kAudioObjectPropertyElementName // "lchn"
        case .elementCategoryName: kAudioObjectPropertyElementCategoryName // "lccn"
        case .elementNumberName: kAudioObjectPropertyElementNumberName // "lcnn"
        case .ownedObjects: kAudioObjectPropertyOwnedObjects // "ownd"
        case .identify: kAudioObjectPropertyIdentify // "iden"
        case .serialNumber: kAudioObjectPropertySerialNumber // "snum"
        case .firmwareVersion: kAudioObjectPropertyFirmwareVersion // "fwvn"

        // MARK: CoreAudio/AudioHardware.h
        case .creator: kAudioObjectPropertyCreator // "oplg"
        // case .listenerAdded: kAudioObjectPropertyListenerAdded // "lisa"
        // case .listenerRemoved: kAudioObjectPropertyListenerRemoved // "lisr"
        }
    }
}

extension AudioObjectPropertySelectorConstant: CustomStringConvertible {
    nonisolated
    public var description: String {
        switch self {
        // MARK: CoreAudio/AudioHardwareBase.h

        case .baseClass: "Base Class"
        case .class: "Class"
        case .owner: "Owner"
        case .name: "Name"
        case .modelName: "Model Name"
        case .manufacturer: "Manufacturer"
        case .elementName: "Element Name"
        case .elementCategoryName: "Element Category Name"
        case .elementNumberName: "Element Number Name"
        case .ownedObjects: "Owned Objects"
        case .identify: "Identify"
        case .serialNumber: "Serial Number"
        case .firmwareVersion: "Firmware Version"

        // MARK: CoreAudio/AudioHardware.h
        case .creator: "Creator"
        // case .listenerAdded: "Listener Added"
        // case .listenerRemoved: "Listener Removed"
        }
    }
}

// MARK: - Static Constructors

extension AudioPropertySelectorConstant where Self == AudioObjectPropertySelectorConstant {
    /// Analogous to CoreAudio `kAudioObjectProperty*` selector constants.
    ///
    /// `AudioObjectPropertySelector` values provided by objects of the `AudioObject` class.
    public static func object(_ selector: Self) -> Self {
        selector
    }
}

#endif
