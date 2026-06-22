//
//  AudioAggregateDevice DriftCompensationQuality.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import Foundation

extension AudioAggregateDevice {
    /// Drift compensation quality settings used in an aggregate audio device composition data structure.
    /// This setting is relevant for both subdevices and taps.
    ///
    /// It is a continuous range from 0 to 127.
    public struct DriftCompensationQuality {
        /// Raw value is a continuous range from 0 to 127.
        public let rawValue: UInt32

        /// Internal:
        /// Init for static constructors.
        init(unsafe rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
}

extension AudioAggregateDevice.DriftCompensationQuality: Equatable { }

extension AudioAggregateDevice.DriftCompensationQuality: Hashable { }

extension AudioAggregateDevice.DriftCompensationQuality: Sendable { }

// MARK: - Inits

extension AudioAggregateDevice.DriftCompensationQuality {
    /// Same as ``init(rawValue:)`` but throws an error instead of returning `nil` when a match is not found.
    nonisolated
    public init(tryingRawValue rawValue: UInt32) throws(SwiftCoreAudioError) {
        guard let instance = Self(rawValue: rawValue) else {
            throw .invalidAggregateConfiguration(
                message: "Encountered an invalid value for drift compensation quality: \(rawValue). Value must be in the range 0...127."
            )
        }
        self = instance
    }
}

// MARK: - RawRepresentable

extension AudioAggregateDevice.DriftCompensationQuality: RawRepresentable {
    public init?(rawValue: UInt32) {
        guard (0 ... 127).contains(rawValue) else { return nil }
        self.rawValue = rawValue
    }
}

// MARK: - Static Constructors

extension AudioAggregateDevice.DriftCompensationQuality {
    /// Minimum quality.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioAggregateDriftCompensationMinQuality`
    public static var minimum: Self {
        Self(unsafe: kAudioAggregateDriftCompensationMinQuality)
    }

    /// Low quality.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioAggregateDriftCompensationLowQuality`
    public static var low: Self {
        Self(unsafe: kAudioAggregateDriftCompensationLowQuality)
    }

    /// Medium quality.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioAggregateDriftCompensationMediumQuality`
    public static var medium: Self {
        Self(unsafe: kAudioAggregateDriftCompensationMediumQuality)
    }

    /// High quality.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioAggregateDriftCompensationHighQuality`
    public static var high: Self {
        Self(unsafe: kAudioAggregateDriftCompensationHighQuality)
    }

    /// Maximum quality.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioAggregateDriftCompensationMaxQuality`
    public static var maximum: Self {
        Self(unsafe: kAudioAggregateDriftCompensationMaxQuality)
    }
}

#endif
