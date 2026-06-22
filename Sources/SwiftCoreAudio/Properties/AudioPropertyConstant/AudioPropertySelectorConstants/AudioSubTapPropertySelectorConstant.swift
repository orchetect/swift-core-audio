//
//  AudioSubTapPropertySelectorConstant.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

/// Analogous to CoreAudio `kAudioSubTapProperty*` selector constants.
///
/// `AudioObjectPropertySelector` values provided by the `AudioSubTap` class.
public enum AudioSubTapPropertySelectorConstant {
    // MARK: CoreAudio/AudioHardware.h

    /// A `Float64` indicating the number of sample frames to add to or subtract from
    /// the latency compensation used for this `AudioSubTap`.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioSubTapPropertyExtraLatency`
    case extraLatency

    /// A `UInt32` where a value of `0` indicates that no drift compensation should be
    /// done for this `AudioSubTap` and a value of `1` means that it should.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioSubTapPropertyDriftCompensation`
    case driftCompensation

    /// A `UInt32` that controls the trade-off between quality and CPU load in the
    /// drift compensation. The range of values is from `0` to `127`, where the lower
    /// the number, the worse the quality but also the less CPU is used to do the
    /// compensation.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioSubTapPropertyDriftCompensationQuality`
    case driftCompensationQuality
}

extension AudioSubTapPropertySelectorConstant: AudioPropertySelectorConstant { }

extension AudioSubTapPropertySelectorConstant: Equatable { }

extension AudioSubTapPropertySelectorConstant: Hashable { }

extension AudioSubTapPropertySelectorConstant: CaseIterable { }

extension AudioSubTapPropertySelectorConstant: Sendable { }

// MARK: - Inits

extension AudioSubTapPropertySelectorConstant {
    /// Same as ``init(rawValue:)`` but throws an error instead of returning `nil` when a match is not found.
    nonisolated
    public init(tryingRawValue rawValue: FourCharCode) throws(SwiftCoreAudioError) { // a.k.a. UInt32
        guard let match = Self(rawValue: rawValue) else {
            throw .notYetImplemented(
                message: "Unhandled/unrecognized audio subtap property selector constant value: \(rawValue)"
            )
        }
        self = match
    }
}

// MARK: - RawRepresentable

extension AudioSubTapPropertySelectorConstant: RawRepresentable {
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

        case .extraLatency: kAudioSubTapPropertyExtraLatency // "xltc"
        case .driftCompensation: kAudioSubTapPropertyDriftCompensation // "drft"
        case .driftCompensationQuality: kAudioSubTapPropertyDriftCompensationQuality // "drfq"
        }
    }
}

extension AudioSubTapPropertySelectorConstant: CustomStringConvertible {
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

extension AudioPropertySelectorConstant where Self == AudioSubTapPropertySelectorConstant {
    /// Analogous to CoreAudio `kAudioSubTapProperty*` selector constants.
    ///
    /// `AudioObjectPropertySelector` values provided by the `AudioSubTap` class.
    public static func subTap(_ selector: Self) -> Self {
        selector
    }
}

#endif
