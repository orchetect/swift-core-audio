//
//  AudioTransportManagerPropertySelectorConstant.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

/// Analogous to CoreAudio `kAudioTransportManagerSelectorProperty*` selector constants.
///
/// `AudioObjectPropertySelector` values provided by the `AudioTransportManager` class.
public enum AudioTransportManagerPropertySelectorConstant {
    // MARK: CoreAudio/AudioHardwareBase.h
    
    /// EndPoint List
    ///
    /// An array of `AudioObjectID`s for all the `AudioEndPoint` objects the transport manager
    /// is tracking.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioTransportManagerPropertyEndPointList`
    case endPointList
    
    /// Translate UID to EndPoint
    ///
    /// This property fetches the `AudioObjectID` that corresponds to the `AudioEndPoint` that
    /// has the given UID.
    ///
    /// The UID is passed in via the qualifier as a `CFString` while the `AudioObjectID` for the
    /// `AudioEndPoint` is returned to the caller as the property's data.
    ///
    /// Note that an error is not returned if the UID doesn't refer to any `AudioEndPoint`s.
    /// Rather, this property will return `kAudioObjectUnknown` as the value of the property.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioTransportManagerPropertyTranslateUIDToEndPoint`
    case translateUIDToEndPoint
    
    /// Transport Type
    ///
    /// A `UInt32` whose value indicates how the transport manager's endpoints and endpoint
    /// devices are connected to the CPU.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioTransportManagerPropertyTransportType`
    case transportType
    
    // MARK: CoreAudio/AudioHardware.h
    
    /// Create EndPoint Device
    ///
    /// This property is used to tell a transport manager to create a new `AudioEndPointDevice`.
    ///
    /// Its value is only read.
    ///
    /// The qualifier data for this property is a `CFDictionary` containing a description of the
    /// `AudioDevice` to create.
    ///
    /// The value of the property that gets returned is the `AudioObjectID` of the newly created
    /// device.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioTransportManagerCreateEndPointDevice`
    case createEndPointDevice
    /// Destroy EndPoint Device
    ///
    /// This property is used to tell a transport manager to destroy an `AudioEndPointDevice`.
    /// Like `kAudioTransportManagerCreateDevice`, this property is read only.
    ///
    /// The value of the property is the `AudioObjectID` of the `AudioEndPointDevice` to destroy.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioTransportManagerDestroyEndPointDevice`
    case destroyEndPointDevice
}

extension AudioTransportManagerPropertySelectorConstant: AudioPropertySelectorConstant { }

extension AudioTransportManagerPropertySelectorConstant: Equatable { }

extension AudioTransportManagerPropertySelectorConstant: Hashable { }

extension AudioTransportManagerPropertySelectorConstant: CaseIterable { }

extension AudioTransportManagerPropertySelectorConstant: Sendable { }

// MARK: - Inits

extension AudioTransportManagerPropertySelectorConstant {
    /// Same as ``init(rawValue:)`` but throws an error instead of returning `nil` when a match is not found.
    nonisolated
    public init(tryingRawValue rawValue: FourCharCode) throws(SwiftCoreAudioError) { // a.k.a. UInt32
        guard let match = Self(rawValue: rawValue) else {
            throw .notYetImplemented(
                message: "Unhandled/unrecognized audio transport manager property selector constant value: \(rawValue)"
            )
        }
        self = match
    }
}

// MARK: - RawRepresentable

extension AudioTransportManagerPropertySelectorConstant: RawRepresentable {
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
        case .endPointList: kAudioTransportManagerPropertyEndPointList // "end#"
        case .translateUIDToEndPoint: kAudioTransportManagerPropertyTranslateUIDToEndPoint // "uide"
        case .transportType: kAudioTransportManagerPropertyTransportType // "tran"
        // MARK: CoreAudio/AudioHardware.h
        case .createEndPointDevice: kAudioTransportManagerCreateEndPointDevice // "cdev"
        case .destroyEndPointDevice: kAudioTransportManagerDestroyEndPointDevice // "ddev"
        }
    }
}

extension AudioTransportManagerPropertySelectorConstant: CustomStringConvertible {
    nonisolated
    public var description: String {
        switch self {
        // MARK: CoreAudio/AudioHardwareBase.h
        case .endPointList: "EndPoint List"
        case .translateUIDToEndPoint: "Translate UID to EndPoint"
        case .transportType: "Transport Type"
        // MARK: CoreAudio/AudioHardware.h
        case .createEndPointDevice: "Create EndPoint Device"
        case .destroyEndPointDevice: "Destroy EndPoint Device"
        }
    }
}

// MARK: - Static Constructors

extension AudioPropertySelectorConstant where Self == AudioTransportManagerPropertySelectorConstant {
    /// Analogous to CoreAudio `kAudioTransportManagerSelectorProperty*` selector constants.
    ///
    /// `AudioObjectPropertySelector` values provided by the `AudioTransportManager` class.
    public static func transportManager(_ selector: Self) -> Self {
        selector
    }
}

#endif
