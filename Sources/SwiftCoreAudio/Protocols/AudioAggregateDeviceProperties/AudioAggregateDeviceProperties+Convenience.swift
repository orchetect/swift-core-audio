//
//  AudioAggregateDeviceProperties+Convenience.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// swiftformat:disable opaqueGenericParameters

// MARK: - Convenience: Lifecycle

extension AudioAggregateDeviceProperties {
    /// A convenience to update the aggregate's ``composition``.
    /// Any parameters that remain `nil` will not be modified from their current values.
    ///
    /// Note that the aggregate's UID cannot be changed after the aggregate has been created.
    ///
    /// If only setting one parameter, see additional available set methods:
    ///
    /// - ``setMainSubdevice(uid:)-(AudioSubDevice.UID)``
    /// - ``setClock(uid:)``
    /// - ``setSubdevices(uids:)-(Sequence<AudioSubDevice.UID>)``
    /// - ``setTaps(uids:)``
    ///
    /// For information on parameters, see ``AudioAggregateDevice/Composition``.
    nonisolated
    public func update<Clock: AudioClockProperties, MainDevice: AudioDeviceProperties>(
        name: String? = nil,
        subdevices: [AudioAggregateDevice.Composition.SubDevice]? = nil,
        subtaps: [AudioAggregateDevice.Composition.SubTap]? = nil,
        clockUID: Clock.UID? = nil as AudioClock.UID?,
        mainSubdeviceUID: MainDevice.UID? = nil as AudioSubDevice.UID?,
        isPrivate: Bool? = nil,
        isStacked: Bool? = nil,
        isTapAutoStartEnabled: Bool? = nil
    ) throws(SwiftCoreAudioError) {
        // get existing composition
        var composition = try composition

        // update non-nil method parameters
        if let name { composition.name = name }
        if let subdevices { composition.subdevices = subdevices }
        if let subtaps { composition.subtaps = subtaps }
        if let clockUID { composition.clockUID = .init(rawValue: clockUID.rawValue) }
        if let mainSubdeviceUID { composition.mainSubdeviceUID = .init(rawValue: mainSubdeviceUID.rawValue) }
        if let isPrivate { composition.isPrivate = isPrivate }
        if let isStacked { composition.isStacked = isStacked }
        if let isTapAutoStartEnabled { composition.isTapAutoStartEnabled = isTapAutoStartEnabled }

        // set the new composition
        try setComposition(composition)
    }

    /// A convenience to update the aggregate's ``composition``.
    /// Any parameters that remain `nil` will not be modified from their current values.
    ///
    /// Note that the aggregate's UID cannot be changed after the aggregate has been created.
    ///
    /// If only setting one parameter, see additional available set methods:
    ///
    /// - ``setMainSubdevice(uid:)-(AudioSubDevice.UID)``
    /// - ``setClock(uid:)``
    /// - ``setSubdevices(uids:)-(Sequence<AudioSubDevice.UID>)``
    /// - ``setTaps(uids:)-4vjxn``
    ///
    /// For information on parameters, see ``AudioAggregateDevice/Composition``.
    @_disfavoredOverload
    nonisolated
    public func update<
        Device: AudioDeviceProperties,
        Tap: AudioTapProperties,
        Clock: AudioClockProperties,
        MainDevice: AudioDeviceProperties
    >(
        name: String? = nil,
        deviceUIDs: [Device.UID]? = nil as [AudioDevice.UID]?,
        tapUIDs: [Tap.UID]? = nil as [AudioTap.UID]?,
        clockUID: Clock.UID? = nil as AudioClock.UID?,
        mainSubdeviceUID: MainDevice.UID? = nil as AudioSubDevice.UID?,
        isPrivate: Bool? = nil,
        isStacked: Bool? = nil,
        isTapAutoStartEnabled: Bool? = nil
    ) throws(SwiftCoreAudioError) {
        let mappedSubdevices: [AudioAggregateDevice.Composition.SubDevice]? = deviceUIDs?
            .map(\.rawValue)
            .map { .init(uid: AudioSubDevice.UID($0)) }
        let mappedSubtaps: [AudioAggregateDevice.Composition.SubTap]? = tapUIDs?
            .map(\.rawValue)
            .map { .init(uid: AudioTap.UID($0)) }

        try update(
            name: name,
            subdevices: mappedSubdevices,
            subtaps: mappedSubtaps,
            clockUID: clockUID,
            mainSubdeviceUID: mainSubdeviceUID,
            isPrivate: isPrivate,
            isStacked: isStacked,
            isTapAutoStartEnabled: isTapAutoStartEnabled
        )
    }

    /// Destroys the aggregate device.
    ///
    /// Convenience for calling ``AudioSystem/destroyAggregateDevice(_:waitForCompletionWithTimeout:)``
    /// on ``AudioSystem``.
    ///
    /// If an aggregate does not exist, this method will return gracefully without throwing an error.
    ///
    /// - Parameters:
    ///   - timeout: If non-`nil`, waits synchronously for Core Audio to complete destroying the
    ///     aggregate before returning.
    nonisolated
    public func destroy(
        waitForCompletionWithTimeout timeout: TimeInterval? = 5.0
    ) throws(SwiftCoreAudioError) {
        try AudioSystem.shared.destroyAggregateDevice(self, waitForCompletionWithTimeout: timeout)
    }
}

// MARK: - Convenience: Properties

extension AudioAggregateDeviceProperties {
    /// Returns a boolean value that indicates whether the aggregate is private.
    ///
    /// Convenience for fetching the aggregate's ``composition`` dictionary and reading the
    /// `kAudioAggregateDeviceIsPrivateKey` key value.
    nonisolated
    public var isPrivate: Bool {
        get throws(SwiftCoreAudioError) {
            let key = kAudioAggregateDeviceIsPrivateKey
            let dict = try getPropertyValue(
                property: AggregateDeviceProperty.composition,
                keys: [key]
            )

            // if key is not present, return a default value
            guard let value = dict[key] else { return false }

            // if value for key is of the wrong/unexpected type, throw an error
            guard let intValue = value as? Int else {
                let rawValue = String(describing: value)
                throw .failedToLookupAggregateComposition(
                    message: "IsPrivate key did not return expected value type for aggregate with ID \(id). Got: \(rawValue)"
                )
            }

            return intValue == 1
        }
    }

    /// Returns a boolean value that indicates whether the aggregate is stacked.
    ///
    /// Convenience for fetching the aggregate's ``composition`` dictionary and reading the
    /// `kAudioAggregateDeviceIsStackedKey` key value.
    nonisolated
    public var isStacked: Bool {
        get throws(SwiftCoreAudioError) {
            let key = kAudioAggregateDeviceIsStackedKey
            let dict = try getPropertyValue(
                property: AggregateDeviceProperty.composition,
                keys: [key]
            )

            // if key is not present, return a default value
            guard let value = dict[key] else { return false }

            // if value for key is of the wrong/unexpected type, throw an error
            guard let intValue = value as? Int else {
                let rawValue = String(describing: value)
                throw .failedToLookupAggregateComposition(
                    message: "IsStacked key did not return expected value type for aggregate with ID \(id). Got: \(rawValue)"
                )
            }

            return intValue == 1
        }
    }

    /// Returns a boolean value that indicates whether the aggregate has tap auto-start enabled..
    ///
    /// Convenience for fetching the aggregate's ``composition`` dictionary and reading the
    /// `kAudioAggregateDeviceTapAutoStartKey` key value.
    nonisolated
    public var isTapAutoStartEnabled: Bool {
        get throws(SwiftCoreAudioError) {
            let key = kAudioAggregateDeviceTapAutoStartKey
            let dict = try getPropertyValue(
                property: AggregateDeviceProperty.composition,
                keys: [key]
            )

            // if key is not present, return a default value
            guard let value = dict[key] else { return false }

            // if value for key is of the wrong/unexpected type, throw an error
            guard let intValue = value as? Int else {
                let rawValue = String(describing: value)
                throw .failedToLookupAggregateComposition(
                    message: "TapAutoStart key did not return expected value type for aggregate with ID \(id). Got: \(rawValue)"
                )
            }

            return intValue == 1
        }
    }
}

// MARK: - Convenience: Composition

extension AudioAggregateDeviceProperties {
    /// A dictionary that describes the composition of the aggregate.
    nonisolated
    public var compositionDictionary: [String: Any] {
        get throws(SwiftCoreAudioError) {
            let dict = try getPropertyValue(property: AggregateDeviceProperty.composition)
            return dict
        }
    }

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
    public func setComposition(_ composition: [String: Any]) throws(SwiftCoreAudioError) {
        try setPropertyValue(property: AggregateDeviceProperty.composition, value: composition)
    }
}

// MARK: - Convenience: Subdevices

extension AudioAggregateDeviceProperties {
    // MARK: List

    /// Returns all the subdevices by resolving to their IDs, active or inactive, contained in the aggregate.
    ///
    /// The order of the items in the array is significant and is used to determine the order of the
    /// streams of the aggregate.
    ///
    /// - Parameters:
    ///   - uidLookupErrorHandler: Optionally supply an error handler that will be called for any UIDs that fail lookup.
    ///     If this closure is `nil`, failures are silently ignored but will still be logged.
    nonisolated
    public func subdevices(
        uidLookupErrorHandler: ((_ uid: AudioSubDevice.UID, _ error: SwiftCoreAudioError) -> Void)? = nil
    ) throws(SwiftCoreAudioError) -> [AudioSubDevice] {
        let uids = try subdeviceUIDs

        var devices: [AudioSubDevice] = []
        for uid in uids {
            do throws(SwiftCoreAudioError) {
                guard let device = try AudioSubDevice(uid: uid) else {
                    throw .osStatus(
                        AudioOSStatusError(unsafe: .badObject),
                        message: "Error looking up an aggregate's audio subdevice with UID: \(uid)."
                    )
                }
                devices.append(device)
            } catch {
                Logging.log(.error, "Error getting aggregate subdevice: \(error)")
                uidLookupErrorHandler?(uid, error)
            }
        }
        return devices
    }

    // MARK: Set by Objects

    /// Sets the subdevices by resolving to their UIDs, active or inactive, contained in the aggregate.
    ///
    /// The order of the items in the array is significant and is used to determine the order of the
    /// streams of the aggregate.
    ///
    /// - Parameters:
    ///   - devices: Subdevices to set.
    ///   - deviceLookupErrorHandler: Optionally supply an error handler that will be called for any
    ///     subdevices that fail lookup.
    ///     If this closure is `nil`, failures are silently ignored but will still be logged.
    nonisolated
    public func setSubdevices<Device: AudioDeviceProperties>(
        _ devices: some Sequence<Device>,
        deviceLookupErrorHandler: ((_ device: Device, _ error: SwiftCoreAudioError) -> Void)? = nil
    ) throws(SwiftCoreAudioError) {
        var uids: [Device.UID] = []
        for device in devices {
            do throws(SwiftCoreAudioError) {
                let uid = try device.uid
                uids.append(uid)
            } catch {
                Logging.log(.error, "Error setting aggregate subdevice: \(error)")
                deviceLookupErrorHandler?(device, error)
            }
        }
        try setSubdevices(uids: uids)
    }

    // type-free version of above function allowing empty array use (`[]`) without type ambiguity
    /// Sets the subdevices by resolving to their UIDs, active or inactive, contained in the aggregate.
    ///
    /// The order of the items in the array is significant and is used to determine the order of the
    /// streams of the aggregate.
    ///
    /// - Parameters:
    ///   - devices: Subdevices to set.
    ///   - deviceLookupErrorHandler: Optionally supply an error handler that will be called for any
    ///     subdevices that fail lookup.
    ///     If this closure is `nil`, failures are silently ignored but will still be logged.
    nonisolated
    public func setSubdevices(
        _ devices: [Never],
        deviceLookupErrorHandler: ((_ device: Never, _ error: SwiftCoreAudioError) -> Void)? = nil
    ) throws(SwiftCoreAudioError) {
        try setSubdevices([] as [AudioDevice], deviceLookupErrorHandler: nil)
    }

    // MARK: Add/Remove by Object

    /// Add one or more subdevices to the aggregate device by resolving to their UIDs.
    ///
    /// - Parameters:
    ///   - devices: Subdevices to set.
    ///   - deviceLookupErrorHandler: Optionally supply an error handler that will be called for any
    ///     subdevices that fail lookup.
    ///     If this closure is `nil`, failures are silently ignored but will still be logged.
    @_disfavoredOverload
    nonisolated
    public func addSubdevices<Device: AudioDeviceProperties>(
        _ devices: some Sequence<Device>,
        deviceLookupErrorHandler: ((_ device: Device, _ error: SwiftCoreAudioError) -> Void)? = nil
    ) throws(SwiftCoreAudioError) {
        let devices = Array(devices)
        guard !devices.isEmpty else { return }
        
        var uids: [AudioSubDevice.UID] = try subdeviceUIDs

        for device in devices {
            do throws(SwiftCoreAudioError) {
                let uid = try device.uid
                uids.append(.init(rawValue: uid.rawValue))
            } catch {
                Logging.log(.error, "Error adding aggregate subdevice: \(error)")
                deviceLookupErrorHandler?(device, error)
            }
        }

        try addSubdevices(withUIDs: uids)
    }

    /// Remove one or more subdevices from the aggregate device by resolving to their UIDs.
    ///
    /// - Parameters:
    ///   - devices: Subdevices to set.
    ///   - deviceLookupErrorHandler: Optionally supply an error handler that will be called for any
    ///     subdevices that fail lookup.
    ///     If this closure is `nil`, failures are silently ignored but will still be logged.
    nonisolated
    public func removeSubdevices<Device: AudioDeviceProperties>(
        _ devices: some Sequence<Device>,
        deviceLookupErrorHandler: ((_ device: Device, _ error: SwiftCoreAudioError) -> Void)? = nil
    ) throws(SwiftCoreAudioError) {
        let devices = Array(devices)
        guard !devices.isEmpty else { return }

        var uids: [AudioSubDevice.UID] = try subdeviceUIDs

        for device in devices {
            do throws(SwiftCoreAudioError) {
                let uid = try device.uid
                uids.append(.init(uid.rawValue))
            } catch {
                Logging.log(.error, "Error removing aggregate subdevice; could not look up its UID. \(error)")
                deviceLookupErrorHandler?(device, error)
            }
        }

        try removeSubdevices(withUIDs: uids)
    }

    // MARK: Add/Remove by UIDs

    /// Add one or more subdevices to the aggregate device.
    nonisolated
    public func addSubdevices<Device: AudioDeviceProperties>(
        withUIDs uids: some Sequence<Device.UID>
    ) throws(SwiftCoreAudioError) {
        let uids = Array(uids)
        guard !uids.isEmpty else { return }

        var subdeviceUIDs = try subdeviceUIDs

        // add new subdevices, disallowing duplicates
        for someUID in uids {
            let uid = AudioSubDevice.UID(rawValue: someUID.rawValue)
            if !subdeviceUIDs.contains(uid) {
                subdeviceUIDs.append(uid)
            }
        }

        // Set the list back on the aggregate device.
        try setSubdevices(uids: subdeviceUIDs)
    }

    /// Remove one or more subdevices from the aggregate device.
    nonisolated
    public func removeSubdevices<Device: AudioDeviceProperties>(
        withUIDs uids: some Sequence<Device.UID>
    ) throws(SwiftCoreAudioError) {
        let uids = Array(uids)
        guard !uids.isEmpty else { return }

        var subdeviceUIDs = try subdeviceUIDs

        subdeviceUIDs.removeAll { existingUID in
            uids.contains { $0.rawValue == existingUID.rawValue }
        }

        // Set the list back on the aggregate device.
        try setSubdevices(uids: subdeviceUIDs)
    }

    // MARK: Cleanup Methods

    /// Remove all the subdevices from the aggregate audio device.
    nonisolated
    public func clearSubdevices() throws(SwiftCoreAudioError) {
        try setSubdevices(uids: [])
    }

    /// Remove stale subdevices from the aggregate that no longer exist in the system.
    nonisolated
    public func removeStaleDevices() throws(SwiftCoreAudioError) {
        let subdeviceUIDs = try subdeviceUIDs

        var staleSubdevices: [AudioSubDevice.UID] = []
        for subdeviceUID in subdeviceUIDs {
            // check if subdevice exists in the system
            if !((try? AudioSubDevice(uid: subdeviceUID))?.isPresent ?? false) {
                staleSubdevices.append(subdeviceUID)
            }
        }

        if !staleSubdevices.isEmpty {
            try removeSubdevices(withUIDs: staleSubdevices)
        }
    }
}

// MARK: - Convenience: Subtaps

extension AudioAggregateDeviceProperties {
    // MARK: List

    /// Returns all the taps contained in the aggregate by resolving to their UIDs.
    ///
    /// - Parameters:
    ///   - uidLookupErrorHandler: Optionally supply an error handler that will be called for any UIDs that fail lookup.
    ///     If this closure is `nil`, failures are silently ignored but will still be logged.
    nonisolated
    public func taps(
        uidLookupErrorHandler: ((_ uid: AudioTap.UID, _ error: SwiftCoreAudioError) -> Void)? = nil
    ) throws(SwiftCoreAudioError) -> [AudioTap] {
        let uids = try tapUIDs

        var taps: [AudioTap] = []
        for uid in uids {
            do throws(SwiftCoreAudioError) {
                guard let tap = try AudioTap(uid: uid) else {
                    throw .osStatus(
                        AudioOSStatusError(unsafe: .badObject),
                        message: "Error looking up an aggregate's audio subtap with UID: \(uid)."
                    )
                }
                taps.append(tap)
            } catch {
                Logging.log(.error, "Error getting aggregate tap: \(error)")
                uidLookupErrorHandler?(uid, error)
            }
        }
        return taps
    }

    // MARK: Set by Objects

    /// Sets all the taps contained in the aggregate by resolving to their UIDs.
    ///
    /// - Parameters:
    ///   - taps: Taps to set.
    ///   - tapLookupErrorHandler: Optionally supply an error handler that will be called for any
    ///     subtaps that fail lookup.
    ///     If this closure is `nil`, failures are silently ignored but will still be logged.
    nonisolated
    public func setTaps<Tap: AudioTapProperties>(
        _ taps: some Sequence<Tap>,
        tapLookupErrorHandler: ((_ tap: Tap, _ error: SwiftCoreAudioError) -> Void)? = nil
    ) throws(SwiftCoreAudioError) {
        var uids: [Tap.UID] = []
        for tap in taps {
            do throws(SwiftCoreAudioError) {
                let uid = try tap.uid
                uids.append(uid)
            } catch {
                Logging.log(.error, "Error setting aggregate subtap; could not look up its UID. \(error)")
                tapLookupErrorHandler?(tap, error)
            }
        }
        try setTaps(uids: uids)
    }

    // type-free version of above function allowing empty array use (`[]`) without type ambiguity
    /// Sets all the taps contained in the aggregate by resolving to their UIDs.
    ///
    /// - Parameters:
    ///   - taps: Taps to set.
    ///   - tapLookupErrorHandler: Optionally supply an error handler that will be called for any
    ///     subtaps that fail lookup.
    ///     If this closure is `nil`, failures are silently ignored but will still be logged.
    nonisolated
    public func setTaps(
        _ taps: [Never],
        tapLookupErrorHandler: ((_ tap: Never, _ error: SwiftCoreAudioError) -> Void)? = nil
    ) throws(SwiftCoreAudioError) {
        try setTaps([] as [AudioTap], tapLookupErrorHandler: nil)
    }

    // MARK: Add/Remove by Objects

    /// Add one or more subtaps to the aggregate device by resolving to their UIDs.
    ///
    /// - Parameters:
    ///   - taps: Taps to add.
    ///   - tapLookupErrorHandler: Optionally supply an error handler that will be called for any
    ///     subtaps that fail lookup.
    ///     If this closure is `nil`, failures are silently ignored but will still be logged.
    nonisolated
    public func addTaps<Tap: AudioTapProperties>(
        _ taps: some Sequence<Tap>,
        tapLookupErrorHandler: ((_ tap: Tap, _ error: SwiftCoreAudioError) -> Void)? = nil
    ) throws(SwiftCoreAudioError) {
        let taps = Array(taps)
        guard !taps.isEmpty else { return }

        var uids: [Tap.UID] = []
        for tap in taps {
            do throws(SwiftCoreAudioError) {
                let uid = try tap.uid
                uids.append(uid)
            } catch {
                Logging.log(.error, "Error adding aggregate subtap; could not look up its UID. \(error)")
                tapLookupErrorHandler?(tap, error)
            }
        }
        try addTaps(withUIDs: uids)
    }

    /// Remove one or more subtaps from the aggregate device by resolving to their UIDs.
    /// If the subtaps exist, they can be optionally destroyed.
    ///
    /// - Parameters:
    ///   - taps: Subdevices to set.
    ///   - tapLookupErrorHandler: Optionally supply an error handler that will be called for any
    ///     subtaps that fail lookup.
    ///     If this closure is `nil`, failures are silently ignored but will still be logged.
    nonisolated
    public func removeTaps<Tap: AudioTapProperties>(
        _ taps: some Sequence<Tap>,
        destroyTapsIfNeeded: Bool = false,
        tapLookupErrorHandler: ((_ tap: Tap, _ error: SwiftCoreAudioError) -> Void)? = nil
    ) throws(SwiftCoreAudioError) {
        let taps = Array(taps)
        guard !taps.isEmpty else { return }
        
        var uids: [Tap.UID] = []
        for tap in taps {
            do throws(SwiftCoreAudioError) {
                let uid = try tap.uid
                uids.append(uid)
            } catch {
                Logging.log(.error, "Error removing aggregate subtap; could not look up its UID. \(error)")
                tapLookupErrorHandler?(tap, error)
            }
        }
        try removeTaps(withUIDs: uids, destroyTapsIfNeeded: destroyTapsIfNeeded)
    }

    // MARK: Add/Remove by UIDs

    /// Add one or more subtaps to the aggregate device.
    nonisolated
    public func addTaps<Tap: AudioTapProperties>(
        withUIDs uids: some Sequence<Tap.UID>
    ) throws(SwiftCoreAudioError) {
        let uids = Array(uids)
        guard !uids.isEmpty else { return }

        var tapUIDs = try tapUIDs

        for someUID in uids {
            let uid = AudioTap.UID(rawValue: someUID.rawValue)
            if !tapUIDs.contains(uid) {
                tapUIDs.append(uid)
            }
        }

        // Set the list back on the aggregate device.
        try setTaps(uids: tapUIDs)
    }

    /// Remove one or more subtaps from the aggregate device.
    /// If the subtaps exist, they can be optionally destroyed.
    nonisolated
    public func removeTaps<Tap: AudioTapProperties>(
        withUIDs uids: some Sequence<Tap.UID>,
        destroyTapsIfNeeded: Bool = false
    ) throws(SwiftCoreAudioError) {
        let uids = Array(uids)
        guard !uids.isEmpty else { return }

        var tapUIDs = try tapUIDs

        tapUIDs.removeAll { existingUID in
            uids.contains { $0.rawValue == existingUID.rawValue }
        }

        // Set the list back on the aggregate device.
        try setTaps(uids: tapUIDs)

        // destroy taps if they exist
        #if !targetEnvironment(macCatalyst)
        if destroyTapsIfNeeded, #available(macOS 14.2, *) {
            for someUID in uids {
                let uid = AudioTap.UID(rawValue: someUID.rawValue)
                guard let tap = try? AudioTap(uid: uid) else { continue }
                try? AudioSystem.shared.destroyTap(tap)
            }
        }
        #endif
    }

    // MARK: Cleanup Methods

    /// Remove all the subtaps from the aggregate audio device.
    nonisolated
    public func clearTaps() throws(SwiftCoreAudioError) {
        try setTaps(uids: [])
    }

    /// Remove stale subtaps from the aggregate that no longer exist in the system.
    nonisolated
    public func removeStaleTaps(destroyTapsIfNeeded: Bool = false) throws(SwiftCoreAudioError) {
        let tapUIDs = try tapUIDs

        var staleTapUIDs: [AudioTap.UID] = []
        for tapUID in tapUIDs {
            // check if subtap has a UID, if not then it likely does not exist in the system
            if (try? AudioSystem.shared.tap(forUID: tapUID)) == nil {
                staleTapUIDs.append(tapUID)
            }
        }

        if !staleTapUIDs.isEmpty {
            try removeTaps(withUIDs: staleTapUIDs, destroyTapsIfNeeded: destroyTapsIfNeeded)
        }
    }
}

#endif
