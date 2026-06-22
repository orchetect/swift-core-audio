//
//  AudioAggregateDevice Composition SubTap Key.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import Foundation

extension AudioAggregateDevice.Composition.SubTap {
    /// Aggregate audio device subtap composition dictionary property keys.
    ///
    /// CoreAudio `kAudioSubTap*Key` constants.
    public enum Key {
        // MARK: CoreAudio/AudioHardware.h

        /// A `String` that contains the UID of the subtap.
        ///
        /// The underlying type is `CFString`.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioSubTapUIDKey`
        case uid

        /// Total number of frames of additional latency that will be added to the input side of the
        /// subtap.
        ///
        /// The underlying type is `CFNumber`.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioSubTapExtraInputLatencyKey`
        case extraInputLatency

        /// Total number of frames of additional latency that will be added to the output side of the
        /// subtap.
        ///
        /// The underlying type is `CFNumber`.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioSubTapExtraOutputLatencyKey`
        case extraOutputLatency

        /// A boolean value describing whether drift compensation is enabled for the subtap.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioSubTapDriftCompensationKey`
        case isDriftCompensationEnabled

        /// Quality of the drift compensation for the subtap.
        ///
        /// This value controls the trade-off between quality and CPU load in the drift compensation.
        /// The range of values is from `0` to `127`, where the lower the number, the worse the
        /// quality but also the less CPU is used to do the compensation.
        ///
        /// The underlying type is `CFNumber`.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioSubTapDriftCompensationQualityKey`
        case driftCompensationQuality
    }
}

extension AudioAggregateDevice.Composition.SubTap.Key: Equatable { }

extension AudioAggregateDevice.Composition.SubTap.Key: Hashable { }

extension AudioAggregateDevice.Composition.SubTap.Key: CaseIterable { }

extension AudioAggregateDevice.Composition.SubTap.Key: Sendable { }

// MARK: - Inits

extension AudioAggregateDevice.Composition.SubTap.Key {
    /// Same as ``init(rawValue:)`` but throws an error instead of returning `nil` when a match is not found.
    nonisolated
    public init(tryingRawValue rawValue: String) throws(SwiftCoreAudioError) {
        guard let match = Self(rawValue: rawValue) else {
            throw .notYetImplemented(
                message: "Unhandled/unrecognized aggregate audio device subtap composition dictionary key constant value: \(rawValue)"
            )
        }
        self = match
    }
}

// MARK: - RawRepresentable

extension AudioAggregateDevice.Composition.SubTap.Key: RawRepresentable {
    nonisolated
    public init?(rawValue: String) {
        guard let match = Self.allCases
            .first(where: { $0.rawValue == rawValue })
        else {
            return nil
        }
        self = match
    }

    nonisolated
    public var rawValue: String {
        switch self {
        // MARK: CoreAudio/AudioHardware.h

        case .uid: kAudioSubTapUIDKey // "uid"
        case .extraInputLatency: kAudioSubTapExtraInputLatencyKey // "latency-in"
        case .extraOutputLatency: kAudioSubTapExtraOutputLatencyKey // "latency-out"
        case .isDriftCompensationEnabled: kAudioSubTapDriftCompensationKey // "drift"
        case .driftCompensationQuality: kAudioSubTapDriftCompensationQualityKey // "drift quality"
        }
    }
}

extension AudioAggregateDevice.Composition.SubTap.Key: CustomStringConvertible {
    nonisolated
    public var description: String {
        switch self {
        // MARK: CoreAudio/AudioHardware.h

        case .uid: "UID"
        case .extraInputLatency: "Extra Input Latency"
        case .extraOutputLatency: "Extra Output Latency"
        case .isDriftCompensationEnabled: "Is Drift Compensation Enabled"
        case .driftCompensationQuality: "Drift Compensation Quality"
        }
    }
}

#endif
