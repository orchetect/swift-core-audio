//
//  AudioAggregateDeviceProperties+Implementation.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

// swiftformat:disable opaqueGenericParameters

import CoreAudio
import SwiftProcess

extension AudioAggregateDeviceProperties {
    // MARK: CoreAudio/AudioHardware.h

    nonisolated
    public var subdeviceUIDs: [AudioSubDevice.UID] {
        get throws(SwiftCoreAudioError) {
            let uids = try getPropertyValue(property: AggregateDeviceProperty.fullSubDeviceList)
            return uids.map(AudioSubDevice.UID.init(rawValue:))
        }
    }

    nonisolated
    public func setSubdevices<Device: AudioDeviceProperties>(
        uids: some Sequence<Device.UID>
    ) throws(SwiftCoreAudioError) {
        try setPropertyValue(property: AggregateDeviceProperty.fullSubDeviceList, value: uids.map(\.rawValue))
    }

    // type-free version of above function allowing empty array use (`[]`) without type ambiguity
    @_disfavoredOverload
    nonisolated
    public func setSubdevices(
        uids: [Never]
    ) throws(SwiftCoreAudioError) {
        try setPropertyValue(property: AggregateDeviceProperty.fullSubDeviceList, value: [])
    }

    nonisolated
    public var activeSubdevices: [AudioSubDevice] {
        get throws(SwiftCoreAudioError) {
            let ids = try getPropertyValue(property: AggregateDeviceProperty.activeSubDeviceList)
            return ids.map(AudioSubDevice.init(id:))
        }
    }

    nonisolated
    public var composition: AudioAggregateDevice.Composition {
        get throws(SwiftCoreAudioError) {
            let dict = try getPropertyValue(property: AggregateDeviceProperty.composition)
            let composition = AudioAggregateDevice.Composition(dictionary: dict)
            return composition
        }
    }

    nonisolated
    public func setComposition(_ composition: AudioAggregateDevice.Composition) throws(SwiftCoreAudioError) {
        let dict = composition.dictionary()
        try setPropertyValue(property: AggregateDeviceProperty.composition, value: dict)
    }

    nonisolated
    public var mainSubdeviceUID: AudioSubDevice.UID? {
        get throws(SwiftCoreAudioError) {
            let uid = try getPropertyValue(property: AggregateDeviceProperty.mainSubDevice)
            // interpret empty string as `nil`
            guard !uid.isEmpty else { return nil }
            return AudioSubDevice.UID(rawValue: uid)
        }
    }

    nonisolated
    public func setMainSubdevice<Device: AudioDeviceProperties>(uid: Device.UID) throws(SwiftCoreAudioError) {
        try setPropertyValue(property: AggregateDeviceProperty.mainSubDevice, value: uid.rawValue)

        // Core Audio does not return an error (OSStatus) if setting the main subdevice fails,
        // it simply returns `noErr` silently.
        // It makes sense to check if the subdevice was set, and synthesize an error if not
        let getMainSubdeviceUID = try mainSubdeviceUID
        guard getMainSubdeviceUID?.rawValue == uid.rawValue else {
            throw .osStatus(
                AudioOSStatusError(unsafe: .badObject),
                message: """
                    Failed to set main subdevice UID to \(uid). The UID may be invalid or not appropriate. \
                    Using \(getMainSubdeviceUID?.rawValue ?? "no main subdevice") instead.
                    """
            )
        }
    }

    nonisolated
    public var clockUID: AudioClock.UID? {
        get throws(SwiftCoreAudioError) {
            // gracefully return `nil` if object does not have the property
            let string = try withRecovery(
                getPropertyValue(property: AggregateDeviceProperty.clockDevice),
                unknownPropertyDefault: nil
            )

            // interpret empty string as `nil`
            guard let string, !string.isEmpty else { return nil }
            return AudioClock.UID(rawValue: string)
        }
    }

    nonisolated
    public func setClock<Clock: AudioClockProperties>(uid: Clock.UID) throws(SwiftCoreAudioError) {
        try setPropertyValue(property: AggregateDeviceProperty.clockDevice, value: uid.rawValue)
    }

    nonisolated
    public var tapUIDs: [AudioTap.UID] {
        get throws(SwiftCoreAudioError) {
            let uids = try getPropertyValue(property: AggregateDeviceProperty.tapList)
            return uids.map(AudioTap.UID.init(rawValue:))
        }
    }

    nonisolated
    public func setTaps<Tap: AudioTapProperties>(uids: some Sequence<Tap.UID>) throws(SwiftCoreAudioError) {
        try setPropertyValue(property: AggregateDeviceProperty.tapList, value: uids.map(\.rawValue))
    }

    // type-free version of above function allowing empty array use (`[]`) without type ambiguity
    @_disfavoredOverload
    nonisolated
    public func setTaps(uids: [Never]) throws(SwiftCoreAudioError) {
        try setPropertyValue(property: AggregateDeviceProperty.tapList, value: [])
    }

    nonisolated
    public var activeSubtaps: [AudioSubTap] {
        get throws(SwiftCoreAudioError) {
            let ids = try getPropertyValue(property: AggregateDeviceProperty.subtapList)
            return ids.map(AudioSubTap.init(id:))
        }
    }
}

#endif
