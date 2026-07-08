//
//  AudioBoxProperties+Implementation.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

extension AudioBoxProperties {
    // MARK: CoreAudio/AudioHardwareBase.h

    nonisolated
    public var boxUID: UID {
        get throws(SwiftCoreAudioError) {
            let string = try getPropertyValue(property: BoxProperty.boxUID)
            return UID(rawValue: string)
        }
    }

    nonisolated
    public var transportType: AudioDevice.TransportType {
        get throws(SwiftCoreAudioError) {
            let value = try getPropertyValue(property: BoxProperty.transportType)
            let transportType = try AudioDevice.TransportType(tryingRawValue: value)
            return transportType
        }
    }

    nonisolated
    public var hasAudio: Bool {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: BoxProperty.hasAudio)
        }
    }

    nonisolated
    public var hasVideo: Bool {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: BoxProperty.hasVideo)
        }
    }

    nonisolated
    public var hasMIDI: Bool {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: BoxProperty.hasMIDI)
        }
    }

    nonisolated
    public var isProtected: Bool {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: BoxProperty.isProtected)
        }
    }

    nonisolated
    public var isEnabled: Bool {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: BoxProperty.acquired)
        }
    }

    nonisolated
    public func setIsEnabled(_ state: Bool) throws(SwiftCoreAudioError) {
        guard isPresent else {
            throw .audioBoxNotFound
        }

        // call asynchronously on background queue
        // workaround for potential internal CoreAudio mutex deadlocks that can happen
        DispatchQueue.global().async {
            do throws(SwiftCoreAudioError) {
                _ = try setPropertyValue(property: BoxProperty.acquired, value: state)
            } catch {
                CoreAudioLogging.log(.error, "\(error)")
            }
        }

        // wait synchronously until state changes
        let timeout: TimeInterval = 0.5
        let pollingInterval: DispatchTimeInterval = .milliseconds(50)
        let inDate = Date()
        while let getState = try? isEnabled, getState != state {
            sleep(pollingInterval)
            if Date().timeIntervalSince(inDate) > timeout {
                throw .osStatus(
                    AudioOSStatusError(unsafe: .propertyNotWritable),
                    message: "Timed out while waiting for audio box state to change to \(state)."
                )
            }
        }
    }

    // note: acquisitionFailed can be read after a call to acquire it fails, which should happen in `setEnabled()`

    nonisolated
    public var devices: [AnyAudioDevice] {
        get throws(SwiftCoreAudioError) {
            let ids = try withRecovery(
                getPropertyValue(property: BoxProperty.deviceList),
                unknownPropertyDefault: []
            )
            return ids.map(AnyAudioDevice.init(id:))
        }
    }

    nonisolated
    public var clocks: [AudioClock] {
        get throws(SwiftCoreAudioError) {
            let ids = try withRecovery(
                getPropertyValue(property: BoxProperty.clockDeviceList),
                unknownPropertyDefault: []
            )
            return ids.map(AudioClock.init(id:))
        }
    }
}

#endif
