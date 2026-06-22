//
//  AudioAggregateDevicePropertySelectorConstant.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

/// Analogous to CoreAudio `kAudioAggregateDeviceProperty*` selector constants.
///
/// `AudioObjectPropertySelector` values provided by the `AudioAggregateDevice` class.
public enum AudioAggregateDevicePropertySelectorConstant {
    // MARK: CoreAudio/AudioHardware.h

    /// Full SubDevice List
    ///
    /// A `CFArray` of `CFString`s that contain the UIDs of all the devices, active or
    /// inactive, contained in the `AudioAggregateDevice`.
    ///
    /// The order of the items in the array is significant and is used to determine the order
    /// of the streams of the `AudioAggregateDevice`.
    ///
    /// The caller is responsible for releasing the returned `CFObject`.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioAggregateDevicePropertyFullSubDeviceList`
    case fullSubDeviceList

    /// Active SubDevice List
    ///
    /// An array of `AudioObjectID`s for all the active sub-devices in the aggregate device.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioAggregateDevicePropertyActiveSubDeviceList`
    case activeSubDeviceList

    /// Composition
    ///
    /// A `CFDictionary` that describes the composition of the `AudioAggregateDevice`.
    ///
    /// The caller is responsible for releasing the returned `CFObject`.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioAggregateDevicePropertyComposition`
    case composition

    /// Main SubDevice
    ///
    /// A `CFString` that contains the UID for the `AudioDevice` that is currently
    /// serving as the time base of the aggregate device.
    ///
    /// The caller is responsible for releasing the returned `CFObject`.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioAggregateDevicePropertyMainSubDevice`
    case mainSubDevice

    /// Clock Device
    ///
    /// A `CFString` that contains the UID for the `AudioClockDevice` that is currently
    /// serving as the time base of the aggregate device.
    ///
    /// If the aggregate device includes both a main audio device and a clock device, the clock
    /// device will control the time base.
    ///
    /// Setting this property will enable drift correction for all subdevices in the
    /// aggregate device.
    ///
    /// The caller is responsible for releasing the returned `CFObject`.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioAggregateDevicePropertyClockDevice`
    case clockDevice

    /// Tap List
    ///
    /// A `CFArray` of `CFString`s that contain the UIDs of all the tap objects in the
    /// contained in the `AudioAggregateDevice`.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioAggregateDevicePropertyTapList`
    case tapList

    /// SubTap List
    ///
    /// An array of `AudioObjectID`s for all the active sub-taps in the aggregate
    /// device.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioAggregateDevicePropertySubTapList`
    case subTapList
}

extension AudioAggregateDevicePropertySelectorConstant: AudioPropertySelectorConstant { }

extension AudioAggregateDevicePropertySelectorConstant: Equatable { }

extension AudioAggregateDevicePropertySelectorConstant: Hashable { }

extension AudioAggregateDevicePropertySelectorConstant: CaseIterable { }

extension AudioAggregateDevicePropertySelectorConstant: Sendable { }

// MARK: - Inits

extension AudioAggregateDevicePropertySelectorConstant {
    /// Same as ``init(rawValue:)`` but throws an error instead of returning `nil` when a match is not found.
    nonisolated
    public init(tryingRawValue rawValue: FourCharCode) throws(SwiftCoreAudioError) { // a.k.a. UInt32
        guard let match = Self(rawValue: rawValue) else {
            throw .notYetImplemented(
                message: "Unhandled/unrecognized audio aggregate device property selector constant value: \(rawValue)"
            )
        }
        self = match
    }
}

// MARK: - RawRepresentable

extension AudioAggregateDevicePropertySelectorConstant: RawRepresentable {
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
        // MARK: CoreAudio/AudioHardware.h

        case .fullSubDeviceList: kAudioAggregateDevicePropertyFullSubDeviceList // "grup"
        case .activeSubDeviceList: kAudioAggregateDevicePropertyActiveSubDeviceList // "agrp"
        case .composition: kAudioAggregateDevicePropertyComposition // "acom"
        case .mainSubDevice: kAudioAggregateDevicePropertyMainSubDevice // "amst"
        case .clockDevice: kAudioAggregateDevicePropertyClockDevice // "apcd"
        case .tapList: kAudioAggregateDevicePropertyTapList // "tap#"
        case .subTapList: kAudioAggregateDevicePropertySubTapList // "atap"
        }
    }
}

extension AudioAggregateDevicePropertySelectorConstant: CustomStringConvertible {
    nonisolated
    public var description: String {
        switch self {
        // MARK: CoreAudio/AudioHardware.h

        case .fullSubDeviceList: "Full SubDevice List"
        case .activeSubDeviceList: "Active SubDevice List"
        case .composition: "Composition"
        case .mainSubDevice: "Main SubDevice"
        case .clockDevice: "Clock Device"
        case .tapList: "Tap List"
        case .subTapList: "Active SubTap List"
        }
    }
}

// MARK: - Static Constructors

extension AudioPropertySelectorConstant where Self == AudioAggregateDevicePropertySelectorConstant {
    /// Analogous to CoreAudio `kAudioAggregateDeviceProperty*` selector constants.
    ///
    /// `AudioObjectPropertySelector` values provided by the `AudioAggregateDevice` class.
    public static func aggregate(_ selector: Self) -> Self {
        selector
    }
}

#endif
