//
//  AudioDeviceProperties+Implementation.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

extension AudioDeviceProperties {
    // MARK: - CoreAudio/AudioHardwareBase.h

    nonisolated
    public var configurationApplication: BundleID {
        get throws(SwiftCoreAudioError) {
            let string: String = try getPropertyValue(property: DeviceProperty.configurationApplication)
            return BundleID(string)
        }
    }

    nonisolated
    public var deviceUID: UID {
        get throws(SwiftCoreAudioError) {
            let string: String = try getPropertyValue(property: DeviceProperty.deviceUID)
            return UID(string)
        }
    }

    nonisolated
    public var modelUID: String? {
        get throws(SwiftCoreAudioError) {
            let string = try withRecovery(
                getPropertyValue(property: DeviceProperty.modelUID),
                unknownPropertyDefault: nil
            )

            // interpret empty string as `nil`
            guard let string, !string.isEmpty else { return nil }
            return string
        }
    }

    nonisolated
    public var transportType: AudioDevice.TransportType {
        get throws(SwiftCoreAudioError) {
            let rawValue: FourCharCode = try getPropertyValue(property: DeviceProperty.transportType)
            let transport = try AudioDevice.TransportType(tryingRawValue: rawValue)
            return transport
        }
    }

    nonisolated
    public var relatedDevices: [AnyAudioDevice] {
        get throws(SwiftCoreAudioError) {
            let ids = try getPropertyValue(property: DeviceProperty.relatedDevices)

            var anyDevices: [AnyAudioDevice] = []
            for id in ids {
                let anyDevice = AnyAudioDevice(id: id)
                anyDevices.append(anyDevice)
            }
            return anyDevices
        }
    }

    // TODO: Implement clockDomain
    @available(*, deprecated, message: "Not yet implemented. Currently this will always throw.")
    nonisolated
    public var clockDomain: Never {
        get throws(SwiftCoreAudioError) {
            throw .notYetImplemented()
        }
    }

    nonisolated
    public var isDeviceAlive: Bool {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: DeviceProperty.isDeviceAlive)
        }
    }

    nonisolated
    public var isDeviceRunning: Bool {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: DeviceProperty.isDeviceRunning)
        }
    }

    nonisolated
    public func isSettableAsDefaultDevice(for direction: AudioStream.Direction) throws(SwiftCoreAudioError) -> Bool {
        try getPropertyValue(property: DeviceProperty.isSettableAsDefaultDevice(for: direction))
    }

    nonisolated
    public func latency(for direction: AudioStream.Direction) throws(SwiftCoreAudioError) -> UInt32 {
        try getPropertyValue(property: DeviceProperty.latency(for: direction))
    }

    nonisolated
    public var streams: [AudioStream] {
        get throws(SwiftCoreAudioError) {
            let rawAudioObjectIDs: [AudioObjectID] = try getPropertyValue(property: DeviceProperty.streams)
            let mapped = rawAudioObjectIDs.map(AudioStream.init(id:))
            return mapped
        }
    }

    // TODO: Return a new `AnyAudioControl` type once concrete control types are all implemented?
    nonisolated
    public var controls: [AudioObjectID] {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: DeviceProperty.controls)
        }
    }

    nonisolated
    public func safetyOffset(for direction: AudioStream.Direction) throws(SwiftCoreAudioError) -> UInt32 {
        try getPropertyValue(property: DeviceProperty.safetyOffset(for: direction))
    }

    nonisolated
    public var nominalSampleRate: Float64 {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: DeviceProperty.nominalSampleRate)
        }
    }

    nonisolated
    public var availableNominalSampleRates: [ClosedRange<Double>] {
        get throws(SwiftCoreAudioError) {
            let audioValueRanges = try getPropertyValue(property: DeviceProperty.availableNominalSampleRates)
            let ranges = audioValueRanges.map { $0.mMinimum ... $0.mMaximum }
            return ranges
        }
    }

    nonisolated
    public var icon: URL? {
        get throws(SwiftCoreAudioError) {
            // gracefully return `nil` if object does not have the property
            let url = try withRecovery(
                getPropertyValue(property: DeviceProperty.icon),
                unknownPropertyDefault: nil
            )
            return url
        }
    }

    nonisolated
    public var isHidden: Bool {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: DeviceProperty.isHidden)
        }
    }

    nonisolated
    public func preferredStereoChannels(for direction: AudioStream.Direction) throws(SwiftCoreAudioError) -> (left: Int, right: Int)? {
        guard let (left, right) = try withRecovery(
            getPropertyValue(property: DeviceProperty.preferredStereoChannels(for: direction)),
            unknownPropertyDefault: nil
        ) else { return nil }

        return (left: Int(left), right: Int(right))
    }

    nonisolated
    public var preferredChannelLayout: AudioChannelLayout? {
        get throws(SwiftCoreAudioError) {
            try withRecovery(
                getPropertyValue(property: DeviceProperty.preferredChannelLayout),
                unknownPropertyDefault: nil
            )
        }
    }

    // MARK: - CoreAudio/AudioHardware.h

    nonisolated
    public var plugInLoadStatus: AudioOSStatus? {
        get throws(SwiftCoreAudioError) {
            let osStatus: OSStatus? = try withRecovery(
                getPropertyValue(property: DeviceProperty.plugInLoadStatus),
                unknownPropertyDefault: nil
            )
            guard let osStatus else { return nil }
            guard let audioOSStatus = AudioOSStatus(rawValue: osStatus) else {
                throw .osStatus(AudioOSStatusError(unsafe: osStatus))
            }
            return audioOSStatus
        }
    }

    nonisolated
    public var isDeviceRunningSomewhere: Bool {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: DeviceProperty.isDeviceRunningSomewhere)
        }
    }

    nonisolated
    public var hogModePID: PID? {
        get throws(SwiftCoreAudioError) {
            guard let rawPID: pid_t = try withRecovery(
                getPropertyValue(property: DeviceProperty.hogModePID),
                unknownPropertyDefault: nil
            ) else { return nil }

            // -1 == device is not hogged; available to all processes
            guard rawPID != -1 else { return nil }

            return PID(rawValue: rawPID)
        }
    }

    nonisolated
    public var bufferFrameSize: UInt32 {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: DeviceProperty.bufferFrameSize)
        }
    }

    nonisolated
    public var bufferFrameSizeRange: ClosedRange<UInt32> {
        get throws(SwiftCoreAudioError) {
            let audioValueRange = try getPropertyValue(property: DeviceProperty.bufferFrameSizeRange)
            let range = UInt32(audioValueRange.mMinimum) ... UInt32(audioValueRange.mMaximum)
            return range
        }
    }

    // TODO: Implement variable buffer frame sizes
    // nonisolated
    // public var <#Variable Name#>: <#Type#> {
    //     get throws(SwiftCoreAudioError) {
    //         <#Code#>
    //     }
    // }

    nonisolated
    public var ioCycleUsage: Float32 {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: DeviceProperty.ioCycleUsage)
        }
    }

    // TODO: Implement input/output streamConfiguration
    @available(*, deprecated, message: "Not yet implemented. Currently this will always throw.")
    nonisolated
    public func streamConfiguration(for direction: AudioStream.Direction) throws(SwiftCoreAudioError) -> Never {
        throw .notYetImplemented()
    }

    // TODO: Implement ioProcStreamUsage
    @available(*, deprecated, message: "Not yet implemented. Currently this will always throw.")
    nonisolated
    public var ioProcStreamUsage: Never {
        get throws(SwiftCoreAudioError) {
            throw .notYetImplemented()
        }
    }

    nonisolated
    public var actualSampleRate: Double {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: DeviceProperty.actualSampleRate)
        }
    }

    nonisolated
    public var clockDeviceUID: AudioClock.UID? {
        get throws(SwiftCoreAudioError) {
            // gracefully return `nil` if object does not have the property
            let string = try withRecovery(
                getPropertyValue(property: DeviceProperty.clockDeviceUID),
                unknownPropertyDefault: nil
            )

            // interpret empty string as `nil`
            guard let string, !string.isEmpty else { return nil }
            return AudioClock.UID(string)
        }
    }

    nonisolated
    public var workgroup: WorkGroup {
        get throws(SwiftCoreAudioError) {
            try getPropertyObject(address: DeviceProperty.workgroup.address, qualifier: .none)
        }
    }

    nonisolated
    public func isCurrentProcessMuted(for direction: AudioStream.Direction) throws(SwiftCoreAudioError) -> Bool {
        try withRecovery(
            getPropertyValue(property: DeviceProperty.isCurrentProcessMuted(for: direction)),
            unknownPropertyDefault: false
        )
    }
}

#endif
