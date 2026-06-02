//
//  AudioAggregateDevice Composition Key.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import Foundation

extension AudioAggregateDevice.Composition {
    /// Aggregate audio device composition dictionary property keys.
    ///
    /// CoreAudio `kAudioAggregateDevice*Key` constants.
    public enum Key {
        // MARK: CoreAudio/AudioHardware.h
        
        /// A `String` that contains the UID of the aggregate device.
        ///
        /// The underlying type is `CFString`.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioAggregateDeviceUIDKey`
        case uid
        
        /// A `String` that contains the human readable name of the aggregate device.
        ///
        /// The underlying type is `CFString`.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioAggregateDeviceNameKey`
        case name
        
        /// Subdevices that are included in the aggregate device.
        ///
        /// The underlying type is a `CFArray` of `CFDictionaries` that describe each sub-device
        /// in the `AudioAggregateDevice`. The keys for this `CFDictionary` are defined in the
        /// `AudioSubDevice` section.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioAggregateDeviceSubDeviceListKey`
        case subdevices
        
        /// A `String` that contains the UID for the sub-device that is the time source for the
        /// aggregate device.
        ///
        /// The underlying type is `CFString`.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioAggregateDeviceMainSubDeviceKey`
        case mainSubdeviceUID
        
        /// A `String` that contains the UID for the clock device that is the time source for the
        /// aggregate device.
        ///
        /// If the aggregate device includes both a main audio device and a clock device, the clock
        /// device will control the time base.
        ///
        /// The underlying type is `CFString`.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioAggregateDeviceClockDeviceKey`
        case clockUID
        
        /// A boolean value where `true` makes the the aggregate device published to the entire system,
        /// and `false` makes it private to the process that created it.
        ///
        /// The default is `false` if this key is not present or specified.
        ///
        /// The underlying type is a `CFNumber` with a value of `1` or `0`.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioAggregateDeviceIsPrivateKey`
        case isPrivate
        
        /// A boolean value describing whether the sub-devices of the aggregate device are arranged
        /// such that the output streams are all fed the same data or not.
        ///
        /// The underlying type is a `CFNumber` with a value of `1` or `0`.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioAggregateDeviceIsStackedKey`
        case isStacked
        
        /// Taps that are included in the aggregate device.
        ///
        /// The underlying type is a `CFArray` of `CFDictionaries` that describe each tap
        /// in the `AudioAggregateDevice`. The keys for this `CFDictionary` are defined in the
        /// `AudioTap` section.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioAggregateDeviceTapListKey`
        case taps
        
        /// A boolean value describing whether the aggregate device’s start should wait for the first
        /// tap that receives audio.
        ///
        /// When this key is used, calling `AudioDeviceStart` with the aggregate device will wait
        /// until a tapped process begins receiving its first audio from any tapped applications.
        /// The composition must also include the ``isPrivate`` key so that the aggregate is private
        /// to the process that created it.
        ///
        /// The underlying type is a `CFNumber` where a value of `0` is considered `false` and a
        /// non-`0` value is considered `true`.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioAggregateDeviceTapAutoStartKey`
        case isTapAutoStartEnabled
        
        // MARK: Other
        
        /// Vocal isolation type.
        ///
        /// Discovered in composition dictionary of aggregates found in the system.
        /// Not documented in Core Audio headers.
        ///
        /// The underlying type is `CFNumber`.
        ///
        /// > Constant: "vocal isolation type" string literal
        case vocalIsolationType
    }
}

extension AudioAggregateDevice.Composition.Key: Equatable { }

extension AudioAggregateDevice.Composition.Key: Hashable { }

extension AudioAggregateDevice.Composition.Key: CaseIterable { }

extension AudioAggregateDevice.Composition.Key: Sendable { }

// MARK: - Inits

extension AudioAggregateDevice.Composition.Key {
    /// Same as ``init(rawValue:)`` but throws an error instead of returning `nil` when a match is not found.
    nonisolated
    public init(tryingRawValue rawValue: String) throws(SwiftCoreAudioError) {
        guard let match = Self(rawValue: rawValue) else {
            throw .notYetImplemented(
                message: "Unhandled/unrecognized aggregate audio device composition dictionary key constant value: \(rawValue)"
            )
        }
        self = match
    }
}

// MARK: - RawRepresentable

extension AudioAggregateDevice.Composition.Key: RawRepresentable {
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
        case .uid: kAudioAggregateDeviceUIDKey // "uid"
        case .name: kAudioAggregateDeviceNameKey // "name"
        case .subdevices: kAudioAggregateDeviceSubDeviceListKey // "subdevices"
        case .mainSubdeviceUID: kAudioAggregateDeviceMainSubDeviceKey // "master"
        case .clockUID: kAudioAggregateDeviceClockDeviceKey // "clock"
        case .isPrivate: kAudioAggregateDeviceIsPrivateKey // "private"
        case .isStacked: kAudioAggregateDeviceIsStackedKey // "stacked"
        case .taps: kAudioAggregateDeviceTapListKey // "taps"
        case .isTapAutoStartEnabled: kAudioAggregateDeviceTapAutoStartKey // "tapautostart"
        // MARK: Other
        case .vocalIsolationType: "vocal isolation type"
        }
    }
}

extension AudioAggregateDevice.Composition.Key: CustomStringConvertible {
    nonisolated
    public var description: String {
        switch self {
        // MARK: CoreAudio/AudioHardware.h
        case .uid: "UID"
        case .name: "Name"
        case .subdevices: "Subdevices"
        case .mainSubdeviceUID: "Main Subdevice UID"
        case .clockUID: "Clock"
        case .isPrivate: "Is Private"
        case .isStacked: "Is Stacked"
        case .taps: "Taps"
        case .isTapAutoStartEnabled: "Tap Auto-Start Enabled"
        // MARK: Other
        case .vocalIsolationType: "Vocal Isolation Type"
        }
    }
}

#endif
