//
//  AudioPlugInProperties+Implementation.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

extension AudioPlugInProperties {
    // MARK: CoreAudio/AudioHardwareBase.h
    
    nonisolated
    public var bundleID: BundleID? {
        get throws(SwiftCoreAudioError) {
            let string = try withRecovery(
                try getPropertyValue(property: PlugInProperty.bundleID),
                unknownPropertyDefault: nil
            )
            
            guard let string, !string.isEmpty else { return nil }
            return BundleID(string)
        }
    }
    
    nonisolated
    public var devices: [AnyAudioDevice] {
        get throws(SwiftCoreAudioError) {
            let ids = try getPropertyValue(property: PlugInProperty.deviceList)
            
            var anyDevices: [AnyAudioDevice] = []
            for id in ids {
                let anyDevice = AnyAudioDevice(id: id)
                anyDevices.append(anyDevice)
            }
            return anyDevices
        }
    }
    
    nonisolated
    public func device<Device: AudioDeviceProperties & IDConstructibleAudioObject>(
        forUID uid: Device.UID
    ) throws(SwiftCoreAudioError) -> Device? {
        let id = try getPropertyValue(property: PlugInProperty.translateUIDToDevice, qualifier: .init(initialValue: uid.rawValue))
        // `kAudioObjectUnknown` ID with `noErr` OSStatus means "not found" but is not an error
        guard id != kAudioObjectUnknown else { return nil }
        return Device(id: id)
    }
    
    nonisolated
    public var boxes: [AudioBox] {
        get throws(SwiftCoreAudioError) {
            let ids = try getPropertyValue(property: PlugInProperty.boxList)
            return ids.map(AudioBox.init(id:))
        }
    }
    
    nonisolated
    public func box<Box: AudioBoxProperties & IDConstructibleAudioObject>(
        forUID uid: Box.UID
    ) throws(SwiftCoreAudioError) -> Box? {
        let id = try getPropertyValue(property: PlugInProperty.translateUIDToBox, qualifier: .init(initialValue: uid.rawValue))
        // `kAudioObjectUnknown` ID with `noErr` OSStatus means "not found" but is not an error
        guard id != kAudioObjectUnknown else { return nil }
        return Box(id: id)
    }
    
    nonisolated
    public var clocks: [AudioClock] {
        get throws(SwiftCoreAudioError) {
            let ids = try getPropertyValue(property: PlugInProperty.clockDeviceList)
            return ids.map(AudioClock.init(id:))
        }
    }
    
    nonisolated
    public func clock<Clock: AudioClockProperties & IDConstructibleAudioObject>(
        forUID uid: Clock.UID
    ) throws(SwiftCoreAudioError) -> Clock? {
        let id = try getPropertyValue(property: PlugInProperty.translateUIDToClockDevice, qualifier: .init(initialValue: uid.rawValue))
        // `kAudioObjectUnknown` ID with `noErr` OSStatus means "not found" but is not an error
        guard id != kAudioObjectUnknown else { return nil }
        return Clock(id: id)
    }
}

// MARK: - Aggregate Device Lifecycle

extension AudioPlugInProperties {
    // TODO: needs testing
    /// - Throws: Throws an error if an aggregate device with the same UID already exists.
    nonisolated
    public func makeAggregateDevice(
        composition: AudioAggregateDevice.Composition,
        waitForCompletionWithTimeout timeout: TimeInterval? = 5.0
    ) throws(SwiftCoreAudioError) -> AudioAggregateDevice {
        let cfDictionary = composition.cfDictionary()
        return try makeAggregateDevice(composition: cfDictionary, waitForCompletionWithTimeout: timeout)
    }
    
    // TODO: needs testing
    /// - Throws: Throws an error if an aggregate device with the same UID already exists.
    nonisolated
    public func makeAggregateDevice(
        composition: CFDictionary,
        waitForCompletionWithTimeout timeout: TimeInterval? = 5.0
    ) throws(SwiftCoreAudioError) -> AudioAggregateDevice {
        let aggregateID = try getPropertyValue(property: PlugInProperty.createAggregateDevice, qualifier: .init(initialValue: composition))
        
        let newAggregate = AudioAggregateDevice(id: aggregateID)
        
        if let timeout {
            // CoreAudio does not fully create the aggregate synchronously, so we have to wait for it before returning.
            // TODO: Not ideal but it works.
            let inDate = Date()
            while !newAggregate.isPresent {
                usleep(UInt32(Double(USEC_PER_SEC) * 0.05))
                if Date().timeIntervalSince(inDate) > timeout {
                    // timeout
                    throw .aggregateCreationTimeout
                }
            }
        }
        
        return newAggregate
    }
    
    // TODO: needs testing
    nonisolated
    public func destroyAggregateDevice(
        _ aggregate: AudioAggregateDevice,
        waitForCompletionWithTimeout timeout: TimeInterval? = 5.0
    ) throws(SwiftCoreAudioError) {
        // TODO: not sure if this works, needs testing
        var value = aggregate.id.rawValue
        _ = try getPropertyValue(
            address: PlugInProperty.destroyAggregateDevice.address,
            value: &value,
            qualifier: .none
        )
        // TODO: not sure if a value gets returned (OSStatus? docs don't say.)
        
        if let timeout {
            // CoreAudio does not fully destroy the aggregate synchronously, so we have to wait for it before returning.
            // TODO: Not ideal but it works.
            let inDate = Date()
            while aggregate.isPresent {
                usleep(UInt32(Double(USEC_PER_SEC) * 0.05))
                if Date().timeIntervalSince(inDate) > timeout {
                    // timeout
                    throw .aggregateDestructionTimeout
                }
            }
        }
    }
}

#endif
