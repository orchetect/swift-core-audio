//
//  AudioObject+CoreAudio.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

// swiftformat:disable opaqueGenericParameters

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
        address: AudioObjectPropertyAddress
    ) -> Bool {
        var address = address
        return AudioObjectHasProperty(id.rawValue, &address)
    }
}

// MARK: - Property Data Size

extension AudioObject {
    /// Queries an audio object to return the value data size for the given property.
    ///
    /// The size is reported as a `UInt32` value.
    nonisolated
    public func getPropertyDataSize(
        address: AudioObjectPropertyAddress,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> UInt32 {
        try getPropertyDataSize(
            address: address,
            qualifier: AudioPropertyQualifier<Never>.none,
            osStatusErrorMessage: osStatusErrorMessage
        )
    }

    /// Queries an audio object to return the value data size for the given property.
    ///
    /// The size is reported as a `UInt32` value.
    nonisolated
    public func getPropertyDataSize<Qualifier>(
        address: AudioObjectPropertyAddress,
        qualifier: AudioPropertyQualifier<Qualifier>,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> UInt32 {
        let audioObjectID = id.rawValue

        var address = address

        var dataSize = UInt32()
        try qualifier.withPointerToValue { qualifierPtr in
            AudioObjectGetPropertyDataSize(
                audioObjectID,
                &address,
                qualifier.size,
                qualifierPtr,
                &dataSize
            )
        }
        .audioOSStatusError()?
        .throwSwiftCoreAudioError(
            message: osStatusErrorMessage
                ?? "Error getting size of property \(address) of audio object ID \(audioObjectID)."
        )

        return dataSize
    }
}

// MARK: - Property Value - Value Type

extension AudioObject {
    /// Queries the audio object to return the value for the given property.
    ///
    /// `Value` must be a value type. To get a reference (object) value, call
    /// ``getPropertyObject(address:qualifier:osStatusErrorMessage:)`` instead.
    nonisolated
    public func getPropertyValue<Value, Qualifier>(
        address: AudioObjectPropertyAddress,
        value: inout Value,
        qualifier: AudioPropertyQualifier<Qualifier>,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) {
        let audioObjectID = id.rawValue

        var address = address

        var size = UInt32(MemoryLayout<Value>.stride)

        try qualifier.withPointerToValue { qualifierPtr in
            withUnsafeMutablePointer(to: &value) { valuePtr in
                AudioObjectGetPropertyData(
                    audioObjectID,
                    &address,
                    qualifier.size,
                    qualifierPtr,
                    &size,
                    valuePtr
                )
            }
        }
        .audioOSStatusError()?
        .throwSwiftCoreAudioError(
            message: osStatusErrorMessage
                ?? "Error getting \(Value.self) value for property \(address) of audio object ID \(audioObjectID)."
        )
    }

    /// Queries the audio object to return the array value for the given property.
    ///
    /// `Element` must be a value type. To get a reference (object) value, including arrays that
    /// contain objects, call ``getPropertyObject(address:qualifier:osStatusErrorMessage:)`` instead.
    ///
    /// Do not use this for arrays that contain objects. Call ``getPropertyObject(address:qualifier:osStatusErrorMessage:)`` instead.
    nonisolated
    public func getPropertyArrayValue<Element, Qualifier>(
        address: AudioObjectPropertyAddress,
        newElement: Element,
        qualifier: AudioPropertyQualifier<Qualifier>,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> [Element] {
        let audioObjectID = id.rawValue

        var address = address

        var size = try getPropertyDataSize(address: address, qualifier: qualifier, osStatusErrorMessage: osStatusErrorMessage)
        let elementSize = MemoryLayout<Element>.stride
        let count = Int(size) / elementSize
        assert(count * elementSize == size) // check that there is no remainder
        var value = [Element](repeating: newElement, count: count)

        try qualifier.withPointerToValue { qualifierPtr in
            value.withUnsafeMutableBufferPointer { valuePtr in
                AudioObjectGetPropertyData(
                    audioObjectID,
                    &address,
                    qualifier.size,
                    qualifierPtr,
                    &size,
                    valuePtr.baseAddress!
                )
            }
        }
        .audioOSStatusError()?
        .throwSwiftCoreAudioError(
            message: osStatusErrorMessage
                ?? "Error getting [\(Element.self)] value for property \(address) of audio object ID \(audioObjectID)."
        )

        return value
    }

    /// Queries the audio object to return the value for the given property for properties that
    /// use the Core Audio `AudioValueTranslation` structure to supply input and output values.
    ///
    /// `Input` and `Output` must be value types.
    ///
    /// Generally, Core Audio property selectors that use the `AudioValueTranslation` structure
    /// do not take a qualifier value.
    nonisolated
    public func getPropertyValue<Input, Output>(
        address: AudioObjectPropertyAddress,
        input: inout Input,
        output: inout Output,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) {
        let audioObjectID = id.rawValue

        var address = address

        let inputSize = MemoryLayout<Input>.stride
        let outputSize = MemoryLayout<Output>.stride

        try withUnsafeMutablePointer(to: &input) { inputPtr in
            withUnsafeMutablePointer(to: &output) { outputPtr in
                var value = AudioValueTranslation(
                    mInputData: inputPtr,
                    mInputDataSize: UInt32(inputSize),
                    mOutputData: outputPtr,
                    mOutputDataSize: UInt32(outputSize)
                )
                var valueSize = UInt32(MemoryLayout<AudioValueTranslation>.stride)

                return AudioObjectGetPropertyData(
                    audioObjectID,
                    &address,
                    0,
                    nil,
                    &valueSize,
                    &value
                )
            }
        }
        .audioOSStatusError()?
        .throwSwiftCoreAudioError(
            message: osStatusErrorMessage
                ?? "Error getting \(Output.self) value for property \(address) of audio object ID \(audioObjectID)."
        )
    }

    /// Sets a new value for the given property of the audio object.
    ///
    /// `Value` must be a value type. To get a reference (object) value, call
    /// ``setPropertyObject(address:qualifier:object:osStatusErrorMessage:)`` instead.
    @discardableResult
    nonisolated
    public func setPropertyValue<Value, Qualifier>(
        address: AudioObjectPropertyAddress,
        qualifier: AudioPropertyQualifier<Qualifier>,
        value: Value,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Value {
        let audioObjectID = id.rawValue

        var address = address

        let size = UInt32(MemoryLayout<Value>.stride)

        try qualifier.withPointerToValue { qualifierPtr in
            withUnsafeBytes(of: value) { valuePtr in
                AudioObjectSetPropertyData(
                    audioObjectID,
                    &address,
                    qualifier.size,
                    qualifierPtr,
                    size,
                    valuePtr.baseAddress!
                )
            }
        }
        .audioOSStatusError()?
        .throwSwiftCoreAudioError(
            message: osStatusErrorMessage
                ?? "Error setting \(Value.self) value for property \(address) of audio object ID \(audioObjectID)."
        )

        return value
    }
}

// MARK: - Property - Reference Type (Object)

extension AudioObject {
    /// Queries an audio object to return the reference-type object for the given property.
    ///
    /// The underlying type should be a `CF*` object (ie: `CFArray`, `CFDictionary`).
    nonisolated
    public func getPropertyObject<Object: AnyObject, Qualifier>(
        address: AudioObjectPropertyAddress,
        qualifier: AudioPropertyQualifier<Qualifier>,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Object {
        guard let value: Object = try getPropertyOptionalObject(
            address: address,
            qualifier: qualifier,
            osStatusErrorMessage: osStatusErrorMessage
        ) else {
            throw .osStatus(AudioOSStatusError(unsafe: .badObject), message: osStatusErrorMessage)
        }
        return value
    }

    /// Queries an audio object to return the reference-type object for the given property if non-`nil`.
    ///
    /// The underlying type should be a `CF*` object (ie: `CFArray`, `CFDictionary`).
    nonisolated
    public func getPropertyOptionalObject<Object: AnyObject, Qualifier>(
        address: AudioObjectPropertyAddress,
        qualifier: AudioPropertyQualifier<Qualifier>,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) -> Object? {
        let audioObjectID = id.rawValue

        var address = address

        // Pass an optional else the object will not get released by the CoreAudio call (TODO: ?)
        var value: Object? // TODO: not sure if any Core Audio methods give us nil objects
        // var size = try getPropertyDataSize(address: address, qualifier: qualifier, osStatusErrorMessage: osStatusErrorMessage)
        var size = UInt32(MemoryLayout<Object>.stride)

        try qualifier.withPointerToValue { qualifierPtr in
            withUnsafeMutablePointer(to: &value) { valuePtr in
                AudioObjectGetPropertyData(
                    audioObjectID,
                    &address,
                    qualifier.size,
                    qualifierPtr,
                    &size,
                    valuePtr
                )
            }
        }
        .audioOSStatusError()?
        .throwSwiftCoreAudioError(
            message: osStatusErrorMessage
                ?? "Error getting \(Object.self) value for property \(address) of audio object ID \(audioObjectID)."
        )

        return value
    }

    /// Sets a new reference-type object for the given property of the audio object.
    ///
    /// The underlying type should be a `CF*` object (ie: `CFArray`, `CFDictionary`).
    nonisolated
    public func setPropertyObject<Object: AnyObject, Qualifier>(
        address: AudioObjectPropertyAddress,
        qualifier: AudioPropertyQualifier<Qualifier>,
        object: Object,
        osStatusErrorMessage: String? = nil
    ) throws(SwiftCoreAudioError) {
        let audioObjectID = id.rawValue

        var address = address

        let size = UInt32(MemoryLayout<Object>.stride)
        var value = object

        try qualifier.withPointerToValue { qualifierPtr in
            withUnsafeMutablePointer(to: &value) { valuePtr in
                AudioObjectSetPropertyData(
                    audioObjectID,
                    &address,
                    qualifier.size,
                    qualifierPtr,
                    size,
                    valuePtr
                )
            }
        }
        .audioOSStatusError()?
        .throwSwiftCoreAudioError(
            message: osStatusErrorMessage
                ?? "Error setting \(Object.self) value for property \(address) of audio object ID \(audioObjectID)."
        )
    }
}

#endif
