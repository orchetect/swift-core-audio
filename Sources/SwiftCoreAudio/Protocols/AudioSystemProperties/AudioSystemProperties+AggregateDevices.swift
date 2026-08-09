//
//  AudioSystemProperties+AggregateDevices.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

// swiftformat:disable opaqueGenericParameters

import CoreAudio
import SwiftProcess

// MARK: - Object Enumeration

extension AudioSystemProperties {
    /// Returns an array of aggregate devices currently available to the system.
    nonisolated
    public var aggregates: [AudioAggregateDevice] {
        get throws(SwiftCoreAudioError) {
            try devices.audioAggregateDevices
        }
    }

    /// Returns an array of UIDs for aggregate devices currently available to the system by looking up their UIDs.
    ///
    /// - Parameters:
    ///   - uidLookupErrorHandler: Optionally supply an error handler that will be called for any UIDs that fail lookup.
    ///     If this closure is `nil`, failures are silently ignored but will still be logged.
    /// - Throws: Throws an error if device enumeration fails. Individual failures on a per-device basis are
    ///   passed to the `streamLookupErrorHandler` closure and do not cause this method itself to throw.
    nonisolated
    public func aggregateUIDs(
        uidLookupErrorHandler: ((_ device: AudioAggregateDevice, _ error: SwiftCoreAudioError) -> ())? = nil
    ) throws(SwiftCoreAudioError) -> [AudioAggregateDevice.UID] {
        let devices = try aggregates
        return devices.uids(uidLookupErrorHandler: uidLookupErrorHandler)
    }
}

// MARK: - Aggregate Device Lifecycle (Non-Async)

extension AudioSystemProperties {
    /// Create a new aggregate audio device.
    ///
    /// Note that Core Audio requires a UID when creating an aggregate device, and it must be unique
    /// in the system.
    ///
    /// - Parameters:
    ///   - composition: Composition data structure used to create the aggregate.
    ///   - timeout: If non-`nil`, waits synchronously for Core Audio to complete creating the
    ///     aggregate before returning.
    /// - Returns: If successful, returns an ``AudioAggregateDevice`` instance representing the newly
    ///   created aggregate.
    /// - Throws: Throws an error if an aggregate device with the same UID already exists.
    @discardableResult
    nonisolated
    public func makeAggregateDevice(
        composition: AudioAggregateDevice.Composition,
        waitForCompletionWithTimeout timeout: TimeInterval? = 5.0
    ) throws(SwiftCoreAudioError) -> AudioAggregateDevice {
        let cfDictionary = composition.cfDictionary()
        return try makeAggregateDevice(composition: cfDictionary, waitForCompletionWithTimeout: timeout)
    }

    /// Create a new aggregate audio device, or update an existing aggregate with the same UID.
    ///
    /// If an aggregate device with the given UID already exists, it will be updated.
    /// Otherwise, a new aggregate device will be created.
    ///
    /// - Parameters:
    ///   - composition: Composition data structure used to create the aggregate.
    ///   - timeout: If non-`nil`, waits synchronously for Core Audio to complete creating the
    ///     aggregate before returning.
    /// - Returns: If successful, returns an ``AudioAggregateDevice`` instance representing the newly
    ///   created aggregate, or the existing aggregate if one was updated.
    @discardableResult
    nonisolated
    public func makeOrUpdateAggregateDevice(
        composition: AudioAggregateDevice.Composition,
        waitForCompletionWithTimeout timeout: TimeInterval? = 5.0
    ) throws(SwiftCoreAudioError) -> AudioAggregateDevice {
        guard let aggregateUID = composition.uid else {
            throw .osStatus(
                AudioOSStatusError(unsafe: .illegalOperation),
                message: "Missing UID. A UID is required to create or update an aggregate device."
            )
        }
        if let existingAggregate = try? AudioSystem.shared.object(forUID: aggregateUID) {
            // update existing aggregate device
            try existingAggregate.setComposition(composition)
            return existingAggregate
        } else {
            // create new aggregate device
            return try makeAggregateDevice(composition: composition, waitForCompletionWithTimeout: timeout)
        }
    }

    /// Create a new aggregate audio device.
    ///
    /// Note that Core Audio requires a UID when creating an aggregate device, and it must be unique
    /// in the system.
    ///
    /// - Parameters:
    ///   - composition: Composition dictionary used to create the aggregate.
    ///   - timeout: If non-`nil`, waits synchronously for Core Audio to complete creating the
    ///     aggregate before returning.
    /// - Returns: If successful, returns an ``AudioAggregateDevice`` instance representing the newly
    ///   created aggregate.
    /// - Throws: Throws an error if an aggregate device with the same UID already exists.
    @discardableResult
    nonisolated
    public func makeAggregateDevice(
        composition: CFDictionary,
        waitForCompletionWithTimeout timeout: TimeInterval? = 5.0
    ) throws(SwiftCoreAudioError) -> AudioAggregateDevice {
        // get UID just for error/debug purposes
        let aggregateUID = (composition as NSDictionary)[kAudioAggregateDeviceUIDKey] as? String

        var aggregateID: AudioObjectID = kAudioObjectUnknown
        try AudioHardwareCreateAggregateDevice(
            composition,
            &aggregateID
        )
        .throwingSwiftCoreAudioError(
            message: {
                var msg = "Failed to create aggregate device"
                if let aggregateUID { msg += " with UID \(aggregateUID)." } else { msg += "." }
                return msg
            }()
        )

        guard aggregateID != kAudioObjectUnknown else {
            throw .aggregateCreationFailed(message: "Returned object ID is 0 (invalid).")
        }

        let newAggregate = AudioAggregateDevice(id: aggregateID)

        if let timeout {
            // CoreAudio does not fully create the aggregate synchronously, so we have to wait for changes.
            // Not ideal but it works. Ideally we hook Core Audio's notifications with a listener but that
            // is not feasible in a synchronous (non-async) context.
            let result = PollingPredicate().wait(timeout: timeout, for: {
                newAggregate.isPresent
            })
            switch result {
            case .success: break
            case .timedOut: throw .aggregateCreationTimeout
            }
        }

        return newAggregate
    }

    /// Destroys an aggregate audio device.
    ///
    /// If an aggregate does not exist, this method will return gracefully without throwing an error.
    ///
    /// - Parameters:
    ///   - aggregate: The aggregate device to destroy.
    ///   - timeout: If non-`nil`, waits synchronously for Core Audio to complete destroying the
    ///     aggregate before returning.
    nonisolated
    public func destroyAggregateDevice(
        _ aggregate: some AudioAggregateDeviceProperties,
        waitForCompletionWithTimeout timeout: TimeInterval? = 5.0
    ) throws(SwiftCoreAudioError) {
        try AudioHardwareDestroyAggregateDevice(aggregate.id.rawValue)
            .throwingSwiftCoreAudioError(message: "Failed to destroy aggregate device with ID \(aggregate.id).")

        if let timeout {
            // CoreAudio does not fully destroy the aggregate synchronously, so we have to wait for changes.
            // Not ideal but it works. Ideally we hook Core Audio's notifications with a listener but that
            // is not feasible in a synchronous (non-async) context.
            let result = PollingPredicate().wait(timeout: timeout, for: {
                !aggregate.isPresent
            })
            switch result {
            case .success: break
            case .timedOut: throw .aggregateDestructionTimeout
            }
        }
    }
}

// MARK: - Aggregate Device Lifecycle (Async)

extension AudioSystemProperties {
    /// Create a new aggregate audio device.
    ///
    /// Note that Core Audio requires a UID when creating an aggregate device, and it must be unique
    /// in the system.
    ///
    /// - Parameters:
    ///   - composition: Composition data structure used to create the aggregate.
    ///   - timeout: If non-`nil`, waits synchronously for Core Audio to complete creating the
    ///     aggregate before returning.
    /// - Returns: If successful, returns an ``AudioAggregateDevice`` instance representing the newly
    ///   created aggregate.
    /// - Throws: Throws an error if an aggregate device with the same UID already exists.
    @discardableResult
    nonisolated
    public func makeAggregateDevice(
        composition: AudioAggregateDevice.Composition,
        waitForCompletionWithTimeout timeout: TimeInterval? = 5.0
    ) async throws(SwiftCoreAudioError) -> AudioAggregateDevice {
        let cfDictionary = composition.cfDictionary()
        return try await makeAggregateDevice(composition: cfDictionary, waitForCompletionWithTimeout: timeout)
    }

    /// Create a new aggregate audio device, or update an existing aggregate with the same UID.
    ///
    /// If an aggregate device with the given UID already exists, it will be updated.
    /// Otherwise, a new aggregate device will be created.
    ///
    /// - Parameters:
    ///   - composition: Composition data structure used to create the aggregate.
    ///   - timeout: If non-`nil`, waits synchronously for Core Audio to complete creating the
    ///     aggregate before returning.
    /// - Returns: If successful, returns an ``AudioAggregateDevice`` instance representing the newly
    ///   created aggregate, or the existing aggregate if one was updated.
    @discardableResult
    nonisolated
    public func makeOrUpdateAggregateDevice(
        composition: AudioAggregateDevice.Composition,
        waitForCompletionWithTimeout timeout: TimeInterval? = 5.0
    ) async throws(SwiftCoreAudioError) -> AudioAggregateDevice {
        guard let aggregateUID = composition.uid else {
            throw .osStatus(
                AudioOSStatusError(unsafe: .illegalOperation),
                message: "Missing UID. A UID is required to create or update an aggregate device."
            )
        }
        if let existingAggregate = try? AudioSystem.shared.object(forUID: aggregateUID) {
            // update existing aggregate device
            try existingAggregate.setComposition(composition)
            return existingAggregate
        } else {
            // create new aggregate device
            return try await makeAggregateDevice(composition: composition, waitForCompletionWithTimeout: timeout)
        }
    }

    /// Create a new aggregate audio device.
    ///
    /// Note that Core Audio requires a UID when creating an aggregate device, and it must be unique
    /// in the system.
    ///
    /// - Parameters:
    ///   - composition: Composition dictionary used to create the aggregate.
    ///   - timeout: If non-`nil`, waits synchronously for Core Audio to complete creating the
    ///     aggregate before returning.
    /// - Returns: If successful, returns an ``AudioAggregateDevice`` instance representing the newly
    ///   created aggregate.
    /// - Throws: Throws an error if an aggregate device with the same UID already exists.
    @discardableResult
    nonisolated
    public func makeAggregateDevice(
        composition: CFDictionary,
        waitForCompletionWithTimeout timeout: TimeInterval? = 5.0
    ) async throws(SwiftCoreAudioError) -> AudioAggregateDevice {
        // create local asynchronous devices watcher
        let presence = AsyncAudioDevicesPresence()
        // start listening for changes in system devices before we create the aggregate
        await presence.start()

        // get UID just for error/debug purposes
        let aggregateUID = (composition as NSDictionary)[kAudioAggregateDeviceUIDKey] as? String

        var aggregateID: AudioObjectID = kAudioObjectUnknown
        try AudioHardwareCreateAggregateDevice(
            composition,
            &aggregateID
        )
        .throwingSwiftCoreAudioError(
            message: {
                var msg = "Failed to create aggregate device"
                if let aggregateUID { msg += " with UID \(aggregateUID)." } else { msg += "." }
                return msg
            }()
        )

        guard aggregateID != kAudioObjectUnknown else {
            throw .aggregateCreationFailed(message: "Returned object ID is 0 (invalid).")
        }

        let newAggregate = AudioAggregateDevice(id: aggregateID)

        if let timeout {
            // CoreAudio does not fully create the aggregate synchronously, so we have to wait for changes.
            let result = await presence.wait(timeout: timeout) { devices in
                devices.contains(where: { device in device.id.rawValue == newAggregate.id.rawValue })
            }
            switch result {
            case .success: break
            case .timedOut: throw .aggregateCreationTimeout
            }
        }

        return newAggregate
    }

    /// Destroys an aggregate audio device.
    ///
    /// If an aggregate does not exist, this method will return gracefully without throwing an error.
    ///
    /// - Parameters:
    ///   - aggregate: The aggregate device to destroy.
    ///   - timeout: If non-`nil`, waits synchronously for Core Audio to complete destroying the
    ///     aggregate before returning.
    nonisolated
    public func destroyAggregateDevice(
        _ aggregate: some AudioAggregateDeviceProperties,
        waitForCompletionWithTimeout timeout: TimeInterval? = 5.0
    ) async throws(SwiftCoreAudioError) {
        // create local asynchronous devices watcher
        let presence = AsyncAudioDevicesPresence()
        // start listening for changes in system devices before we create the aggregate
        await presence.start()

        try AudioHardwareDestroyAggregateDevice(aggregate.id.rawValue)
            .throwingSwiftCoreAudioError(message: "Failed to destroy aggregate device with ID \(aggregate.id).")

        if let timeout {
            // CoreAudio does not fully destroy the aggregate synchronously, so we have to wait for changes.
            let result = await presence.wait(timeout: timeout) { devices in
                !devices.contains(where: { device in device.id.rawValue == aggregate.id.rawValue })
            }
            switch result {
            case .success: break
            case .timedOut: throw .aggregateDestructionTimeout
            }
        }
    }
}

// MARK: - Convenience (Non-Async)

extension AudioSystemProperties {
    /// Convenience to create or update an aggregate audio device by with ``AudioAggregateDevice/Composition`` properties.
    ///
    /// For additional properties, see
    /// ``makeAggregateDevice(composition:waitForCompletionWithTimeout:)-(AudioAggregateDevice.Composition,_)``.
    ///
    /// - Parameters:
    ///   - uid: Aggregate composition `UID` property.
    ///   - name: Aggregate composition `name` property.
    ///   - subdevices: Aggregate composition `subdevices` property.
    ///   - subtaps: Aggregate composition `subtaps` property.
    ///   - clockUID: Aggregate composition `clockUID` property.
    ///   - mainSubdeviceUID: Aggregate composition `mainSubdeviceUID` property.
    ///   - isPrivate: Aggregate composition `isPrivate` property.
    ///   - isStacked: Aggregate composition `isStacked` property.
    ///   - isTapAutoStartEnabled: Aggregate composition `isTapAutoStartEnabled` property.
    ///   - timeout: If non-`nil`, waits synchronously for Core Audio to complete creating the
    ///     aggregate before returning.
    /// - Returns: If successful, returns an ``AudioAggregateDevice`` instance representing the newly
    ///   created aggregate.
    /// - Throws: Throws an error if an aggregate device with the same UID already exists.
    @discardableResult
    nonisolated
    public func makeAggregateDevice<Clock: AudioClockProperties, MainDevice: AudioDeviceProperties>(
        withUID uid: AudioAggregateDevice.UID,
        name: String? = nil,
        subdevices: [AudioAggregateDevice.Composition.SubDevice] = [],
        subtaps: [AudioAggregateDevice.Composition.SubTap] = [],
        clockUID: Clock.UID? = nil as AudioClock.UID?,
        mainSubdeviceUID: MainDevice.UID? = nil as AudioSubDevice.UID?,
        isPrivate: Bool = false,
        isStacked: Bool? = nil,
        isTapAutoStartEnabled: Bool? = nil,
        waitForCompletionWithTimeout timeout: TimeInterval? = 5.0
    ) throws(SwiftCoreAudioError) -> AudioAggregateDevice {
        let composition = AudioAggregateDevice.Composition(
            uid: uid,
            name: name,
            subdevices: subdevices,
            subtaps: subtaps,
            clockUID: clockUID,
            mainSubdeviceUID: mainSubdeviceUID,
            isPrivate: isPrivate,
            isStacked: isStacked,
            isTapAutoStartEnabled: isTapAutoStartEnabled
        )
        return try makeAggregateDevice(composition: composition, waitForCompletionWithTimeout: timeout)
    }

    /// Convenience to create or update an aggregate audio device by with ``AudioAggregateDevice/Composition`` properties.
    ///
    /// For additional properties, see
    /// ``makeAggregateDevice(composition:waitForCompletionWithTimeout:)-(AudioAggregateDevice.Composition,_)``.
    ///
    /// - Parameters:
    ///   - uid: Aggregate composition `UID` property.
    ///   - name: Aggregate composition `name` property.
    ///   - subdevices: Aggregate composition `subdevices` property.
    ///   - subtaps: Aggregate composition `subtaps` property.
    ///   - clockUID: Aggregate composition `clockUID` property.
    ///   - mainSubdeviceUID: Aggregate composition `mainSubdeviceUID` property.
    ///   - isPrivate: Aggregate composition `isPrivate` property.
    ///   - isStacked: Aggregate composition `isStacked` property.
    ///   - isTapAutoStartEnabled: Aggregate composition `isTapAutoStartEnabled` property.
    ///   - timeout: If non-`nil`, waits synchronously for Core Audio to complete creating the
    ///     aggregate before returning.
    /// - Returns: If successful, returns an ``AudioAggregateDevice`` instance representing the newly
    ///   created aggregate.
    /// - Throws: Throws an error if an aggregate device with the same UID already exists.
    @_disfavoredOverload @discardableResult
    nonisolated
    public func makeAggregateDevice<
        Device: AudioDeviceProperties,
        Tap: AudioTapProperties,
        Clock: AudioClockProperties,
        MainDevice: AudioDeviceProperties
    >(
        withUID uid: AudioAggregateDevice.UID,
        name: String? = nil,
        deviceUIDs: [Device.UID] = [] as [AudioDevice.UID],
        tapUIDs: [Tap.UID] = [] as [AudioTap.UID],
        clockUID: Clock.UID? = nil as AudioClock.UID?,
        mainSubdeviceUID: MainDevice.UID? = nil as AudioSubDevice.UID?,
        isPrivate: Bool = false,
        isStacked: Bool? = nil,
        isTapAutoStartEnabled: Bool? = nil,
        waitForCompletionWithTimeout timeout: TimeInterval? = 5.0
    ) throws(SwiftCoreAudioError) -> AudioAggregateDevice {
        let mappedSubdevices: [AudioAggregateDevice.Composition.SubDevice] = deviceUIDs
            .map(\.rawValue)
            .map { .init(uid: AudioSubDevice.UID($0)) }
        let mappedSubtaps: [AudioAggregateDevice.Composition.SubTap] = tapUIDs
            .map(\.rawValue)
            .map { .init(uid: AudioTap.UID($0)) }

        let composition = AudioAggregateDevice.Composition(
            uid: uid,
            name: name,
            subdevices: mappedSubdevices,
            subtaps: mappedSubtaps,
            clockUID: clockUID,
            mainSubdeviceUID: mainSubdeviceUID,
            isPrivate: isPrivate,
            isStacked: isStacked,
            isTapAutoStartEnabled: isTapAutoStartEnabled
        )
        return try makeAggregateDevice(composition: composition, waitForCompletionWithTimeout: timeout)
    }

    /// Convenience to create or update an aggregate audio device by with ``AudioAggregateDevice/Composition` properties.
    ///
    /// If an aggregate device with the given UID already exists, it will be updated.
    /// Otherwise, a new aggregate device will be created.
    ///
    /// For additional properties, see
    /// ``makeOrUpdateAggregateDevice(composition:waitForCompletionWithTimeout:)-(AudioAggregateDevice.Composition,_)``.
    ///
    /// - Parameters:
    ///   - uid: Aggregate composition `UID` property.
    ///   - name: Aggregate composition `name` property.
    ///   - subdevices: Aggregate composition `subdevices` property.
    ///   - subtaps: Aggregate composition `subtaps` property.
    ///   - clockUID: Aggregate composition `clockUID` property.
    ///   - mainSubdeviceUID: Aggregate composition `mainSubdeviceUID` property.
    ///   - isPrivate: Aggregate composition `isPrivate` property.
    ///   - isStacked: Aggregate composition `isStacked` property.
    ///   - isTapAutoStartEnabled: Aggregate composition `isTapAutoStartEnabled` property.
    ///   - timeout: If non-`nil`, waits synchronously for Core Audio to complete creating the
    ///     aggregate before returning.
    /// - Returns: If successful, returns an ``AudioAggregateDevice`` instance representing the newly
    ///   created aggregate, or the existing aggregate if one was updated.
    /// - Throws: Throws an error if an aggregate device with the same UID already exists.
    @discardableResult
    nonisolated
    public func makeOrUpdateAggregateDevice<Clock: AudioClockProperties, MainDevice: AudioDeviceProperties>(
        withUID uid: AudioAggregateDevice.UID,
        name: String? = nil,
        subdevices: [AudioAggregateDevice.Composition.SubDevice]? = nil,
        subtaps: [AudioAggregateDevice.Composition.SubTap]? = nil,
        clockUID: Clock.UID? = nil as AudioClock.UID?,
        mainSubdeviceUID: MainDevice.UID? = nil as AudioSubDevice.UID?,
        isPrivate: Bool? = nil,
        isStacked: Bool? = nil,
        isTapAutoStartEnabled: Bool? = nil,
        waitForCompletionWithTimeout timeout: TimeInterval? = 5.0
    ) throws(SwiftCoreAudioError) -> AudioAggregateDevice {
        if let existingAggregate = try? AudioSystem.shared.object(forUID: uid) {
            // update existing aggregate device
            try existingAggregate.update(
                name: name,
                subdevices: subdevices,
                subtaps: subtaps,
                clockUID: clockUID,
                mainSubdeviceUID: mainSubdeviceUID,
                isPrivate: isPrivate,
                isStacked: isStacked,
                isTapAutoStartEnabled: isTapAutoStartEnabled
            )

            return existingAggregate
        } else {
            // create new aggregate device
            let aggregate = try makeAggregateDevice(
                withUID: uid,
                name: name,
                subdevices: subdevices ?? [],
                subtaps: subtaps ?? [],
                clockUID: clockUID,
                isPrivate: isPrivate ?? false,
                isStacked: isStacked,
                isTapAutoStartEnabled: isTapAutoStartEnabled,
                waitForCompletionWithTimeout: timeout
            )
            return aggregate
        }
    }

    /// Convenience to create or update an aggregate audio device by with ``AudioAggregateDevice/Composition` properties.
    ///
    /// If an aggregate device with the given UID already exists, it will be updated.
    /// Otherwise, a new aggregate device will be created.
    ///
    /// For additional properties, see
    /// ``makeOrUpdateAggregateDevice(composition:waitForCompletionWithTimeout:)-(AudioAggregateDevice.Composition,_)``.
    ///
    /// - Parameters:
    ///   - uid: Aggregate composition `UID` property.
    ///   - name: Aggregate composition `name` property.
    ///   - subdevices: Aggregate composition `subdevices` property.
    ///   - subtaps: Aggregate composition `subtaps` property.
    ///   - clockUID: Aggregate composition `clockUID` property.
    ///   - mainSubdeviceUID: Aggregate composition `mainSubdeviceUID` property.
    ///   - isPrivate: Aggregate composition `isPrivate` property.
    ///   - isStacked: Aggregate composition `isStacked` property.
    ///   - isTapAutoStartEnabled: Aggregate composition `isTapAutoStartEnabled` property.
    ///   - timeout: If non-`nil`, waits synchronously for Core Audio to complete creating the
    ///     aggregate before returning.
    /// - Returns: If successful, returns an ``AudioAggregateDevice`` instance representing the newly
    ///   created aggregate, or the existing aggregate if one was updated.
    /// - Throws: Throws an error if an aggregate device with the same UID already exists.
    @_disfavoredOverload @discardableResult
    nonisolated
    public func makeOrUpdateAggregateDevice<
        Device: AudioDeviceProperties,
        Tap: AudioTapProperties,
        Clock: AudioClockProperties,
        MainDevice: AudioDeviceProperties
    >(
        withUID uid: AudioAggregateDevice.UID,
        name: String? = nil,
        deviceUIDs: [Device.UID]? = nil as [AudioDevice.UID]?,
        tapUIDs: [Tap.UID]? = nil as [AudioTap.UID]?,
        clockUID: Clock.UID? = nil as AudioClock.UID?,
        mainSubdeviceUID: MainDevice.UID? = nil as AudioSubDevice.UID?,
        isPrivate: Bool? = nil,
        isStacked: Bool? = nil,
        isTapAutoStartEnabled: Bool? = nil,
        waitForCompletionWithTimeout timeout: TimeInterval? = 5.0
    ) throws(SwiftCoreAudioError) -> AudioAggregateDevice {
        if let existingAggregate = try? AudioSystem.shared.object(forUID: uid) {
            // update existing aggregate device
            try existingAggregate.update(
                name: name,
                deviceUIDs: deviceUIDs,
                tapUIDs: tapUIDs,
                clockUID: clockUID,
                mainSubdeviceUID: mainSubdeviceUID,
                isPrivate: isPrivate,
                isStacked: isStacked,
                isTapAutoStartEnabled: isTapAutoStartEnabled
            )

            return existingAggregate
        } else {
            // create new aggregate device
            let aggregate = try makeAggregateDevice(
                withUID: uid,
                name: name,
                deviceUIDs: deviceUIDs ?? [],
                tapUIDs: tapUIDs ?? [],
                clockUID: clockUID,
                isPrivate: isPrivate ?? false,
                isStacked: isStacked,
                isTapAutoStartEnabled: isTapAutoStartEnabled,
                waitForCompletionWithTimeout: timeout
            )
            return aggregate
        }
    }
}

// MARK: - Convenience (Async)

extension AudioSystemProperties {
    /// Convenience to create or update an aggregate audio device by with ``AudioAggregateDevice/Composition`` properties.
    ///
    /// For additional properties, see
    /// ``makeAggregateDevice(composition:waitForCompletionWithTimeout:)-(AudioAggregateDevice.Composition,_)``.
    ///
    /// - Parameters:
    ///   - uid: Aggregate composition `UID` property.
    ///   - name: Aggregate composition `name` property.
    ///   - subdevices: Aggregate composition `subdevices` property.
    ///   - subtaps: Aggregate composition `subtaps` property.
    ///   - clockUID: Aggregate composition `clockUID` property.
    ///   - mainSubdeviceUID: Aggregate composition `mainSubdeviceUID` property.
    ///   - isPrivate: Aggregate composition `isPrivate` property.
    ///   - isStacked: Aggregate composition `isStacked` property.
    ///   - isTapAutoStartEnabled: Aggregate composition `isTapAutoStartEnabled` property.
    ///   - timeout: If non-`nil`, waits synchronously for Core Audio to complete creating the
    ///     aggregate before returning.
    /// - Returns: If successful, returns an ``AudioAggregateDevice`` instance representing the newly
    ///   created aggregate.
    /// - Throws: Throws an error if an aggregate device with the same UID already exists.
    @discardableResult
    nonisolated
    public func makeAggregateDevice<Clock: AudioClockProperties, MainDevice: AudioDeviceProperties>(
        withUID uid: AudioAggregateDevice.UID,
        name: String? = nil,
        subdevices: [AudioAggregateDevice.Composition.SubDevice] = [],
        subtaps: [AudioAggregateDevice.Composition.SubTap] = [],
        clockUID: Clock.UID? = nil as AudioClock.UID?,
        mainSubdeviceUID: MainDevice.UID? = nil as AudioSubDevice.UID?,
        isPrivate: Bool = false,
        isStacked: Bool? = nil,
        isTapAutoStartEnabled: Bool? = nil,
        waitForCompletionWithTimeout timeout: TimeInterval? = 5.0
    ) async throws(SwiftCoreAudioError) -> AudioAggregateDevice {
        let composition = AudioAggregateDevice.Composition(
            uid: uid,
            name: name,
            subdevices: subdevices,
            subtaps: subtaps,
            clockUID: clockUID,
            mainSubdeviceUID: mainSubdeviceUID,
            isPrivate: isPrivate,
            isStacked: isStacked,
            isTapAutoStartEnabled: isTapAutoStartEnabled
        )
        return try await makeAggregateDevice(composition: composition, waitForCompletionWithTimeout: timeout)
    }

    /// Convenience to create or update an aggregate audio device by with ``AudioAggregateDevice/Composition`` properties.
    ///
    /// For additional properties, see
    /// ``makeAggregateDevice(composition:waitForCompletionWithTimeout:)-(AudioAggregateDevice.Composition,_)``.
    ///
    /// - Parameters:
    ///   - uid: Aggregate composition `UID` property.
    ///   - name: Aggregate composition `name` property.
    ///   - subdevices: Aggregate composition `subdevices` property.
    ///   - subtaps: Aggregate composition `subtaps` property.
    ///   - clockUID: Aggregate composition `clockUID` property.
    ///   - mainSubdeviceUID: Aggregate composition `mainSubdeviceUID` property.
    ///   - isPrivate: Aggregate composition `isPrivate` property.
    ///   - isStacked: Aggregate composition `isStacked` property.
    ///   - isTapAutoStartEnabled: Aggregate composition `isTapAutoStartEnabled` property.
    ///   - timeout: If non-`nil`, waits synchronously for Core Audio to complete creating the
    ///     aggregate before returning.
    /// - Returns: If successful, returns an ``AudioAggregateDevice`` instance representing the newly
    ///   created aggregate.
    /// - Throws: Throws an error if an aggregate device with the same UID already exists.
    @_disfavoredOverload @discardableResult
    nonisolated
    public func makeAggregateDevice<
        Device: AudioDeviceProperties,
        Tap: AudioTapProperties,
        Clock: AudioClockProperties,
        MainDevice: AudioDeviceProperties
    >(
        withUID uid: AudioAggregateDevice.UID,
        name: String? = nil,
        deviceUIDs: [Device.UID] = [] as [AudioDevice.UID],
        tapUIDs: [Tap.UID] = [] as [AudioTap.UID],
        clockUID: Clock.UID? = nil as AudioClock.UID?,
        mainSubdeviceUID: MainDevice.UID? = nil as AudioSubDevice.UID?,
        isPrivate: Bool = false,
        isStacked: Bool? = nil,
        isTapAutoStartEnabled: Bool? = nil,
        waitForCompletionWithTimeout timeout: TimeInterval? = 5.0
    ) async throws(SwiftCoreAudioError) -> AudioAggregateDevice {
        let mappedSubdevices: [AudioAggregateDevice.Composition.SubDevice] = deviceUIDs
            .map(\.rawValue)
            .map { .init(uid: AudioSubDevice.UID($0)) }
        let mappedSubtaps: [AudioAggregateDevice.Composition.SubTap] = tapUIDs
            .map(\.rawValue)
            .map { .init(uid: AudioTap.UID($0)) }

        let composition = AudioAggregateDevice.Composition(
            uid: uid,
            name: name,
            subdevices: mappedSubdevices,
            subtaps: mappedSubtaps,
            clockUID: clockUID,
            mainSubdeviceUID: mainSubdeviceUID,
            isPrivate: isPrivate,
            isStacked: isStacked,
            isTapAutoStartEnabled: isTapAutoStartEnabled
        )
        return try await makeAggregateDevice(composition: composition, waitForCompletionWithTimeout: timeout)
    }

    /// Convenience to create or update an aggregate audio device by with ``AudioAggregateDevice/Composition` properties.
    ///
    /// If an aggregate device with the given UID already exists, it will be updated.
    /// Otherwise, a new aggregate device will be created.
    ///
    /// For additional properties, see
    /// ``makeOrUpdateAggregateDevice(composition:waitForCompletionWithTimeout:)-(AudioAggregateDevice.Composition,_)``.
    ///
    /// - Parameters:
    ///   - uid: Aggregate composition `UID` property.
    ///   - name: Aggregate composition `name` property.
    ///   - subdevices: Aggregate composition `subdevices` property.
    ///   - subtaps: Aggregate composition `subtaps` property.
    ///   - clockUID: Aggregate composition `clockUID` property.
    ///   - mainSubdeviceUID: Aggregate composition `mainSubdeviceUID` property.
    ///   - isPrivate: Aggregate composition `isPrivate` property.
    ///   - isStacked: Aggregate composition `isStacked` property.
    ///   - isTapAutoStartEnabled: Aggregate composition `isTapAutoStartEnabled` property.
    ///   - timeout: If non-`nil`, waits synchronously for Core Audio to complete creating the
    ///     aggregate before returning.
    /// - Returns: If successful, returns an ``AudioAggregateDevice`` instance representing the newly
    ///   created aggregate, or the existing aggregate if one was updated.
    /// - Throws: Throws an error if an aggregate device with the same UID already exists.
    @discardableResult
    nonisolated
    public func makeOrUpdateAggregateDevice<Clock: AudioClockProperties, MainDevice: AudioDeviceProperties>(
        withUID uid: AudioAggregateDevice.UID,
        name: String? = nil,
        subdevices: [AudioAggregateDevice.Composition.SubDevice]? = nil,
        subtaps: [AudioAggregateDevice.Composition.SubTap]? = nil,
        clockUID: Clock.UID? = nil as AudioClock.UID?,
        mainSubdeviceUID: MainDevice.UID? = nil as AudioSubDevice.UID?,
        isPrivate: Bool? = nil,
        isStacked: Bool? = nil,
        isTapAutoStartEnabled: Bool? = nil,
        waitForCompletionWithTimeout timeout: TimeInterval? = 5.0
    ) async throws(SwiftCoreAudioError) -> AudioAggregateDevice {
        if let existingAggregate = try? AudioSystem.shared.object(forUID: uid) {
            // update existing aggregate device
            try existingAggregate.update(
                name: name,
                subdevices: subdevices,
                subtaps: subtaps,
                clockUID: clockUID,
                mainSubdeviceUID: mainSubdeviceUID,
                isPrivate: isPrivate,
                isStacked: isStacked,
                isTapAutoStartEnabled: isTapAutoStartEnabled
            )

            return existingAggregate
        } else {
            // create new aggregate device
            let aggregate = try await makeAggregateDevice(
                withUID: uid,
                name: name,
                subdevices: subdevices ?? [],
                subtaps: subtaps ?? [],
                clockUID: clockUID,
                isPrivate: isPrivate ?? false,
                isStacked: isStacked,
                isTapAutoStartEnabled: isTapAutoStartEnabled,
                waitForCompletionWithTimeout: timeout
            )
            return aggregate
        }
    }

    /// Convenience to create or update an aggregate audio device by with ``AudioAggregateDevice/Composition` properties.
    ///
    /// If an aggregate device with the given UID already exists, it will be updated.
    /// Otherwise, a new aggregate device will be created.
    ///
    /// For additional properties, see
    /// ``makeOrUpdateAggregateDevice(composition:waitForCompletionWithTimeout:)-(AudioAggregateDevice.Composition,_)``.
    ///
    /// - Parameters:
    ///   - uid: Aggregate composition `UID` property.
    ///   - name: Aggregate composition `name` property.
    ///   - subdevices: Aggregate composition `subdevices` property.
    ///   - subtaps: Aggregate composition `subtaps` property.
    ///   - clockUID: Aggregate composition `clockUID` property.
    ///   - mainSubdeviceUID: Aggregate composition `mainSubdeviceUID` property.
    ///   - isPrivate: Aggregate composition `isPrivate` property.
    ///   - isStacked: Aggregate composition `isStacked` property.
    ///   - isTapAutoStartEnabled: Aggregate composition `isTapAutoStartEnabled` property.
    ///   - timeout: If non-`nil`, waits synchronously for Core Audio to complete creating the
    ///     aggregate before returning.
    /// - Returns: If successful, returns an ``AudioAggregateDevice`` instance representing the newly
    ///   created aggregate, or the existing aggregate if one was updated.
    /// - Throws: Throws an error if an aggregate device with the same UID already exists.
    @_disfavoredOverload @discardableResult
    nonisolated
    public func makeOrUpdateAggregateDevice<
        Device: AudioDeviceProperties,
        Tap: AudioTapProperties,
        Clock: AudioClockProperties,
        MainDevice: AudioDeviceProperties
    >(
        withUID uid: AudioAggregateDevice.UID,
        name: String? = nil,
        deviceUIDs: [Device.UID]? = nil as [AudioDevice.UID]?,
        tapUIDs: [Tap.UID]? = nil as [AudioTap.UID]?,
        clockUID: Clock.UID? = nil as AudioClock.UID?,
        mainSubdeviceUID: MainDevice.UID? = nil as AudioSubDevice.UID?,
        isPrivate: Bool? = nil,
        isStacked: Bool? = nil,
        isTapAutoStartEnabled: Bool? = nil,
        waitForCompletionWithTimeout timeout: TimeInterval? = 5.0
    ) async throws(SwiftCoreAudioError) -> AudioAggregateDevice {
        if let existingAggregate = try? AudioSystem.shared.object(forUID: uid) {
            // update existing aggregate device
            try existingAggregate.update(
                name: name,
                deviceUIDs: deviceUIDs,
                tapUIDs: tapUIDs,
                clockUID: clockUID,
                mainSubdeviceUID: mainSubdeviceUID,
                isPrivate: isPrivate,
                isStacked: isStacked,
                isTapAutoStartEnabled: isTapAutoStartEnabled
            )

            return existingAggregate
        } else {
            // create new aggregate device
            let aggregate = try await makeAggregateDevice(
                withUID: uid,
                name: name,
                deviceUIDs: deviceUIDs ?? [],
                tapUIDs: tapUIDs ?? [],
                clockUID: clockUID,
                isPrivate: isPrivate ?? false,
                isStacked: isStacked,
                isTapAutoStartEnabled: isTapAutoStartEnabled,
                waitForCompletionWithTimeout: timeout
            )
            return aggregate
        }
    }
}

#endif
