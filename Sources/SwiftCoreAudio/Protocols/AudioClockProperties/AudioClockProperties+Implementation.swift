//
//  AudioClockProperties+Implementation.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

extension AudioClockProperties {
    // MARK: CoreAudio/AudioHardwareBase.h

    nonisolated
    public var deviceUID: UID {
        get throws(SwiftCoreAudioError) {
            let string = try getPropertyValue(property: ClockProperty.deviceUID)
            return UID(rawValue: string)
        }
    }

    nonisolated
    public var transportType: AudioDevice.TransportType {
        get throws(SwiftCoreAudioError) {
            let value = try getPropertyValue(property: ClockProperty.transportType)
            let transportType = try AudioDevice.TransportType(tryingRawValue: value)
            return transportType
        }
    }

    // TODO: refactor as new enum of known clock domains?
    nonisolated
    public var clockDomain: UInt32 {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: ClockProperty.clockDomain)
        }
    }

    nonisolated
    public var isAlive: Bool {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: ClockProperty.deviceIsAlive)
        }
    }

    nonisolated
    public var isRunning: Bool {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: ClockProperty.deviceIsRunning)
        }
    }

    nonisolated
    public var latency: UInt32 {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: ClockProperty.latency)
        }
    }

    // TODO: refactor in a way that can constrain this to only audio controls and provide stronger type hints. Could implement controls as nested types in lieu of no class inheritance model.
    nonisolated
    public var controls: [any AudioObject] {
        get throws(SwiftCoreAudioError) {
            let ids = try getPropertyValue(property: ClockProperty.controlList)
            var objects: [any AudioObject] = []
            for id in ids {
                let object = try AudioSystem.shared.object(forID: id)
                objects.append(object)
            }
            return objects
        }
    }

    nonisolated
    public var nominalSampleRate: Double {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: ClockProperty.nominalSampleRate)
        }
    }

    nonisolated
    public var availableNominalSampleRates: [ClosedRange<Double>] {
        get throws(SwiftCoreAudioError) {
            let audioValueRanges = try getPropertyValue(property: ClockProperty.availableNominalSampleRates)
            return audioValueRanges.map { $0.mMinimum ... $0.mMaximum }
        }
    }
}

#endif
