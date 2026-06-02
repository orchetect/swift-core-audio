//
//  AudioClockPropertySelectorConstant.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

/// Analogous to CoreAudio `kAudioClockDeviceProperty*` selector constants.
///
/// `AudioObjectPropertySelector` values provided by the `AudioClockDevice` class.
public enum AudioClockPropertySelectorConstant {
    // MARK: CoreAudio/AudioHardwareBase.h
    
    /// Device UID
    ///
    /// A `CFString` that contains a persistent identifier for the `AudioClockDevice`.
    ///
    /// An `AudioClockDevice`'s UID is persistent across boots. The content of the UID string
    /// is a black box and may contain information that is unique to a particular instance of
    /// an clock's hardware or unique to the CPU. Therefore they are not suitable for passing
    /// between CPUs or for identifying similar models of hardware.
    ///
    /// The caller is responsible for releasing the returned `CFObject`.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioClockDevicePropertyDeviceUID`
    case deviceUID
    
    /// Transport Type
    ///
    /// A `UInt32` whose value indicates how the `AudioClockDevice` is connected to the CPU.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioClockDevicePropertyTransportType`
    case transportType
    
    /// Clock Domain
    ///
    /// A `UInt32` whose value indicates the clock domain to which this `AudioClockDevice` belongs.
    ///
    /// `AudioClockDevice`s and `AudioDevice`s that have the same value for this property are able
    /// to be synchronized in hardware. However, a value of `0` indicates that the clock domain
    /// for the device is unspecified and should be assumed to be separate from every other
    /// device's clock domain, even if they have the value of `0` as their clock domain as well.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioClockDevicePropertyClockDomain`
    case clockDomain
    
    /// Device Is Alive
    ///
    /// A `UInt32` where a value of `1` means the device is ready and available and `0`
    ///  means the device is usable and will most likely go away shortly.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioClockDevicePropertyDeviceIsAlive`
    case deviceIsAlive
    
    /// Device Is Running
    ///
    /// A `UInt32` where a value of `0` means the `AudioClockDevice` is not providing
    /// times and a value of `1` means that it is.
    ///
    /// Note that the notification for this property is usually sent from the `AudioClockDevice`'s
    /// IO thread.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioClockDevicePropertyDeviceIsRunning`
    case deviceIsRunning
    
    /// Latency
    ///
    /// A `UInt32` containing the number of frames of latency in the `AudioClockDevice`.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioClockDevicePropertyLatency`
    case latency
    
    /// Control List
    ///
    /// An array of `AudioObjectID`s that represent the AudioControls of the `AudioClockDevice`.
    ///
    /// Note that if a notification is received for this property, any cached `AudioObjectID`s
    /// for the device become invalid and need to be re-fetched.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioClockDevicePropertyControlList`
    case controlList
    
    /// Nominal Sample Rate
    ///
    /// A `Float64` that indicates the current nominal sample rate of the `AudioClockDevice`.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioClockDevicePropertyNominalSampleRate`
    case nominalSampleRate
    
    /// Available Nominal Sample Rates
    ///
    /// An array of `AudioValueRange` structs that indicates the valid ranges for the nominal
    /// sample rate of the `AudioClockDevice`.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioClockDevicePropertyAvailableNominalSampleRates`
    case availableNominalSampleRates
}

extension AudioClockPropertySelectorConstant: AudioPropertySelectorConstant { }

extension AudioClockPropertySelectorConstant: Equatable { }

extension AudioClockPropertySelectorConstant: Hashable { }

extension AudioClockPropertySelectorConstant: CaseIterable { }

extension AudioClockPropertySelectorConstant: Sendable { }

// MARK: - Inits

extension AudioClockPropertySelectorConstant {
    /// Same as ``init(rawValue:)`` but throws an error instead of returning `nil` when a match is not found.
    nonisolated
    public init(tryingRawValue rawValue: FourCharCode) throws(SwiftCoreAudioError) { // a.k.a. UInt32
        guard let match = Self(rawValue: rawValue) else {
            throw .notYetImplemented(
                message: "Unhandled/unrecognized audio clock property selector constant value: \(rawValue)"
            )
        }
        self = match
    }
}

// MARK: - RawRepresentable

extension AudioClockPropertySelectorConstant: RawRepresentable {
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
        case .deviceUID: kAudioClockDevicePropertyDeviceUID // "cuid"
        case .transportType: kAudioClockDevicePropertyTransportType // "tran"
        case .clockDomain: kAudioClockDevicePropertyClockDomain // "clkd"
        case .deviceIsAlive: kAudioClockDevicePropertyDeviceIsAlive // "livn"
        case .deviceIsRunning: kAudioClockDevicePropertyDeviceIsRunning // "goin"
        case .latency: kAudioClockDevicePropertyLatency // "ltnc"
        case .controlList: kAudioClockDevicePropertyControlList // "ctrl"
        case .nominalSampleRate: kAudioClockDevicePropertyNominalSampleRate // "nsrt"
        case .availableNominalSampleRates: kAudioClockDevicePropertyAvailableNominalSampleRates // "nsr#"
        }
    }
}

extension AudioClockPropertySelectorConstant: CustomStringConvertible {
    nonisolated
    public var description: String {
        switch self {
        // MARK: CoreAudio/AudioHardwareBase.h
        case .deviceUID: "Device UID"
        case .transportType: "Transport Type"
        case .clockDomain: "Clock Domain"
        case .deviceIsAlive: "Device Is Alive"
        case .deviceIsRunning: "Device Is Running"
        case .latency: "Latency"
        case .controlList: "Control List"
        case .nominalSampleRate: "Nominal Sample Rate"
        case .availableNominalSampleRates: "Available Nominal Sample Rates"
        }
    }
}

// MARK: - Static Constructors

extension AudioPropertySelectorConstant where Self == AudioClockPropertySelectorConstant {
    /// Analogous to CoreAudio `kAudioClockDeviceProperty*` selector constants.
    ///
    /// `AudioObjectPropertySelector` values provided by the `AudioClockDevice` class.
    public static func clock(_ selector: Self) -> Self {
        selector
    }
}

#endif
