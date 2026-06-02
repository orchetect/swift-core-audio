//
//  AudioAggregateDevice Composition SubDevice.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import Foundation

extension AudioAggregateDevice.Composition {
    /// Audio subdevice descriptor used in an aggregate audio device composition data structure.
    /// A wrapper around the `CFDictionary` that is used.
    public struct SubDevice {
        // MARK: CoreAudio/AudioHardware.h
        
        /// A `String` that contains the UID of the subdevice.
        ///
        /// The underlying type is `CFString`.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioSubDeviceUIDKey`
        nonisolated
        public var uid: AudioSubDevice.UID?
        
        /// A `String` that contains the human readable name of the subdevice.
        ///
        /// The underlying type is `CFString`.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioSubDeviceNameKey`
        nonisolated
        public var name: String?
        
        /// Total number of input channels for the subdevice.
        ///
        /// The underlying type is `CFNumber`.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioSubDeviceInputChannelsKey`
        nonisolated
        public var inputChannelCount: Int?
        
        /// Total number of output channels for the subdevice.
        ///
        /// The underlying type is `CFNumber` containing a `Float64`.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioSubDeviceOutputChannelsKey`
        nonisolated
        public var outputChannelCount: Int?
        
        /// Total number of frames of additional latency that will be added to the input side of the
        /// subdevice.
        ///
        /// The underlying type is `CFNumber` containing a `Float64`.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioSubDeviceExtraInputLatencyKey`
        nonisolated
        public var extraInputLatency: Double?
        
        /// Total number of frames of additional latency that will be added to the output side of the
        /// subdevice.
        ///
        /// The underlying type is `CFNumber` containing a `Float64`.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioSubDeviceExtraOutputLatencyKey`
        nonisolated
        public var extraOutputLatency: Double?
        
        /// A boolean value describing whether drift compensation is enabled for the subdevice.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioSubDeviceDriftCompensationKey`
        nonisolated
        public var isDriftCompensationEnabled: Bool?
        
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
        nonisolated
        public var driftCompensationQuality: AudioAggregateDevice.DriftCompensationQuality?
        
        /// Drift algorithm.
        ///
        /// Discovered in composition dictionary of aggregates found in the system.
        /// Not documented in Core Audio headers.
        ///
        /// > Constant: "drift algorithm" string literal
        nonisolated
        public var driftAlgorithm: Int?
        
        /// Don't pad.
        ///
        /// Discovered in composition dictionary of aggregates found in the system.
        /// Not documented in Core Audio headers.
        ///
        /// > Constant: "don't pad" string literal
        nonisolated
        public var dontPad: Bool?
        
        /// Unknown properties.
        nonisolated(unsafe)
        public var unknownProperties: [NSString: NSObject] = [:]
        
        public init<Device: AudioDeviceProperties>(
            uid: Device.UID? = nil as AudioDevice.UID?,
            name: String? = nil,
            inputChannelCount: Int? = nil,
            outputChannelCount: Int? = nil,
            extraInputLatency: Double? = nil,
            extraOutputLatency: Double? = nil,
            isDriftCompensationEnabled: Bool? = nil,
            driftCompensationQuality: AudioAggregateDevice.DriftCompensationQuality? = nil,
            driftAlgorithm: Int? = nil,
            dontPad: Bool? = nil,
            unknownProperties: [NSString: NSObject] = [:]
        ) {
            self.uid = if let uid { .init(uid.rawValue) } else { nil }
            self.name = name
            self.inputChannelCount = inputChannelCount
            self.outputChannelCount = outputChannelCount
            self.extraInputLatency = extraInputLatency
            self.extraOutputLatency = extraOutputLatency
            self.isDriftCompensationEnabled = isDriftCompensationEnabled
            self.driftCompensationQuality = driftCompensationQuality
            self.driftAlgorithm = driftAlgorithm
            self.dontPad = dontPad
            self.unknownProperties = unknownProperties
        }
    }
}

extension AudioAggregateDevice.Composition.SubDevice: Equatable { }

extension AudioAggregateDevice.Composition.SubDevice: Hashable { }

extension AudioAggregateDevice.Composition.SubDevice: Sendable { }

// MARK: - Serialization

extension AudioAggregateDevice.Composition.SubDevice {
    /// Initialize by decoding a `[String: Any]` dictionary representation of the `CFDictionary` used by
    /// Core Audio for aggregate audio device configuration.
    nonisolated
    public init(dictionary: [String: Any]) {
        let cfDict = dictionary as CFDictionary
        self.init(dictionary: cfDict)
    }
    
    /// Initialize by decoding a `CFDictionary` used by Core Audio for aggregate audio device configuration.
    nonisolated
    public init(dictionary: CFDictionary) {
        for (keyAny, valueAny) in dictionary as NSDictionary {
            do throws(SwiftCoreAudioError) {
                // Type key as string and form an enum case
                
                guard let keyString = keyAny as? String else {
                    throw .invalidAggregateConfiguration(
                        message: "Encountered invalid subdevice composition dictionary key type: \(type(of: keyAny)) (\(keyAny))."
                    )
                }
                
                guard let key = Key(rawValue: keyString) else {
                    throw .invalidAggregateConfiguration(
                        message: "Encountered unrecognized subdevice composition dictionary key: \(keyString)."
                    )
                }
                
                // Value typing
                
                func castValue<T>(as valueType: T.Type) throws(SwiftCoreAudioError) -> T {
                    guard let value = valueAny as? T else {
                        throw .invalidAggregateConfiguration(
                            message: "Encountered unrecognized subdevice composition dictionary value \(valueAny) for key \(keyString)."
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
                            message: "Encountered unrecognized subdevice composition dictionary value \(valueAny) for key \(keyString)."
                        )
                    }
                    return array
                }
                
                // Convert values
                
                switch key {
                case .uid:
                    let value = try castValue(as: String.self)
                    uid = AudioSubDevice.UID(rawValue: value)
                case .name:
                    name = try castValue(as: String.self)
                case .inputChannels:
                    inputChannelCount = try castValue(as: Int.self)
                case .outputChannels:
                    outputChannelCount = try castValue(as: Int.self)
                case .extraInputLatency:
                    extraInputLatency = try castValue(as: Double.self)
                case .extraOutputLatency:
                    extraOutputLatency = try castValue(as: Double.self)
                case .isDriftCompensationEnabled:
                    isDriftCompensationEnabled = try boolValue()
                case .driftCompensationQuality:
                    let value = UInt32(try castValue(as: Int.self))
                    let quality = try AudioAggregateDevice.DriftCompensationQuality(tryingRawValue: value)
                    driftCompensationQuality = quality
                case .driftAlgorithm:
                    driftAlgorithm = try castValue(as: Int.self)
                case .dontPad:
                    dontPad = try boolValue()
                }
            } catch {
                if let key = keyAny as? NSString, let value = valueAny as? NSObject {
                    unknownProperties[key] = value
                } else {
                    assertionFailure("Aggregate device subdevice composition dictionary is not a valid dictionary.")
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
            case .name:
                dict[key.rawValue] = name
            case .inputChannels:
                dict[key.rawValue] = inputChannelCount
            case .outputChannels:
                dict[key.rawValue] = outputChannelCount
            case .extraInputLatency:
                dict[key.rawValue] = extraInputLatency
            case .extraOutputLatency:
                dict[key.rawValue] = extraOutputLatency
            case .isDriftCompensationEnabled:
                dict[key.rawValue] = isDriftCompensationEnabled
            case .driftCompensationQuality:
                dict[key.rawValue] = if let v = driftCompensationQuality?.rawValue { Int(v) } else { nil }
            case .driftAlgorithm:
                dict[key.rawValue] = driftAlgorithm
            case .dontPad:
                dict[key.rawValue] = dontPad
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
            case .name:
                dict[key.rawValue] = name
            case .inputChannels:
                dict[key.rawValue] = inputChannelCount as NSNumber?
            case .outputChannels:
                dict[key.rawValue] = outputChannelCount as NSNumber?
            case .extraInputLatency:
                dict[key.rawValue] = extraInputLatency as NSNumber?
            case .extraOutputLatency:
                dict[key.rawValue] = extraOutputLatency as NSNumber?
            case .isDriftCompensationEnabled:
                dict[key.rawValue] = isDriftCompensationEnabled as NSNumber?
            case .driftCompensationQuality:
                dict[key.rawValue] = driftCompensationQuality?.rawValue as NSNumber?
            case .driftAlgorithm:
                dict[key.rawValue] = driftAlgorithm as NSNumber?
            case .dontPad:
                dict[key.rawValue] = dontPad as NSNumber?
            }
        }
        
        dict.merge(unknownProperties as [String: Any]) { _, new in new }
        
        return dict as CFDictionary
    }
}

#endif
