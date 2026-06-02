//
//  AudioAggregateDevice Composition SubDevice Key.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import Foundation

extension AudioAggregateDevice.Composition.SubDevice {
    /// Aggregate audio device subdevice composition dictionary property keys.
    ///
    /// CoreAudio `kAudioSubDevice*Key` constants.
    public enum Key {
        // MARK: CoreAudio/AudioHardware.h
        
        /// A `String` that contains the UID of the subdevice.
        ///
        /// The underlying type is `CFString`.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioSubDeviceUIDKey`
        case uid
        
        /// A `String` that contains the human readable name of the subdevice.
        ///
        /// The underlying type is `CFString`.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioSubDeviceNameKey`
        case name
        
        /// Total number of input channels for the subdevice.
        ///
        /// The underlying type is `CFNumber`.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioSubDeviceInputChannelsKey`
        case inputChannels
        
        /// Total number of output channels for the subdevice.
        ///
        /// The underlying type is `CFNumber`.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioSubDeviceOutputChannelsKey`
        case outputChannels
        
        /// Total number of frames of additional latency that will be added to the input side of the
        /// subdevice.
        ///
        /// The underlying type is `CFNumber` containing a `Float64`.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioSubDeviceExtraInputLatencyKey`
        case extraInputLatency
        
        /// Total number of frames of additional latency that will be added to the output side of the
        /// subdevice.
        ///
        /// The underlying type is `CFNumber` containing a `Float64`.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioSubDeviceExtraOutputLatencyKey`
        case extraOutputLatency
        
        /// A boolean value describing whether drift compensation is enabled for the subdevice.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioSubDeviceDriftCompensationKey`
        case isDriftCompensationEnabled
        
        /// Quality of the drift compensation for the subdevice.
        ///
        /// This value controls the trade-off between quality and CPU load in the drift compensation.
        /// The range of values is from `0` to `127`, where the lower the number, the worse the
        /// quality but also the less CPU is used to do the compensation.
        ///
        /// The underlying type is `CFNumber`.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioSubDeviceDriftCompensationQualityKey`
        case driftCompensationQuality
        
        // MARK: Other
        
        /// Don't pad.
        ///
        /// Discovered in composition dictionary of aggregates found in the system.
        /// Not documented in Core Audio headers.
        /// 
        /// The underlying type is boolean stored as a `CFNumber`.
        ///
        /// > Constant: "don't pad" string literal
        case dontPad
        
        /// Drift algorithm.
        ///
        /// Discovered in composition dictionary of aggregates found in the system.
        /// Not documented in Core Audio headers.
        ///
        /// The underlying type is `CFNumber`.
        ///
        /// > Constant: "drift algorithm" string literal
        case driftAlgorithm
    }
}

extension AudioAggregateDevice.Composition.SubDevice.Key: Equatable { }

extension AudioAggregateDevice.Composition.SubDevice.Key: Hashable { }

extension AudioAggregateDevice.Composition.SubDevice.Key: CaseIterable { }

extension AudioAggregateDevice.Composition.SubDevice.Key: Sendable { }

// MARK: - Inits

extension AudioAggregateDevice.Composition.SubDevice.Key {
    /// Same as ``init(rawValue:)`` but throws an error instead of returning `nil` when a match is not found.
    nonisolated
    public init(tryingRawValue rawValue: String) throws(SwiftCoreAudioError) {
        guard let match = Self(rawValue: rawValue) else {
            throw .notYetImplemented(
                message: "Unhandled/unrecognized aggregate audio device subdevice composition dictionary key constant value: \(rawValue)"
            )
        }
        self = match
    }
}

// MARK: - RawRepresentable

extension AudioAggregateDevice.Composition.SubDevice.Key: RawRepresentable {
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
        case .uid: kAudioSubDeviceUIDKey // "uid"
        case .name: kAudioSubDeviceNameKey // "name"
        case .inputChannels: kAudioSubDeviceInputChannelsKey // "channels-in"
        case .outputChannels: kAudioSubDeviceOutputChannelsKey // "channels-out"
        case .extraInputLatency: kAudioSubDeviceExtraInputLatencyKey // "latency-in"
        case .extraOutputLatency: kAudioSubDeviceExtraOutputLatencyKey // "latency-out"
        case .isDriftCompensationEnabled: kAudioSubDeviceDriftCompensationKey // "drift"
        case .driftCompensationQuality: kAudioSubDeviceDriftCompensationQualityKey // "drift quality"
        // MARK: Other
        case .dontPad: "don't pad"
        case .driftAlgorithm: "drift algorithm"
        }
    }
}

extension AudioAggregateDevice.Composition.SubDevice.Key: CustomStringConvertible {
    nonisolated
    public var description: String {
        switch self {
        // MARK: CoreAudio/AudioHardware.h
        case .uid: "UID"
        case .name: "Name"
        case .inputChannels: "Input Channel Count"
        case .outputChannels: "Output Channel Count"
        case .extraInputLatency: "Extra Input Latency"
        case .extraOutputLatency: "Extra Output Latency"
        case .isDriftCompensationEnabled: "Is Drift Compensation Enabled"
        case .driftCompensationQuality: "Drift Compensation Quality"
        // MARK: Other
        case .dontPad: "Don't Pad"
        case .driftAlgorithm: "Drift Algorithm"
        }
    }
}

#endif
