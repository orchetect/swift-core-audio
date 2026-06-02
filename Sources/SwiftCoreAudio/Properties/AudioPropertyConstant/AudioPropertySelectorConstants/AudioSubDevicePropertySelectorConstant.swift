//
//  AudioSubDevicePropertySelectorConstant.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

/// Analogous to CoreAudio `kAudioSubDeviceProperty*` selector constants.
///
/// `AudioObjectPropertySelector` values provided by the `AudioSubDevice` class.
public enum AudioSubDevicePropertySelectorConstant {
    // MARK: CoreAudio/AudioHardware.h
    
    /// Extra Latency
    ///
    /// A `Float64` indicating the number of sample frames to add to or subtract from
    /// the latency compensation used for this `AudioSubDevice`.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioSubDevicePropertyExtraLatency`
    case extraLatency
    
    /// Drift Compensation
    ///
    /// A `UInt32` where a value of `0` indicates that no drift compensation should be
    /// done for this `AudioSubDevice` and a value of `1` means that it should.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioSubDevicePropertyDriftCompensation`
    case driftCompensation
    
    /// Drift Compensation Quality
    ///
    /// A `UInt32` that controls the trade-off between quality and CPU load in the
    /// drift compensation. The range of values is from `0` to `127`, where the lower
    /// the number, the worse the quality but also the less CPU is used to do the
    /// compensation.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioSubDevicePropertyDriftCompensationQuality`
    case driftCompensationQuality
}

extension AudioSubDevicePropertySelectorConstant: AudioPropertySelectorConstant { }

extension AudioSubDevicePropertySelectorConstant: Equatable { }

extension AudioSubDevicePropertySelectorConstant: Hashable { }

extension AudioSubDevicePropertySelectorConstant: CaseIterable { }

extension AudioSubDevicePropertySelectorConstant: Sendable { }

// MARK: - Inits

extension AudioSubDevicePropertySelectorConstant {
    /// Same as ``init(rawValue:)`` but throws an error instead of returning `nil` when a match is not found.
    nonisolated
    public init(tryingRawValue rawValue: FourCharCode) throws(SwiftCoreAudioError) { // a.k.a. UInt32
        guard let match = Self(rawValue: rawValue) else {
            throw .notYetImplemented(
                message: "Unhandled/unrecognized audio subdevice property selector constant value: \(rawValue)"
            )
        }
        self = match
    }
}

// MARK: - RawRepresentable

extension AudioSubDevicePropertySelectorConstant: RawRepresentable {
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
        case .extraLatency: kAudioSubDevicePropertyExtraLatency // "xltc"
        case .driftCompensation: kAudioSubDevicePropertyDriftCompensation // "drft"
        case .driftCompensationQuality: kAudioSubDevicePropertyDriftCompensationQuality // "drfq"
        }
    }
}

extension AudioSubDevicePropertySelectorConstant: CustomStringConvertible {
    nonisolated
    public var description: String {
        switch self {
        // MARK: CoreAudio/AudioHardware.h
        case .extraLatency: "Extra Latency"
        case .driftCompensation: "Drift Compensation"
        case .driftCompensationQuality: "Drift Compensation Quality"
        }
    }
}

// MARK: - Static Constructors

extension AudioPropertySelectorConstant where Self == AudioSubDevicePropertySelectorConstant {
    /// Analogous to CoreAudio `kAudioSubDeviceProperty*` selector constants.
    ///
    /// `AudioObjectPropertySelector` values provided by the `AudioSubDevice` class.
    public static func subDevice(_ selector: Self) -> Self {
        selector
    }
}

#endif
