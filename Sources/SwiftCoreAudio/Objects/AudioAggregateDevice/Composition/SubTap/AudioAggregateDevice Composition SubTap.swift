//
//  AudioAggregateDevice Composition SubTap.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import Foundation

extension AudioAggregateDevice.Composition {
    /// Audio subtap descriptor used in an aggregate audio device composition data structure.
    /// A wrapper around the `CFDictionary` that is used.
    public struct SubTap {
        // MARK: CoreAudio/AudioHardware.h

        /// A `String` that contains the UID of the tap.
        ///
        /// The underlying type is `CFString`.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioSubTapUIDKey`
        nonisolated
        public var uid: AudioTap.UID?

        /// Total number of frames of additional latency that will be added to the input side of the
        /// subtap.
        ///
        /// The underlying type is `CFNumber`.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioSubTapExtraInputLatencyKey`
        nonisolated
        public var extraInputLatency: Double?

        /// Total number of frames of additional latency that will be added to the output side of the
        /// subtap.
        ///
        /// The underlying type is `CFNumber`.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioSubTapExtraOutputLatencyKey`
        nonisolated
        public var extraOutputLatency: Double?

        /// A boolean value describing whether drift compensation is enabled for the subtap.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioSubTapDriftCompensationKey`
        nonisolated
        public var isDriftCompensationEnabled: Bool?

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
        nonisolated
        public var driftCompensationQuality: AudioAggregateDevice.DriftCompensationQuality?

        /// Unknown properties.
        nonisolated(unsafe)
        public var unknownProperties: [NSString: NSObject] = [:]

        public init(
            uid: AudioTap.UID? = nil,
            extraInputLatency: Double? = nil,
            extraOutputLatency: Double? = nil,
            isDriftCompensationEnabled: Bool? = nil,
            driftCompensationQuality: AudioAggregateDevice.DriftCompensationQuality? = nil,
            unknownProperties: [NSString: NSObject] = [:]
        ) {
            self.uid = uid
            self.extraInputLatency = extraInputLatency
            self.extraOutputLatency = extraOutputLatency
            self.isDriftCompensationEnabled = isDriftCompensationEnabled
            self.driftCompensationQuality = driftCompensationQuality
            self.unknownProperties = unknownProperties
        }
    }
}

extension AudioAggregateDevice.Composition.SubTap: Equatable { }

extension AudioAggregateDevice.Composition.SubTap: Hashable { }

extension AudioAggregateDevice.Composition.SubTap: Sendable { }

// MARK: - Serialization

extension AudioAggregateDevice.Composition.SubTap {
    /// Initialize by decoding a `[String: Any]` dictionary representation of the `CFDictionary` used by
    /// Core Audio for aggregate audio device configuration.
    nonisolated
    public init(dictionary: [String: Any]) {
        let cfDict = dictionary as CFDictionary
        self.init(dictionary: cfDict)
    }

    /// Initialize by decoding a `CFDictionary` used by Core Audio for aggregate audio device
    /// configuration.
    nonisolated
    public init(dictionary: CFDictionary) {
        for (keyAny, valueAny) in dictionary as NSDictionary {
            do throws(SwiftCoreAudioError) {
                // Type key as string and form an enum case

                guard let keyString = keyAny as? String else {
                    throw .invalidAggregateConfiguration(
                        message: "Encountered invalid subtap composition dictionary key type: \(type(of: keyAny)) (\(keyAny))."
                    )
                }

                guard let key = Key(rawValue: keyString) else {
                    throw .invalidAggregateConfiguration(
                        message: "Encountered unrecognized subtap composition dictionary key: \(keyString)."
                    )
                }

                // Value typing

                func castValue<T>(as valueType: T.Type) throws(SwiftCoreAudioError) -> T {
                    guard let value = valueAny as? T else {
                        throw .invalidAggregateConfiguration(
                            message: "Encountered unrecognized subtap composition dictionary value \(valueAny) for key \(keyString)."
                        )
                    }
                    return value
                }

                func boolValue() throws(SwiftCoreAudioError) -> Bool {
                    let value = try castValue(as: NSNumber.self) // allows Int and Bool when traversing non-CF dictionary
                    return value != 0
                }

                func cfDictionaryArrayValue() throws(SwiftCoreAudioError) -> [NSDictionary] {
                    guard let value = valueAny as? NSArray, let array = value as? [NSDictionary] else {
                        throw .invalidAggregateConfiguration(
                            message: "Encountered unrecognized subtap composition dictionary value \(valueAny) for key \(keyString)."
                        )
                    }
                    return array
                }

                // Convert values

                switch key {
                case .uid:
                    let value = try castValue(as: String.self)
                    uid = AudioTap.UID(rawValue: value)
                case .extraInputLatency:
                    extraInputLatency = try castValue(as: Float64.self)
                case .extraOutputLatency:
                    extraOutputLatency = try castValue(as: Float64.self)
                case .isDriftCompensationEnabled:
                    isDriftCompensationEnabled = try boolValue()
                case .driftCompensationQuality:
                    let value = try UInt32(castValue(as: Int.self))
                    let quality = try AudioAggregateDevice.DriftCompensationQuality(tryingRawValue: value)
                    driftCompensationQuality = quality
                }
            } catch {
                if let key = keyAny as? NSString, let value = valueAny as? NSObject {
                    unknownProperties[key] = value
                } else {
                    assertionFailure("Aggregate device subtap composition dictionary is not a valid dictionary.")
                }
            }
        }
    }

    /// Converts the instance to a `[String: Any]` dictionary representation of the `CFDictionary` used by
    /// Core Audio for aggregate audio device configuration.
    nonisolated
    public func dictionary() -> [String: Any] {
        var dict: [String: Any] = [:]

        for key in Key.allCases {
            switch key {
            case .uid:
                dict[key.rawValue] = uid?.rawValue
            case .extraInputLatency:
                dict[key.rawValue] = extraInputLatency
            case .extraOutputLatency:
                dict[key.rawValue] = extraOutputLatency
            case .isDriftCompensationEnabled:
                dict[key.rawValue] = isDriftCompensationEnabled
            case .driftCompensationQuality:
                dict[key.rawValue] = if let v = driftCompensationQuality?.rawValue { Int(v) } else { nil }
            }
        }

        dict.merge(unknownProperties as [String: Any]) { _, new in new }

        return dict
    }

    /// Converts the instance to a `CFDictionary` used by Core Audio for aggregate audio device
    /// configuration.
    nonisolated
    public func cfDictionary() -> CFDictionary {
        var dict: [String: Any] = [:]

        for key in Key.allCases {
            switch key {
            case .uid:
                dict[key.rawValue] = uid?.rawValue
            case .extraInputLatency:
                dict[key.rawValue] = extraInputLatency as NSNumber?
            case .extraOutputLatency:
                dict[key.rawValue] = extraOutputLatency as NSNumber?
            case .isDriftCompensationEnabled:
                dict[key.rawValue] = isDriftCompensationEnabled as NSNumber?
            case .driftCompensationQuality:
                dict[key.rawValue] = driftCompensationQuality?.rawValue as NSNumber?
            }
        }

        dict.merge(unknownProperties as [String: Any]) { _, new in new }

        return dict as CFDictionary
    }
}

#endif
