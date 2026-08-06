//
//  AudioObject+PropertyValue.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import Foundation

// MARK: - Property Status

extension AudioObject {
    /// Queries an audio object and returns a boolean value indicating whether the given
    /// property exists or not.
    ///
    /// Note that a return value of `true` is not a guarantee that attempting to get the
    /// property's size or data will succeed.
    nonisolated
    public func getHasProperty(
        property: some AudioPropertyProtocol
    ) -> Bool {
        getHasProperty(address: property.address)
    }
}

// MARK: - AudioChannelLayout

extension AudioObject {
    // MARK: Get

    /// Queries the audio object to return the `AudioChannelLayout` value for the given property.
    nonisolated
    public func getPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == AudioChannelLayout, Property.Qualifier == Never {
        try getPropertyValue(property: property, qualifier: .none, osStatusErrorMessage: osStatusErrorMessage)
    }

    /// Queries the audio object to return the `AudioChannelLayout` value for the given property.
    nonisolated
    public func getPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        qualifier: AudioPropertyQualifier<Property.Qualifier>,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == AudioChannelLayout {
        var value = AudioChannelLayout()
        try getPropertyValue(address: property.address, value: &value, qualifier: qualifier, osStatusErrorMessage: osStatusErrorMessage)
        return value
    }

    // MARK: Set

    // implement as-needed in future
}

// MARK: - AudioStreamBasicDescription

extension AudioObject {
    // MARK: Get

    /// Queries the audio object to return the `AudioStreamBasicDescription` value for the given property.
    nonisolated
    public func getPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == AudioStreamBasicDescription, Property.Qualifier == Never {
        try getPropertyValue(property: property, qualifier: .none, osStatusErrorMessage: osStatusErrorMessage)
    }

    /// Queries the audio object to return the `AudioStreamBasicDescription` value for the given property.
    nonisolated
    public func getPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        qualifier: AudioPropertyQualifier<Property.Qualifier>,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == AudioStreamBasicDescription {
        var value = AudioStreamBasicDescription()
        try getPropertyValue(address: property.address, value: &value, qualifier: qualifier, osStatusErrorMessage: osStatusErrorMessage)
        return value
    }

    // MARK: Set

    // implement as-needed in future
}

// MARK: - [AudioStreamRangedDescription]

extension AudioObject {
    // MARK: Get

    /// Queries the audio object to return the `[RangedDescription]` value for the given property.
    nonisolated
    public func getPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == [AudioStreamRangedDescription], Property.Qualifier == Never {
        try getPropertyValue(property: property, qualifier: .none, osStatusErrorMessage: osStatusErrorMessage)
    }

    /// Queries the audio object to return the `[RangedDescription]` value for the given property.
    nonisolated
    public func getPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        qualifier: AudioPropertyQualifier<Property.Qualifier>,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == [AudioStreamRangedDescription] {
        let element = AudioStreamRangedDescription()
        let array = try getPropertyArrayValue(
            address: property.address,
            newElement: element,
            qualifier: qualifier,
            osStatusErrorMessage: osStatusErrorMessage
        )
        return array
    }

    // MARK: Set

    // implement as-needed in future
}

// MARK: - AudioValueRange

extension AudioObject {
    // MARK: Get

    /// Queries the audio object to return the `AudioValueRange` value for the given property.
    nonisolated
    public func getPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == AudioValueRange, Property.Qualifier == Never {
        try getPropertyValue(property: property, qualifier: .none, osStatusErrorMessage: osStatusErrorMessage)
    }

    /// Queries the audio object to return the `AudioStreamBasicDescription` value for the given property.
    nonisolated
    public func getPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        qualifier: AudioPropertyQualifier<Property.Qualifier>,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == AudioValueRange {
        var value = AudioValueRange()
        try getPropertyValue(address: property.address, value: &value, qualifier: qualifier, osStatusErrorMessage: osStatusErrorMessage)
        return value
    }

    // MARK: Set

    // implement as-needed in future
}

// MARK: - [AudioValueRange]

extension AudioObject {
    // MARK: Get

    /// Queries the audio object to return the `[AudioValueRange]` value for the given property.
    nonisolated
    public func getPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == [AudioValueRange], Property.Qualifier == Never {
        try getPropertyValue(property: property, qualifier: .none, osStatusErrorMessage: osStatusErrorMessage)
    }

    /// Queries the audio object to return the `[AudioValueRange]` value for the given property.
    nonisolated
    public func getPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        qualifier: AudioPropertyQualifier<Property.Qualifier>,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == [AudioValueRange] {
        let element = AudioValueRange()
        let array = try getPropertyArrayValue(
            address: property.address,
            newElement: element,
            qualifier: qualifier,
            osStatusErrorMessage: osStatusErrorMessage
        )
        return array
    }

    // MARK: Set

    // implement as-needed in future
}

// MARK: - Bool

extension AudioObject {
    // MARK: Get

    /// Queries the audio object to return the `Bool` value for the given property.
    ///
    /// The underlying type for booleans is `UInt32` where booleans are stored as a `0` or `1` integer.
    nonisolated
    public func getPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == Bool, Property.Qualifier == Never {
        try getPropertyValue(property: property, qualifier: .none, osStatusErrorMessage: osStatusErrorMessage)
    }

    /// Queries the audio object to return the `Bool` value for the given property.
    ///
    /// The underlying type for booleans is `UInt32` where booleans are stored as a `0` or `1` integer.
    /// This method interprets `0` as `false` and any non-`0` value as `true`.
    nonisolated
    public func getPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        qualifier: AudioPropertyQualifier<Property.Qualifier>,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == Bool {
        var value: UInt32 = 0
        try getPropertyValue(
            address: property.address,
            value: &value,
            qualifier: qualifier,
            osStatusErrorMessage: osStatusErrorMessage
        )
        return value != 0
    }

    // MARK: Set

    /// Sets a `Bool` value for the given property of the audio object.
    ///
    /// The underlying type for booleans is `UInt32` where booleans are stored as a `0` or `1` integer.
    @discardableResult
    nonisolated
    public func setPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        value: Property.Value,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == Bool, Property.Qualifier == Never {
        try setPropertyValue(property: property, qualifier: .none, value: value, osStatusErrorMessage: osStatusErrorMessage)
    }

    /// Sets a `Bool` value for the given property of the audio object.
    ///
    /// The underlying type for booleans is `UInt32` where booleans are stored as a `0` or `1` integer.
    @discardableResult
    nonisolated
    public func setPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        qualifier: AudioPropertyQualifier<Property.Qualifier>,
        value: Property.Value,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == Bool {
        let value: UInt32 = value ? 1 : 0
        let newValue = try setPropertyValue(
            address: property.address,
            qualifier: qualifier,
            value: value,
            osStatusErrorMessage: osStatusErrorMessage
        )
        return newValue != 0
    }
}

// MARK: - Float32

extension AudioObject {
    // MARK: Get

    /// Queries the audio object to return the `Float32` value for the given property.
    nonisolated
    public func getPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == Float32, Property.Qualifier == Never {
        try getPropertyValue(property: property, qualifier: .none, osStatusErrorMessage: osStatusErrorMessage)
    }

    /// Queries the audio object to return the `Float32` value for the given property.
    nonisolated
    public func getPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        qualifier: AudioPropertyQualifier<Property.Qualifier>,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == Float32 {
        var value: Float32 = 0
        try getPropertyValue(address: property.address, value: &value, qualifier: qualifier, osStatusErrorMessage: osStatusErrorMessage)
        return value
    }

    // MARK: Set

    /// Sets a `Float32` value for the given property of the audio object.
    @discardableResult
    nonisolated
    public func setPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        value: Property.Value,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == Float32, Property.Qualifier == Never {
        try setPropertyValue(property: property, qualifier: .none, value: value, osStatusErrorMessage: osStatusErrorMessage)
    }

    /// Sets a `Float32` value for the given property of the audio object.
    @discardableResult
    nonisolated
    public func setPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        qualifier: AudioPropertyQualifier<Property.Qualifier>,
        value: Property.Value,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == Float32 {
        let newValue = try setPropertyValue(
            address: property.address,
            qualifier: qualifier,
            value: value,
            osStatusErrorMessage: osStatusErrorMessage
        )
        return newValue
    }
}

// MARK: - Float64 (a.k.a. Double)

extension AudioObject {
    // MARK: Get

    /// Queries the audio object to return the `Double` value for the given property.
    ///
    /// The underlying type is `Float64`.
    nonisolated
    public func getPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == Double, Property.Qualifier == Never {
        try getPropertyValue(property: property, qualifier: .none, osStatusErrorMessage: osStatusErrorMessage)
    }

    /// Queries the audio object to return the `Double` value for the given property.
    ///
    /// The underlying type is `Float64`.
    nonisolated
    public func getPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        qualifier: AudioPropertyQualifier<Property.Qualifier>,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == Double {
        var value: Float64 = 0
        try getPropertyValue(address: property.address, value: &value, qualifier: qualifier, osStatusErrorMessage: osStatusErrorMessage)
        return value
    }

    // MARK: Set

    /// Sets a `Double` value for the given property of the audio object.
    ///
    /// The underlying type is `Float64`.
    @discardableResult
    nonisolated
    public func setPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        value: Property.Value,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == Double, Property.Qualifier == Never {
        try setPropertyValue(property: property, qualifier: .none, value: value, osStatusErrorMessage: osStatusErrorMessage)
    }

    /// Sets a `Double` value for the given property of the audio object.
    ///
    /// The underlying type is `Float64`.
    @discardableResult
    nonisolated
    public func setPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        qualifier: AudioPropertyQualifier<Property.Qualifier>,
        value: Property.Value,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == Double {
        let newValue = try setPropertyValue(
            address: property.address,
            qualifier: qualifier,
            value: value,
            osStatusErrorMessage: osStatusErrorMessage
        )
        return newValue
    }
}

// MARK: - Int32

extension AudioObject {
    // MARK: Get

    /// Queries the audio object to return the `Int32` value for the given property.
    nonisolated
    public func getPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == Int32, Property.Qualifier == Never {
        try getPropertyValue(property: property, qualifier: .none, osStatusErrorMessage: osStatusErrorMessage)
    }

    /// Queries the audio object to return the `Int32` value for the given property.
    nonisolated
    public func getPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        qualifier: AudioPropertyQualifier<Property.Qualifier>,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == Int32 {
        var value: Int32 = 0
        try getPropertyValue(address: property.address, value: &value, qualifier: qualifier, osStatusErrorMessage: osStatusErrorMessage)
        return value
    }

    // MARK: Set

    // implement as-needed in future
}

// MARK: - String

extension AudioObject {
    // MARK: Get

    /// Queries the audio object to return the `String` value for the given property.
    ///
    /// The underlying type is `CFString`.
    nonisolated
    public func getPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == String, Property.Qualifier == Never {
        try getPropertyValue(property: property, qualifier: .none, osStatusErrorMessage: osStatusErrorMessage)
    }

    /// Queries the audio object to return the `String` value for the given property.
    ///
    /// The underlying type is `CFString`.
    nonisolated
    public func getPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        qualifier: AudioPropertyQualifier<Property.Qualifier>,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == String {
        let cfString: CFString = try getPropertyObject(
            address: property.address,
            qualifier: qualifier,
            osStatusErrorMessage: osStatusErrorMessage
        )
        return cfString as String
    }

    // MARK: Set

    /// Sets a `String` value for the given property of the audio object.
    ///
    /// The underlying type is `CFString`.
    @discardableResult
    nonisolated
    public func setPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        value: Property.Value,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == String, Property.Qualifier == Never {
        try setPropertyValue(property: property, qualifier: .none, value: value, osStatusErrorMessage: osStatusErrorMessage)
    }

    /// Sets a `String` value for the given property of the audio object.
    ///
    /// The underlying type is `CFString`.
    @discardableResult
    nonisolated
    public func setPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        qualifier: AudioPropertyQualifier<Property.Qualifier>,
        value: Property.Value,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == String {
        let value: CFString = value as CFString
        try setPropertyObject(address: property.address, qualifier: qualifier, object: value, osStatusErrorMessage: osStatusErrorMessage)
        return value as String
    }
}

// MARK: - [String]

extension AudioObject {
    // MARK: Get

    /// Queries the audio object to return the `[String]` value for the given property.
    ///
    /// The underlying type is a `CFArray` of `CFString`.
    nonisolated
    public func getPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == [String], Property.Qualifier == Never {
        try getPropertyValue(property: property, qualifier: .none, osStatusErrorMessage: osStatusErrorMessage)
    }

    /// Queries the audio object to return the `[String]` value for the given property.
    ///
    /// The underlying type is a `CFArray` of `CFString`.
    nonisolated
    public func getPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        qualifier: AudioPropertyQualifier<Property.Qualifier>,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == [String] {
        let value: CFArray = try getPropertyObject(
            address: property.address,
            qualifier: qualifier,
            osStatusErrorMessage: osStatusErrorMessage
        )
        guard let value = value as? [CFString] else {
            throw .osStatus(AudioOSStatusError(unsafe: .invalidPropertyValue), message: osStatusErrorMessage)
        }
        return value as [String]
    }

    // MARK: Set

    /// Sets a `[String]` value for the given property of the audio object.
    ///
    /// The underlying type is a `CFArray` of `CFString`.
    nonisolated
    public func setPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        value: [String],
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) where Property.Value == [String], Property.Qualifier == Never {
        try setPropertyValue(property: property, qualifier: .none, value: value, osStatusErrorMessage: osStatusErrorMessage)
    }

    /// Sets a `[String]` value for the given property of the audio object.
    ///
    /// The underlying type is a `CFArray` of `CFString`.
    @_disfavoredOverload
    nonisolated
    public func setPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        value: [String],
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == [String], Property.Qualifier == Never {
        try setPropertyValue(property: property, qualifier: .none, value: value, osStatusErrorMessage: osStatusErrorMessage)
    }

    /// Sets a `[String]` value for the given property of the audio object.
    ///
    /// The underlying type is a `CFArray` of `CFString`.
    nonisolated
    public func setPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        qualifier: AudioPropertyQualifier<Property.Qualifier>,
        value: [String],
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) where Property.Value == [String] {
        let cfArray: CFArray = value as [CFString] as CFArray
        try setPropertyObject(address: property.address, qualifier: qualifier, object: cfArray, osStatusErrorMessage: osStatusErrorMessage)
    }

    /// Sets a `[String]` value for the given property of the audio object.
    ///
    /// The underlying type is a `CFArray` of `CFString`.
    @_disfavoredOverload
    nonisolated
    public func setPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        qualifier: AudioPropertyQualifier<Property.Qualifier>,
        value: [String],
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == [String] {
        let cfArray: CFArray = value as [CFString] as CFArray
        try setPropertyObject(address: property.address, qualifier: qualifier, object: cfArray, osStatusErrorMessage: osStatusErrorMessage)
        guard let value = cfArray as? [String] else {
            throw .osStatus(AudioOSStatusError(unsafe: .invalidPropertyValue), message: osStatusErrorMessage)
        }
        return value as [String]
    }
}

// MARK: - [String: Any]

extension AudioObject {
    // MARK: Get

    /// Queries the audio object to return the `[String: Any]` value for the given property.
    ///
    /// The underlying type is a `CFDictionary` of `NSString` keys and `NSObject` values.
    nonisolated
    public func getPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        keys: [String]? = nil,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == [String: Any], Property.Qualifier == Never {
        try getPropertyValue(property: property, qualifier: .none, keys: keys, osStatusErrorMessage: osStatusErrorMessage)
    }

    /// Queries the audio object to return the `[String: Any]` value for the given property.
    ///
    /// The underlying type is a `CFDictionary` of `CFString` keys and `CFObject` values.
    nonisolated
    public func getPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        qualifier: AudioPropertyQualifier<Property.Qualifier>,
        keys: [String]? = nil,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == [String: Any] {
        let cfDict: CFDictionary = try getPropertyObject(
            address: property.address,
            qualifier: qualifier,
            osStatusErrorMessage: osStatusErrorMessage
        )
        let converted = Self.convertCFDictionary(cfDict)
        return converted
    }

    // MARK: Set

    /// Sets a `[String: Any]` value for the given property of the audio object.
    ///
    /// The underlying type is a `CFDictionary` of `NSString` keys and `NSObject` values.
    nonisolated
    public func setPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        value: Property.Value,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) where Property.Value == [String: Any], Property.Qualifier == Never {
        try setPropertyValue(property: property, qualifier: .none, value: value, osStatusErrorMessage: osStatusErrorMessage)
    }

    /// Sets a `[String: Any]` value for the given property of the audio object.
    ///
    /// The underlying type is a `CFDictionary` of `NSString` keys and `NSObject` values.
    @_disfavoredOverload
    nonisolated
    public func setPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        value: Property.Value,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == [String: Any], Property.Qualifier == Never {
        try setPropertyValue(property: property, qualifier: .none, value: value, osStatusErrorMessage: osStatusErrorMessage)
    }

    /// Sets a `[String: Any]` value for the given property of the audio object.
    ///
    /// The underlying type is a `CFDictionary` of `NSString` keys and `NSObject` values.
    nonisolated
    public func setPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        qualifier: AudioPropertyQualifier<Property.Qualifier>,
        value: Property.Value,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) where Property.Value == [String: Any] {
        let cfDict: CFDictionary = value as CFDictionary
        try setPropertyObject(address: property.address, qualifier: qualifier, object: cfDict, osStatusErrorMessage: osStatusErrorMessage)
    }

    /// Sets a `[String: Any]` value for the given property of the audio object.
    ///
    /// The underlying type is a `CFDictionary` of `NSString` keys and `NSObject` values.
    @_disfavoredOverload
    nonisolated
    public func setPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        qualifier: AudioPropertyQualifier<Property.Qualifier>,
        value: Property.Value,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == [String: Any] {
        let cfDict: CFDictionary = value as CFDictionary
        try setPropertyObject(address: property.address, qualifier: qualifier, object: cfDict, osStatusErrorMessage: osStatusErrorMessage)
        let converted = Self.convertCFDictionary(cfDict)
        return converted
    }

    // MARK: Utilities

    nonisolated
    private static func convertCFDictionary(
        _ cfDictionary: CFDictionary,
        keys: [String]? = nil
    ) -> [String: Any] {
        // toll-free bridge to NSDictionary
        let nsDict = cfDictionary as NSDictionary

        // filter keys if needed
        let keys = (keys ?? nsDict.allKeys.compactMap { $0 as? String })
        let mapped = nsDict.dictionaryWithValues(forKeys: keys)

        return mapped
    }
}

// MARK: - UInt32

extension AudioObject {
    // MARK: Get

    /// Queries the audio object to return the `UInt32` value for the given property.
    nonisolated
    public func getPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == UInt32, Property.Qualifier == Never {
        try getPropertyValue(property: property, qualifier: .none, osStatusErrorMessage: osStatusErrorMessage)
    }

    /// Queries the audio object to return the `UInt32` value for the given property.
    nonisolated
    public func getPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        qualifier: AudioPropertyQualifier<Property.Qualifier>,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == UInt32 {
        var value: UInt32 = 0
        try getPropertyValue(address: property.address, value: &value, qualifier: qualifier, osStatusErrorMessage: osStatusErrorMessage)
        return value
    }

    // MARK: Set

    /// Sets a `UInt32` value for the given property of the audio object.
    @discardableResult
    nonisolated
    public func setPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        value: Property.Value,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == UInt32, Property.Qualifier == Never {
        try setPropertyValue(property: property, qualifier: .none, value: value, osStatusErrorMessage: osStatusErrorMessage)
    }

    /// Sets a `UInt32` value for the given property of the audio object.
    @discardableResult
    nonisolated
    public func setPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        qualifier: AudioPropertyQualifier<Property.Qualifier>,
        value: Property.Value,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == UInt32 {
        let newValue = try setPropertyValue(
            address: property.address,
            qualifier: qualifier,
            value: value,
            osStatusErrorMessage: osStatusErrorMessage
        )
        return newValue
    }
}

// MARK: - [UInt32]

extension AudioObject {
    // MARK: Get

    /// Queries the audio object to return the `[UInt32]` value for the given property.
    nonisolated
    public func getPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == [UInt32], Property.Qualifier == Never {
        try getPropertyValue(property: property, qualifier: .none, osStatusErrorMessage: osStatusErrorMessage)
    }

    /// Queries the audio object to return the `[UInt32]` value for the given property.
    nonisolated
    public func getPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        qualifier: AudioPropertyQualifier<Property.Qualifier>,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == [UInt32] {
        let element: UInt32 = 0
        return try getPropertyArrayValue(
            address: property.address,
            newElement: element,
            qualifier: qualifier,
            osStatusErrorMessage: osStatusErrorMessage
        )
    }

    // MARK: Set

    /// Sets a `[UInt32]` value for the given property of the audio object.
    @discardableResult
    nonisolated
    public func setPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        value: Property.Value,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == [UInt32], Property.Qualifier == Never {
        try setPropertyValue(property: property, qualifier: .none, value: value, osStatusErrorMessage: osStatusErrorMessage)
    }

    /// Sets a `[UInt32]` value for the given property of the audio object.
    @discardableResult
    nonisolated
    public func setPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        qualifier: AudioPropertyQualifier<Property.Qualifier>,
        value: Property.Value,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == [UInt32] {
        try setPropertyValue(address: property.address, qualifier: qualifier, value: value, osStatusErrorMessage: osStatusErrorMessage)
    }
}

// MARK: - (UInt32, UInt32)

extension AudioObject {
    // MARK: Get

    /// Queries the audio object to return the `UInt32` value pair for the given property.
    nonisolated
    public func getPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == (UInt32, UInt32), Property.Qualifier == Never {
        try getPropertyValue(property: property, qualifier: .none, osStatusErrorMessage: osStatusErrorMessage)
    }

    /// Queries the audio object to return the `UInt32` value pair for the given property.
    nonisolated
    public func getPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        qualifier: AudioPropertyQualifier<Property.Qualifier>,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == (UInt32, UInt32) {
        var value: (UInt32, UInt32) = (0, 0)
        try getPropertyValue(address: property.address, value: &value, qualifier: qualifier, osStatusErrorMessage: osStatusErrorMessage)
        return value
    }

    // MARK: Set

    // implement as-needed in future
}

// MARK: - URL

extension AudioObject {
    // MARK: Get

    /// Queries the audio object to return the `URL` value for the given property.
    ///
    /// The underlying type is `CFURL`.
    nonisolated
    public func getPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == URL?, Property.Qualifier == Never {
        try getPropertyValue(property: property, qualifier: .none, osStatusErrorMessage: osStatusErrorMessage)
    }

    /// Queries the audio object to return the `URL` value for the given property.
    ///
    /// The underlying type is `CFURL`.
    nonisolated
    public func getPropertyValue<Property: AudioPropertyProtocol>(
        property: Property,
        qualifier: AudioPropertyQualifier<Property.Qualifier>,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Property.Value where Property.Value == URL? {
        let cfURL: CFURL? = try getPropertyOptionalObject(
            address: property.address,
            qualifier: qualifier,
            osStatusErrorMessage: osStatusErrorMessage
        )
        return cfURL as URL?
    }

    // MARK: Set

    // implement as-needed in future
}

#endif
