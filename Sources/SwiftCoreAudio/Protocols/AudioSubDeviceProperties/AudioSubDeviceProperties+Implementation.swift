//
//  AudioSubDeviceProperties+Implementation.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// MARK: - Implementation

extension AudioSubDeviceProperties {
    // MARK: CoreAudio/AudioHardware.h
    
    nonisolated
    public var extraLatency: Double {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: SubDeviceProperty.extraLatency)
        }
    }
    
    // TODO: needs testing
    nonisolated
    public func setExtraLatency(_ value: Double) throws(SwiftCoreAudioError) {
        try setPropertyValue(property: SubDeviceProperty.extraLatency, value: value)
    }
    
    nonisolated
    public var isDriftCompensationEnabled: Bool {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: SubDeviceProperty.driftCompensation)
        }
    }
    
    // TODO: needs testing
    nonisolated
    public func setIsDriftCompensationEnabled(_ value: Bool) throws(SwiftCoreAudioError) {
        try setPropertyValue(property: SubDeviceProperty.driftCompensation, value: value)
    }
    
    nonisolated
    public var driftCompensationQuality: AudioAggregateDevice.DriftCompensationQuality {
        get throws(SwiftCoreAudioError) {
            let rawValue = try getPropertyValue(property: SubDeviceProperty.driftCompensationQuality)
            let quality = try AudioAggregateDevice.DriftCompensationQuality(tryingRawValue: rawValue)
            return quality
        }
    }
    
    nonisolated
    public func setDriftCompensationQuality(_ quality: AudioAggregateDevice.DriftCompensationQuality) throws(SwiftCoreAudioError) {
        try setPropertyValue(property: SubDeviceProperty.driftCompensationQuality, value: quality.rawValue)
    }
}

#endif
