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
    public func preferredStereoChannels(for direction: AudioStream.Direction) throws(SwiftCoreAudioError) -> StereoAudioChannelIndexes? {
        // Core Audio returns 1-based number series
        guard let (left, right) = try withRecovery(
            getPropertyValue(property: DeviceProperty.preferredStereoChannels(for: direction)),
            unknownPropertyDefault: nil
        ) else { return nil }

        return StereoAudioChannelIndexes(leftNumber: left, rightNumber: right)
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

    // MARK: - CoreAudio/AudioHardware.h - Device properties implemented via AudioControl objects

    nonisolated
    public func isJackConnected(for direction: AudioStream.Direction, channel: Int?) throws(SwiftCoreAudioError) -> Bool {
        try withRecovery(
            getPropertyValue(property: DeviceProperty.isJackConnected(for: direction, channel: channel)),
            unknownPropertyDefault: false
        )
    }

    nonisolated
    public func volumeScalar(for direction: AudioStream.Direction, channel: Int?) throws(SwiftCoreAudioError) -> Float32 {
        try getPropertyValue(property: DeviceProperty.volumeScalar(for: direction, channel: channel))
    }

    nonisolated
    public func setVolumeScalar(for direction: AudioStream.Direction, channel: Int?, to value: Float32) throws(SwiftCoreAudioError) {
        try setPropertyValue(property: DeviceProperty.volumeScalar(for: direction, channel: channel), value: value)
    }

    nonisolated
    public func volumeDecibels(for direction: AudioStream.Direction, channel: Int?) throws(SwiftCoreAudioError) -> Float32 {
        try getPropertyValue(property: DeviceProperty.volumeDecibels(for: direction, channel: channel))
    }

    nonisolated
    public func setVolumeDecibels(for direction: AudioStream.Direction, channel: Int?, to value: Float32) throws(SwiftCoreAudioError) {
        try setPropertyValue(property: DeviceProperty.volumeDecibels(for: direction, channel: channel), value: value)
    }

    nonisolated
    public func volumeRangeDecibels(for direction: AudioStream.Direction, channel: Int?) throws(SwiftCoreAudioError) -> ClosedRange<Double> {
        let audioValueRange = try getPropertyValue(property: DeviceProperty.volumeRangeDecibels(for: direction, channel: channel))
        return audioValueRange.mMinimum ... audioValueRange.mMaximum
    }

    // TODO: Not sure if scope or element are applicable.
    nonisolated
    public func convertScalarVolumeToDecibels(scalar level: Float32) throws(SwiftCoreAudioError) -> Float32 {
        let convertedValue = try getPropertyValue(property: DeviceProperty.volumeScalarToDecibels, qualifier: .float32(level))
        return convertedValue
    }

    // TODO: Not sure if scope or element are applicable.
    nonisolated
    public func convertDecibelsVolumeToScalar(scalar level: Float32) throws(SwiftCoreAudioError) -> Float32 {
        let convertedValue = try getPropertyValue(property: DeviceProperty.volumeDecibelsToScalar, qualifier: .float32(level))
        return convertedValue
    }

    nonisolated
    public func stereoPan(for direction: AudioStream.Direction, channel: Int?) throws(SwiftCoreAudioError) -> Float32 {
        try getPropertyValue(property: DeviceProperty.stereoPan(for: direction, channel: channel))
    }

    nonisolated
    public func setStereoPan(for direction: AudioStream.Direction, channel: Int?, to value: Float32) throws(SwiftCoreAudioError) {
        try setPropertyValue(property: DeviceProperty.stereoPan(for: direction, channel: channel), value: value)
    }

    nonisolated
    public func stereoPanChannels(for direction: AudioStream.Direction) throws(SwiftCoreAudioError) -> StereoAudioChannelIndexes? {
        // Core Audio returns 1-based number series
        guard let (left, right) = try withRecovery(
            getPropertyValue(property: DeviceProperty.stereoPanChannels(for: direction)),
            unknownPropertyDefault: nil
        ) else { return nil }

        return StereoAudioChannelIndexes(leftNumber: left, rightNumber: right)
    }

    nonisolated
    public func isMuted(for direction: AudioStream.Direction, channel: Int?) throws(SwiftCoreAudioError) -> Bool {
        try getPropertyValue(property: DeviceProperty.isMuted(for: direction, channel: channel))
    }

    nonisolated
    public func setIsMuted(for direction: AudioStream.Direction, channel: Int?, to value: Bool) throws(SwiftCoreAudioError) {
        try setPropertyValue(property: DeviceProperty.isMuted(for: direction, channel: channel), value: value)
    }

    nonisolated
    public func isSoloed(for direction: AudioStream.Direction, channel: Int?) throws(SwiftCoreAudioError) -> Bool {
        try getPropertyValue(property: DeviceProperty.isSoloed(for: direction, channel: channel))
    }

    nonisolated
    public func setIsSoloed(for direction: AudioStream.Direction, channel: Int?, to value: Bool) throws(SwiftCoreAudioError) {
        try setPropertyValue(property: DeviceProperty.isSoloed(for: direction, channel: channel), value: value)
    }

    nonisolated
    public func isPhantomPowerEnabled(forInputChannel channel: Int?) throws(SwiftCoreAudioError) -> Bool {
        try getPropertyValue(property: DeviceProperty.isPhantomPowerEnabled(forInputChannel: channel))
    }

    nonisolated
    public func setIsPhantomPowerEnabled(forInputChannel channel: Int?, to value: Bool) throws(SwiftCoreAudioError) {
        try setPropertyValue(property: DeviceProperty.isPhantomPowerEnabled(forInputChannel: channel), value: value)
    }

    nonisolated
    public func isPhaseInverted(for direction: AudioStream.Direction, channel: Int?) throws(SwiftCoreAudioError) -> Bool {
        try getPropertyValue(property: DeviceProperty.isPhaseInverted(for: direction, channel: channel))
    }

    nonisolated
    public func setIsPhaseInverted(for direction: AudioStream.Direction, channel: Int?, to value: Bool) throws(SwiftCoreAudioError) {
        try setPropertyValue(property: DeviceProperty.isPhaseInverted(for: direction, channel: channel), value: value)
    }

    nonisolated
    public func isClipLightOn(for direction: AudioStream.Direction, channel: Int?) throws(SwiftCoreAudioError) -> Bool {
        try getPropertyValue(property: DeviceProperty.isClipLightOn(for: direction, channel: channel))
    }

    nonisolated
    public func setIsClipLightOn(for direction: AudioStream.Direction, channel: Int?, to value: Bool) throws(SwiftCoreAudioError) {
        try setPropertyValue(property: DeviceProperty.isClipLightOn(for: direction, channel: channel), value: value)
    }

    nonisolated
    public var isTalkbackEnabled: Bool {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: DeviceProperty.isTalkbackEnabled)
        }
    }

    nonisolated
    public func setIsTalkbackEnabled(to value: Bool) throws(SwiftCoreAudioError) {
        try setPropertyValue(property: DeviceProperty.isTalkbackEnabled, value: value)
    }

    nonisolated
    public var isListenbackEnabled: Bool {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: DeviceProperty.isListenbackEnabled)
        }
    }

    nonisolated
    public func setIsListenbackEnabled(to value: Bool) throws(SwiftCoreAudioError) {
        try setPropertyValue(property: DeviceProperty.isListenbackEnabled, value: value)
    }

    // TODO: Not sure if scope or element are applicable.
    nonisolated
    public var dataSourceIDs: [UInt32] {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: DeviceProperty.dataSource)
        }
    }

    // TODO: Not sure if scope or element are applicable.
    nonisolated
    public var dataSourcesIDs: [UInt32] {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: DeviceProperty.dataSources)
        }
    }

    nonisolated
    public func dataSourceName(forID dataSourceID: UInt32) throws(SwiftCoreAudioError) -> String {
        try getPropertyValue(property: DeviceProperty.dataSourceNameForID, input: dataSourceID)
    }

    nonisolated
    public func dataSourceKind(forID dataSourceID: UInt32) throws(SwiftCoreAudioError) -> UInt32 {
        try getPropertyValue(property: DeviceProperty.dataSourceKindForID, input: dataSourceID)
    }

    // TODO: Not sure if scope or element are applicable.
    nonisolated
    public var clockSourceIDs: [UInt32] {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: DeviceProperty.clockSource)
        }
    }

    // TODO: Not sure if scope or element are applicable.
    nonisolated
    public var clockSourcesIDs: [UInt32] {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: DeviceProperty.clockSources)
        }
    }

    nonisolated
    public func clockSourceName(forID clockSourceID: UInt32) throws(SwiftCoreAudioError) -> String {
        try getPropertyValue(property: DeviceProperty.clockSourceNameForID, input: clockSourceID)
    }

    nonisolated
    public func clockSourceKind(forID clockSourceID: UInt32) throws(SwiftCoreAudioError) -> UInt32 {
        try getPropertyValue(property: DeviceProperty.clockSourceKindForID, input: clockSourceID)
    }

    nonisolated
    public func isPlayThruEnabled(for direction: AudioStream.Direction, channel: Int?) throws(SwiftCoreAudioError) -> Bool {
        try getPropertyValue(property: DeviceProperty.isPlayThruEnabled(for: direction, channel: channel))
    }

    nonisolated
    public func setIsPlayThruEnabled(for direction: AudioStream.Direction, channel: Int?, to value: Bool) throws(SwiftCoreAudioError) {
        try setPropertyValue(property: DeviceProperty.isPlayThruEnabled(for: direction, channel: channel), value: value)
    }

    nonisolated
    public func isPlayThruSoloed(for direction: AudioStream.Direction, channel: Int?) throws(SwiftCoreAudioError) -> Bool {
        try getPropertyValue(property: DeviceProperty.isPlayThruSoloed(for: direction, channel: channel))
    }

    nonisolated
    public func setIsPlayThruSoloed(for direction: AudioStream.Direction, channel: Int?, to value: Bool) throws(SwiftCoreAudioError) {
        try setPropertyValue(property: DeviceProperty.isPlayThruSoloed(for: direction, channel: channel), value: value)
    }

    nonisolated
    public func playThruVolumeScalar(for direction: AudioStream.Direction, channel: Int?) throws(SwiftCoreAudioError) -> Float32 {
        try getPropertyValue(property: DeviceProperty.playThruVolumeScalar(for: direction, channel: channel))
    }

    nonisolated
    public func setPlayThruVolumeScalar(for direction: AudioStream.Direction, channel: Int?, to value: Float32) throws(SwiftCoreAudioError) {
        try setPropertyValue(property: DeviceProperty.playThruVolumeScalar(for: direction, channel: channel), value: value)
    }

    nonisolated
    public func playThruVolumeDecibels(for direction: AudioStream.Direction, channel: Int?) throws(SwiftCoreAudioError) -> Float32 {
        try getPropertyValue(property: DeviceProperty.playThruVolumeDecibels(for: direction, channel: channel))
    }

    nonisolated
    public func setPlayThruVolumeDecibels(for direction: AudioStream.Direction, channel: Int?, to value: Float32) throws(SwiftCoreAudioError) {
        try setPropertyValue(property: DeviceProperty.playThruVolumeDecibels(for: direction, channel: channel), value: value)
    }

    nonisolated
    public func playThruVolumeRangeDecibels(for direction: AudioStream.Direction, channel: Int?) throws(SwiftCoreAudioError) -> ClosedRange<Double> {
        let audioValueRange = try getPropertyValue(property: DeviceProperty.playThruVolumeRangeDecibels(for: direction, channel: channel))
        return audioValueRange.mMinimum ... audioValueRange.mMaximum
    }

    // TODO: Not sure if scope or element are applicable.
    nonisolated
    public func convertPlayThruScalarVolumeToDecibels(scalar level: Float32) throws(SwiftCoreAudioError) -> Float32 {
        let convertedValue = try getPropertyValue(property: DeviceProperty.playThruVolumeScalarToDecibels, qualifier: .float32(level))
        return convertedValue
    }

    // TODO: Not sure if scope or element are applicable.
    nonisolated
    public func convertPlayThruDecibelsVolumeToScalar(scalar level: Float32) throws(SwiftCoreAudioError) -> Float32 {
        let convertedValue = try getPropertyValue(property: DeviceProperty.playThruVolumeDecibelsToScalar, qualifier: .float32(level))
        return convertedValue
    }

    nonisolated
    public func playThruStereoPan(for direction: AudioStream.Direction, channel: Int?) throws(SwiftCoreAudioError) -> Float32 {
        try getPropertyValue(property: DeviceProperty.playThruStereoPan(for: direction, channel: channel))
    }

    nonisolated
    public func setPlayThruStereoPan(for direction: AudioStream.Direction, channel: Int?, to value: Float32) throws(SwiftCoreAudioError) {
        try setPropertyValue(property: DeviceProperty.playThruStereoPan(for: direction, channel: channel), value: value)
    }

    // TODO: Not sure if scope is applicable.
    nonisolated
    public func playThruStereoPanChannels(for direction: AudioStream.Direction) throws(SwiftCoreAudioError) -> StereoAudioChannelIndexes? {
        // Core Audio returns 1-based number series
        guard let (left, right) = try withRecovery(
            getPropertyValue(property: DeviceProperty.playThruStereoPanChannels(for: direction)),
            unknownPropertyDefault: nil
        ) else { return nil }

        return StereoAudioChannelIndexes(leftNumber: left, rightNumber: right)
    }

    // TODO: Not sure if element is applicable.
    // TODO: Not sure if property is settable.
    nonisolated
    public func playThruDestinationIDs(for direction: AudioStream.Direction, channel: Int?) throws(SwiftCoreAudioError) -> [UInt32] {
        try getPropertyValue(property: DeviceProperty.playThruDestination)
    }

    // TODO: Not sure if element is applicable.
    nonisolated
    public func playThruDestinationsIDs(for direction: AudioStream.Direction, channel: Int?) throws(SwiftCoreAudioError) -> [UInt32] {
        try getPropertyValue(property: DeviceProperty.playThruDestinations)
    }

    nonisolated
    public func playThruDestinationName(forID dataSourceID: UInt32) throws(SwiftCoreAudioError) -> String {
        try getPropertyValue(property: DeviceProperty.playThruDestinationNameForID, input: dataSourceID)
    }

    // TODO: Not sure if scope or element are applicable.
    nonisolated
    public var channelNominalLineLevelIDs: [UInt32] {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: DeviceProperty.channelNominalLineLevel)
        }
    }

    // TODO: Not sure if scope or element are applicable.
    nonisolated
    public var channelNominalLineLevelsIDs: [UInt32] {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: DeviceProperty.channelNominalLineLevels)
        }
    }

    nonisolated
    public func channelNominalLineLevelName(forID dataSourceID: UInt32) throws(SwiftCoreAudioError) -> String {
        try getPropertyValue(property: DeviceProperty.channelNominalLineLevelNameForID, input: dataSourceID)
    }

    // TODO: Not sure if scope or element are applicable.
    nonisolated
    public var highPassFilterSettingIDs: [UInt32] {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: DeviceProperty.highPassFilterSetting)
        }
    }

    // TODO: Not sure if scope or element are applicable.
    nonisolated
    public var highPassFilterSettingsIDs: [UInt32] {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: DeviceProperty.highPassFilterSettings)
        }
    }

    nonisolated
    public func highPassFilterSettingName(forID dataSourceID: UInt32) throws(SwiftCoreAudioError) -> String {
        try getPropertyValue(property: DeviceProperty.highPassFilterSettingNameForID, input: dataSourceID)
    }

    nonisolated
    public var subVolumeScalar: Float32 {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: DeviceProperty.subVolumeScalar)
        }
    }

    nonisolated
    public func setSubVolumeScalar(to value: Float32) throws(SwiftCoreAudioError) {
        try setPropertyValue(property: DeviceProperty.subVolumeScalar, value: value)
    }

    nonisolated
    public var subVolumeDecibels: Float32 {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: DeviceProperty.subVolumeDecibels)
        }
    }

    nonisolated
    public func setSubVolumeDecibels(to value: Float32) throws(SwiftCoreAudioError) {
        try setPropertyValue(property: DeviceProperty.subVolumeDecibels, value: value)
    }

    nonisolated
    public var subVolumeRangeDecibels: ClosedRange<Double> {
        get throws(SwiftCoreAudioError) {
            let audioValueRange = try getPropertyValue(property: DeviceProperty.subVolumeRangeDecibels)
            return audioValueRange.mMinimum ... audioValueRange.mMaximum
        }
    }

    nonisolated
    public func convertSubVolumeScalarToDecibels(scalar level: Float32) throws(SwiftCoreAudioError) -> Float32 {
        let convertedValue = try getPropertyValue(property: DeviceProperty.subVolumeScalarToDecibels, qualifier: .float32(level))
        return convertedValue
    }

    nonisolated
    public func convertSubVolumeDecibelsToScalar(scalar level: Float32) throws(SwiftCoreAudioError) -> Float32 {
        let convertedValue = try getPropertyValue(property: DeviceProperty.subVolumeDecibelsToScalar, qualifier: .float32(level))
        return convertedValue
    }

    nonisolated
    public var isSubMuted: Bool {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: DeviceProperty.isSubMuted)
        }
    }

    nonisolated
    public func setIsSubMuted(to value: Bool) throws(SwiftCoreAudioError) {
        try setPropertyValue(property: DeviceProperty.isSubMuted, value: value)
    }

    nonisolated
    public func isVoiceActivityDetectionEnabled(forInputChannel channel: Int) throws(SwiftCoreAudioError) -> Bool {
        try getPropertyValue(property: DeviceProperty.isVoiceActivityDetectionEnabled(forInputChannel: channel))
    }

    nonisolated
    public func setIsVoiceActivityDetectionEnabled(forInputChannel channel: Int, to value: Bool) throws(SwiftCoreAudioError) -> Bool {
        try setPropertyValue(property: DeviceProperty.isVoiceActivityDetectionEnabled(forInputChannel: channel), value: value)
    }

    nonisolated
    public func isVoiceActivityDetected(forInputChannel channel: Int) throws(SwiftCoreAudioError) -> Bool {
        try getPropertyValue(property: DeviceProperty.isVoiceActivityDetected(forInputChannel: channel))
    }

    nonisolated
    public var isControlRestorationWanted: Bool {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: DeviceProperty.isControlRestorationWanted)
        }
    }

    nonisolated
    public var isStreamFormatsRestorationWanted: Bool {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: DeviceProperty.isStreamFormatsRestorationWanted)
        }
    }
}

#endif
