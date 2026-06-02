//
//  AudioProcessProperties+Implementation.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

extension AudioProcessProperties {
    // MARK: CoreAudio/AudioHardware.h
    
    nonisolated
    public var pid: PID {
        get throws(SwiftCoreAudioError) {
            let pid: pid_t = try getPropertyValue(property: ProcessProperty.pid)
            return PID(pid)
        }
    }
    
    nonisolated
    public var bundleID: BundleID? {
        get throws(SwiftCoreAudioError) {
            let string = try withRecovery(
                try getPropertyValue(property: ProcessProperty.bundleID),
                unknownPropertyDefault: nil
            )
            
            guard let string, !string.isEmpty else { return nil }
            return BundleID(string)
        }
    }
    
    nonisolated
    public var devices: [AnyAudioDevice] {
        get throws(SwiftCoreAudioError) {
            let ids = try getPropertyValue(property: ProcessProperty.devices(for: nil))
            
            var anyDevices: [AnyAudioDevice] = []
            for id in ids {
                let anyDevice = AnyAudioDevice(id: id)
                anyDevices.append(anyDevice)
            }
            return anyDevices
        }
    }
    
    nonisolated
    public func devices(for direction: AudioStream.Direction) throws(SwiftCoreAudioError) -> [AnyAudioDevice] {
        let ids = try getPropertyValue(property: ProcessProperty.devices(for: direction))
        
        var anyDevices: [AnyAudioDevice] = []
        for id in ids {
            let anyDevice = AnyAudioDevice(id: id)
            anyDevices.append(anyDevice)
        }
        return anyDevices
    }
    
    nonisolated
    public var isRunning: Bool {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: ProcessProperty.isRunning)
        }
    }
    
    nonisolated
    public func isRunning(for direction: AudioStream.Direction) throws(SwiftCoreAudioError) -> Bool {
        switch direction {
        case .input: try getPropertyValue(property: ProcessProperty.isRunningInput)
        case .output: try getPropertyValue(property: ProcessProperty.isRunningOutput)
        }
    }
}

#endif
