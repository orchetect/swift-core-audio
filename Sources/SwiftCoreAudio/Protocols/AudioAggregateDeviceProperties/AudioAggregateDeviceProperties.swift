//
//  AudioAggregateDeviceProperties.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

// swiftformat:disable opaqueGenericParameters

/// Properties offered by the Core Audio `AudioAggregateDevice` class.
public protocol AudioAggregateDeviceProperties where Self: AudioObject, Self: AudioDeviceProperties {
    // MARK: CoreAudio/AudioHardware.h

    /// Returns the UIDs of all the devices, active or inactive, contained in the aggregate.
    ///
    /// The order of the items in the array is significant and is used to determine the order of the
    /// streams of the aggregate.
    nonisolated
    var subdeviceUIDs: [AudioSubDevice.UID] { get throws(SwiftCoreAudioError) }

    /// Sets the UIDs of all the subdevices, active or inactive, contained in the aggregate.
    ///
    /// The order of the items in the array is significant and is used to determine the order of the
    /// streams of the aggregate.
    nonisolated
    func setSubdevices<Device: AudioDeviceProperties>(uids: some Sequence<Device.UID>) throws(SwiftCoreAudioError)

    /// Returns all of the active devices contained in the aggregate.
    nonisolated
    var activeSubdevices: [AudioSubDevice] { get throws(SwiftCoreAudioError) }

    nonisolated
    var compositionDictionary: [String: Any] { get throws(SwiftCoreAudioError) }

    /// A dictionary that describes the composition of the aggregate.
    nonisolated
    var composition: AudioAggregateDevice.Composition { get throws(SwiftCoreAudioError) }

    /// Sets the dictionary that describes the composition of the aggregate.
    ///
    /// > Note:
    /// >
    /// > The aggregate always retains the original UID that was used to create it, no matter whether
    /// > a new UID is supplied within the new `composition` or not.
    /// >
    /// > If a new UID is supplied within the new composition, the new UID will be stored and returned when
    /// > the aggregate's ``composition`` is later retrieved. However, the new UID cannot be used to
    /// > look up the aggregate in Core Audio (``AudioSystemProperties/device(forUID:)-9imh0``).
    /// > The original UID that was used to create it in order to look the aggregate up.
    nonisolated
    func setComposition(_ composition: AudioAggregateDevice.Composition) throws(SwiftCoreAudioError)

    /// Returns the UID of the device that is currently serving as the time base of the aggregate device.
    /// Returns `nil` if the aggregate does not contain any subdevices.
    ///
    /// When an aggregate device has at least one subdevice, Core Audio will automatically assign the
    /// first subdevice to be its main subdevice. You are able to reassign the main subdevice role
    /// to any of the aggregate's subdevices. When an aggregate has no subdevices, it does not have a
    /// main subdevice and one cannot be assigned.
    nonisolated
    var mainSubdeviceUID: AudioSubDevice.UID? { get throws(SwiftCoreAudioError) }

    /// Sets the UID of the subdevice that is currently serving as the time base of the aggregate device.
    /// The UID must be a UID of one of the aggregate's subdevices.
    ///
    /// When an aggregate device has at least one subdevice, Core Audio will automatically assign the
    /// first subdevice to be its main subdevice. You are able to reassign the main subdevice role
    /// to any of the aggregate's subdevices. When an aggregate has no subdevices, it does not have a
    /// main subdevice and one cannot be assigned.
    nonisolated
    func setMainSubdevice<Device: AudioDeviceProperties>(uid: Device.UID) throws(SwiftCoreAudioError)

    /// Returns the UID for the clock that is currently serving as the time base of the aggregate device.
    ///
    /// If the aggregate device includes both a main audio device and a clock device, the clock
    /// device will control the time base.
    nonisolated
    var clockUID: AudioClock.UID? { get throws(SwiftCoreAudioError) }

    /// Sets the UID of the device that is currently serving as the time base of the aggregate
    /// device.
    ///
    /// If the aggregate device includes both a main audio device and a clock device, the clock
    /// device will control the time base.
    ///
    /// Setting this property will enable drift correction for all subdevices in the
    /// aggregate device.
    nonisolated
    func setClock<Clock: AudioClockProperties>(uid: Clock.UID) throws(SwiftCoreAudioError)

    /// Returns the UIDs of all the taps contained in the aggregate.
    nonisolated
    var tapUIDs: [AudioTap.UID] { get throws(SwiftCoreAudioError) }

    /// Sets the UIDs of all the taps contained in the aggregate.
    nonisolated
    func setTaps<Tap: AudioTapProperties>(uids: some Sequence<Tap.UID>) throws(SwiftCoreAudioError)

    /// Returns all of the active subtaps contained in the aggregate.
    nonisolated
    var activeSubtaps: [AudioSubTap] { get throws(SwiftCoreAudioError) }
}

#endif
