//
//  AudioAggregateDevice Composition.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import Foundation

extension AudioAggregateDevice {
    /// Aggregate audio device composition.
    /// A wrapper around the `CFDictionary` that is used to configure a Core Audio aggregate device.
    ///
    /// Note that Core Audio requires a UID when creating an aggregate device, and it must be unique
    /// in the system.
    public struct Composition {
        /// A `String` that contains the UID of the aggregate device.
        ///
        /// Note that Core Audio requires a UID when creating an aggregate device, and it must be unique
        /// in the system.
        ///
        /// The underlying type is `CFString`.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioAggregateDeviceUIDKey`
        nonisolated
        public var uid: AudioAggregateDevice.UID?
        
        /// A `String` that contains the human readable name of the aggregate device.
        ///
        /// The underlying type is `CFString`.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioAggregateDeviceNameKey`
        nonisolated
        public var name: String?
        
        /// Subdevices that are included in the aggregate device.
        ///
        /// The underlying type is a `CFArray` of `CFDictionaries` that describe each sub-device
        /// in the `AudioAggregateDevice`. The keys for this `CFDictionary` are defined in the
        /// `AudioSubDevice` section.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioAggregateDeviceSubDeviceListKey`
        nonisolated
        public var subdevices: [SubDevice] = []
        
        /// Taps that are included in the aggregate device.
        ///
        /// The underlying type is a `CFArray` of `CFDictionaries` that describe each tap
        /// in the `AudioAggregateDevice`. The keys for this `CFDictionary` are defined in the
        /// `AudioTap` section.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioAggregateDeviceTapListKey`
        nonisolated
        public var subtaps: [SubTap] = []
        
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
        nonisolated
        public var clockUID: AudioClock.UID?
        
        /// A `String` that contains the UID for the sub-device that is the time source for the
        /// aggregate device. If `nil`, Core Audio will automatically assign the first subdevice as
        /// the main subdevice.
        ///
        /// When an aggregate device has at least one subdevice, Core Audio will automatically assign the
        /// first subdevice to be its main subdevice. You are able to reassign the main subdevice role
        /// to any of the aggregate's subdevices. When an aggregate has no subdevices, it does not have a
        /// main subdevice and one cannot be assigned.
        ///
        /// The underlying type is `CFString`.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioAggregateDeviceMainSubDeviceKey`
        nonisolated
        public var mainSubdeviceUID: AudioSubDevice.UID?
        
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
        nonisolated
        public var isPrivate: Bool?
        
        /// A boolean value describing whether the sub-devices of the aggregate device are arranged
        /// such that the output streams are all fed the same data or not.
        ///
        /// The underlying type is a `CFNumber` with a value of `1` or `0`.
        ///
        /// > File: CoreAudio/AudioHardware.h
        ///
        /// > Constant: `kAudioAggregateDeviceIsStackedKey`
        nonisolated
        public var isStacked: Bool?
        
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
        nonisolated
        public var isTapAutoStartEnabled: Bool?
        
        // MARK: Other
        
        /// Vocal isolation type.
        ///
        /// Discovered in composition dictionary of aggregates found in the system.
        /// Not documented in Core Audio headers.
        ///
        /// > Constant: "vocal isolation type" string literal
        nonisolated
        public var vocalIsolationType: Int?
        
        /// Unknown properties.
        nonisolated(unsafe)
        public var unknownProperties: [NSString: NSObject] = [:]
        
        public init<Clock: AudioClockProperties, MainDevice: AudioDeviceProperties>(
            uid: AudioAggregateDevice.UID? = nil,
            name: String? = nil,
            subdevices: [SubDevice] = [],
            subtaps: [SubTap] = [],
            clockUID: Clock.UID? = nil as AudioClock.UID?,
            mainSubdeviceUID: MainDevice.UID? = nil as AudioSubDevice.UID?,
            isPrivate: Bool? = nil,
            isStacked: Bool? = nil,
            isTapAutoStartEnabled: Bool? = nil,
            vocalIsolationType: Int? = nil,
            unknownProperties: [NSString: NSObject] = [:]
        ) {
            self.uid = uid
            self.name = name
            self.subdevices = subdevices
            self.subtaps = subtaps
            self.clockUID = if let clockUID { .init(rawValue: clockUID.rawValue) } else { nil }
            self.mainSubdeviceUID = if let mainSubdeviceUID { .init(rawValue: mainSubdeviceUID.rawValue) } else { nil }
            self.isPrivate = isPrivate
            self.isStacked = isStacked
            self.isTapAutoStartEnabled = isTapAutoStartEnabled
            self.vocalIsolationType = vocalIsolationType
            self.unknownProperties = unknownProperties
        }
    }
}

extension AudioAggregateDevice.Composition: Equatable { }

extension AudioAggregateDevice.Composition: Hashable { }

extension AudioAggregateDevice.Composition: Sendable { }

// MARK: - Serialization

extension AudioAggregateDevice.Composition {
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
                        message: "Encountered invalid composition dictionary key type: \(type(of: keyAny)) (\(keyAny))."
                    )
                }
                
                guard let key = Key(rawValue: keyString) else {
                    throw .invalidAggregateConfiguration(
                        message: "Encountered unrecognized composition dictionary key: \(keyString)."
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
                    guard let value = valueAny as? NSNumber else { // allows Int and Bool when traversing non-CF dictionary
                        throw .invalidAggregateConfiguration(
                            message: "Encountered unrecognized composition dictionary value \(valueAny) for key \(keyString)."
                        )
                    }
                    return value != 0
                }
                
                func stringValue() throws(SwiftCoreAudioError) -> String {
                    guard let value = valueAny as? String else {
                        throw .invalidAggregateConfiguration(
                            message: "Encountered unrecognized composition dictionary value \(valueAny) for key \(keyString)."
                        )
                    }
                    return value
                }
                
                func cfDictionaryArrayValue() throws(SwiftCoreAudioError) -> [NSDictionary] {
                    guard let value = valueAny as? NSArray, let array = value as? [NSDictionary] else {
                        throw .invalidAggregateConfiguration(
                            message: "Encountered unrecognized composition dictionary value \(valueAny) for key \(keyString)."
                        )
                    }
                    return array
                }
                
                // Convert values
                
                switch key {
                case .uid:
                    let value = try stringValue()
                    uid = AudioAggregateDevice.UID(rawValue: value)
                case .name:
                    name = try stringValue()
                case .subdevices:
                    let value = try cfDictionaryArrayValue()
                    var mapped: [SubDevice] = []
                    for dict in value {
                        let subdevice = SubDevice(dictionary: dict)
                        mapped.append(subdevice)
                    }
                    assert(value.count == mapped.count)
                    subdevices = mapped
                case .taps:
                    let value = try cfDictionaryArrayValue()
                    var mapped: [SubTap] = []
                    for dict in value {
                        let subtap = SubTap(dictionary: dict)
                        mapped.append(subtap)
                    }
                    assert(value.count == mapped.count)
                    subtaps = mapped
                case .clockUID:
                    let value = try stringValue()
                    clockUID = AudioClock.UID(rawValue: value)
                case .mainSubdeviceUID:
                    let value = try stringValue()
                    mainSubdeviceUID = AudioSubDevice.UID(rawValue: value)
                case .isPrivate:
                    isPrivate = try boolValue()
                case .isStacked:
                    isStacked = try boolValue()
                case .isTapAutoStartEnabled:
                    isTapAutoStartEnabled = try boolValue()
                case .vocalIsolationType:
                    vocalIsolationType = try castValue(as: Int.self)
                }
            } catch {
                if let key = keyAny as? NSString, let value = valueAny as? NSObject {
                    unknownProperties[key] = value
                } else {
                    assertionFailure("Aggregate device composition dictionary is not a valid dictionary.")
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
            case .subdevices:
                let mapped = subdevices.map { $0.dictionary() }
                dict[key.rawValue] = mapped.isEmpty ? nil : mapped
            case .taps:
                let mapped = subtaps.map { $0.dictionary() }
                dict[key.rawValue] = mapped.isEmpty ? nil : mapped
            case .clockUID:
                dict[key.rawValue] = clockUID?.rawValue
            case .mainSubdeviceUID:
                dict[key.rawValue] = mainSubdeviceUID?.rawValue
            case .isPrivate:
                dict[key.rawValue] = isPrivate
            case .isStacked:
                dict[key.rawValue] = isStacked
            case .isTapAutoStartEnabled:
                dict[key.rawValue] = isTapAutoStartEnabled
            case .vocalIsolationType:
                dict[key.rawValue] = vocalIsolationType
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
            case .subdevices:
                let mapped = subdevices.map { $0.cfDictionary() } as NSArray
                dict[key.rawValue] = mapped.count == 0 ? nil : mapped
            case .taps:
                let mapped = subtaps.map { $0.cfDictionary() } as NSArray
                dict[key.rawValue] = mapped.count == 0 ? nil : mapped
            case .clockUID:
                dict[key.rawValue] = clockUID?.rawValue
            case .mainSubdeviceUID:
                dict[key.rawValue] = mainSubdeviceUID?.rawValue
            case .isPrivate:
                dict[key.rawValue] = isPrivate as NSNumber?
            case .isStacked:
                dict[key.rawValue] = isStacked as NSNumber?
            case .isTapAutoStartEnabled:
                dict[key.rawValue] = isTapAutoStartEnabled as NSNumber?
            case .vocalIsolationType:
                dict[key.rawValue] = vocalIsolationType as NSNumber?
            }
        }
        
        dict.merge(unknownProperties as [String: Any]) { _, new in new }
        
        return dict as CFDictionary
    }
}

#endif
