//
//  AudioStreamProperties+Implementation.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

extension AudioStreamProperties {
    // MARK: CoreAudio/AudioHardware.h
    
    nonisolated
    public var isActive: Bool {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: StreamProperty.isActive)
        }
    }
    
    nonisolated
    public var direction: AudioStream.Direction {
        get throws(SwiftCoreAudioError) {
            let value = try getPropertyValue(property: StreamProperty.direction)
            let dir = try AudioStream.Direction(tryingRawValue: value)
            return dir
        }
    }
    
    nonisolated
    public var terminalType: AudioStream.TerminalType {
        get throws(SwiftCoreAudioError) {
            let value = try getPropertyValue(property: StreamProperty.terminalType)
            let term = try AudioStream.TerminalType(tryingRawValue: value)
            return term
        }
    }
    
    nonisolated
    public var startingChannelNumber: UInt32 {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: StreamProperty.startingChannel)
        }
    }
    
    nonisolated
    public var latency: UInt32 {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: StreamProperty.latency)
        }
    }
    
    nonisolated
    public var virtualFormat: AudioStream.CurrentBasicDescription {
        get throws(SwiftCoreAudioError) {
            let coreAudioDesc = try getPropertyValue(property: StreamProperty.virtualFormat)
            let desc = try AudioStream.CurrentBasicDescription(from: coreAudioDesc)
            return desc
        }
    }
    
    nonisolated
    public var availableVirtualFormats: [AudioStream.RangedDescription] {
        get throws(SwiftCoreAudioError) {
            let coreAudioDescs = try getPropertyValue(property: StreamProperty.availableVirtualFormats)
            var descs: [AudioStream.RangedDescription] = []
            for coreAudioDesc in coreAudioDescs {
                let desc = try AudioStream.RangedDescription(from: coreAudioDesc)
                descs.append(desc)
            }
            return descs
        }
    }
    
    nonisolated
    public var physicalFormat: AudioStream.CurrentBasicDescription {
        get throws(SwiftCoreAudioError) {
            let coreAudioDesc = try getPropertyValue(property: StreamProperty.physicalFormat)
            let desc = try AudioStream.CurrentBasicDescription(from: coreAudioDesc)
            return desc
        }
    }
    
    nonisolated
    public var availablePhysicalFormats: [AudioStream.RangedDescription] {
        get throws(SwiftCoreAudioError) {
            let coreAudioDescs = try getPropertyValue(property: StreamProperty.availablePhysicalFormats)
            var descs: [AudioStream.RangedDescription] = []
            for coreAudioDesc in coreAudioDescs {
                let desc = try AudioStream.RangedDescription(from: coreAudioDesc)
                descs.append(desc)
            }
            return descs
        }
    }
}

#endif
