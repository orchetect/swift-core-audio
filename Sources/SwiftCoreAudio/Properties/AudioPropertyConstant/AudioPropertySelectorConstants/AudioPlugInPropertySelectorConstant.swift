//
//  AudioPlugInPropertySelectorConstant.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

/// Analogous to CoreAudio `kAudioPlugInProperty*` selector constants.
///
/// `AudioObjectPropertySelector` values provided by the `AudioPlugIn` class.
public enum AudioPlugInPropertySelectorConstant {
    // MARK: CoreAudio/AudioHardwareBase.h
    
    /// Bundle ID
    ///
    /// A `CFString` that contains the bundle identifier for the `AudioPlugIn`.
    ///
    /// The caller is responsible for releasing the returned `CFObject`.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioPlugInPropertyBundleID`
    case bundleID
    
    /// Device List
    ///
    /// An array of `AudioObjectID`s that represent all the `AudioDevice`s currently
    /// provided by the plug-in.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioPlugInPropertyDeviceList`
    case deviceList
    
    /// Translate UID to Device
    ///
    /// This property fetches the `AudioObjectID` that corresponds to the `AudioDevice`
    /// that has the given UID.
    ///
    /// The UID is passed in via the qualifier as a `CFString` while the `AudioObjectID`
    /// for the `AudioDevice` is returned to the caller as the property's data.
    ///
    /// Note that an error is not returned if the UID doesn't refer to any `AudioDevice`s.
    /// Rather, this property will return `kAudioObjectUnknown` as the value of the property.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioPlugInPropertyTranslateUIDToDevice`, which is identical to
    /// > `kAudioHardwarePropertyTranslateUIDToDevice`.
    case translateUIDToDevice
    
    /// Box List
    ///
    /// An array of `AudioObjectID`s that represent all the `AudioBox` objects currently provided
    /// by the plug-in.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioPlugInPropertyBoxList`
    case boxList
    
    /// Translate UID to Box
    ///
    /// This property fetches the `AudioObjectID` that corresponds to the `AudioBox`
    /// that has the given UID.
    ///
    /// The UID is passed in via the qualifier as a `CFString` while the `AudioObjectID`
    /// for the `AudioBox` is returned to the caller as the property's data.
    ///
    /// Note that an error is not returned if the UID doesn't refer to any `AudioBox`es.
    /// Rather, this property will return `kAudioObjectUnknown` as the value of the property.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioPlugInPropertyTranslateUIDToBox`, which is identical to
    /// > `kAudioHardwarePropertyTranslateUIDToBox`.
    case translateUIDToBox
    
    /// Clock Device List
    ///
    /// An array of `AudioObjectID`s that represent all the `AudioClockDevice` objects currently
    /// provided by the plug-in.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioPlugInPropertyClockDeviceList`
    case clockDeviceList
    
    /// Translate UID to Clock Device
    ///
    /// This property fetches the `AudioObjectID` that corresponds to the `AudioClockDevice`
    /// that has the given UID.
    ///
    /// The UID is passed in via the qualifier as a `CFString` while the `AudioObjectID`
    /// for the `AudioClockDevice` is returned to the caller as the property's data.
    ///
    /// Note that an error is not returned if the UID doesn't refer to any `AudioClockDevice`s.
    /// Rather, this property will return `kAudioObjectUnknown` as the value of the property.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioPlugInPropertyTranslateUIDToClockDevice`, which is identical to
    /// > `kAudioHardwarePropertyTranslateUIDToClockDevice`.
    case translateUIDToClockDevice
    
    // MARK: CoreAudio/AudioHardware.h
    
    /// Create Aggregate Device
    ///
    /// This property is used to tell a plug-in to create a new `AudioAggregateDevice`.
    ///
    /// Its value is only read.
    ///
    /// The qualifier data for this property is a `CFDictionary` containing a description of the
    /// `AudioAggregateDevice` to create. The keys for the `CFDictionary` are defined in
    /// the AudioAggregateDevice Constants section.
    ///
    /// The value of the property that gets returned is the `AudioObjectID` of the newly created
    /// device.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioPlugInCreateAggregateDevice`
    case createAggregateDevice
    
    /// Destroy Aggregate Device
    ///
    /// This property is used to tell a plug-in to destroy a `AudioAggregateDevice`.
    ///
    /// Like `kAudioPlugInCreateAggregateDevice`, this property is read only.
    ///
    /// The value of the property is the `AudioObjectID` of the `AudioAggregateDevice` to
    /// destroy.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioPlugInDestroyAggregateDevice`
    case destroyAggregateDevice
}

extension AudioPlugInPropertySelectorConstant: AudioPropertySelectorConstant { }

extension AudioPlugInPropertySelectorConstant: Equatable { }

extension AudioPlugInPropertySelectorConstant: Hashable { }

extension AudioPlugInPropertySelectorConstant: CaseIterable { }

extension AudioPlugInPropertySelectorConstant: Sendable { }

// MARK: - Inits

extension AudioPlugInPropertySelectorConstant {
    /// Same as ``init(rawValue:)`` but throws an error instead of returning `nil` when a match is not found.
    nonisolated
    public init(tryingRawValue rawValue: FourCharCode) throws(SwiftCoreAudioError) { // a.k.a. UInt32
        guard let match = Self(rawValue: rawValue) else {
            throw .notYetImplemented(
                message: "Unhandled/unrecognized audio plugin property selector constant value: \(rawValue)"
            )
        }
        self = match
    }
}

// MARK: - RawRepresentable

extension AudioPlugInPropertySelectorConstant: RawRepresentable {
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
        case .bundleID: kAudioPlugInPropertyBundleID // "piid"
        case .deviceList: kAudioPlugInPropertyDeviceList // "dev#"
        case .translateUIDToDevice: kAudioPlugInPropertyTranslateUIDToDevice // "uidd"
        case .boxList: kAudioPlugInPropertyBoxList // "box#"
        case .translateUIDToBox: kAudioPlugInPropertyTranslateUIDToBox // "uidb"
        case .clockDeviceList: kAudioPlugInPropertyClockDeviceList // "clk#"
        case .translateUIDToClockDevice: kAudioPlugInPropertyTranslateUIDToClockDevice // "uidc"
        // MARK: CoreAudio/AudioHardware.h
        case .createAggregateDevice: kAudioPlugInCreateAggregateDevice // "cagg"
        case .destroyAggregateDevice: kAudioPlugInDestroyAggregateDevice // "dagg"
        }
    }
}

extension AudioPlugInPropertySelectorConstant: CustomStringConvertible {
    nonisolated
    public var description: String {
        switch self {
        // MARK: CoreAudio/AudioHardwareBase.h
        case .bundleID: "Bundle ID"
        case .deviceList: "Device List"
        case .translateUIDToDevice: "Translate UID to Device"
        case .boxList: "Box List"
        case .translateUIDToBox: "Translate UID to Box"
        case .clockDeviceList: "Clock Device List"
        case .translateUIDToClockDevice: "Translate UID to Clock Device"
        // MARK: CoreAudio/AudioHardware.h
        case .createAggregateDevice: "Create Aggregate Device"
        case .destroyAggregateDevice: "Destroy Aggregate Device"
        }
    }
}

// MARK: - Static Constructors

extension AudioPropertySelectorConstant where Self == AudioPlugInPropertySelectorConstant {
    /// Analogous to CoreAudio `kAudioPlugInProperty*` selector constants.
    ///
    /// `AudioObjectPropertySelector` values provided by the `AudioPlugIn` class.
    public static func plugIn(_ selector: Self) -> Self {
        selector
    }
}

#endif
