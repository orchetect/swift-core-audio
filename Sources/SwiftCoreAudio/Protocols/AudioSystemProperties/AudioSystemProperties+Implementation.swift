//
//  AudioSystemProperties+Implementation.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

extension AudioSystemProperties {
    // MARK: CoreAudio/AudioHardware.h

    nonisolated
    public var devices: [AnyAudioDevice] {
        get throws(SwiftCoreAudioError) {
            let ids = try getPropertyValue(property: SystemProperty.devices)
            var anyDevices: [AnyAudioDevice] = []
            for id in ids {
                let anyDevice = AnyAudioDevice(id: id)
                anyDevices.append(anyDevice)
            }
            return anyDevices
        }
    }

    nonisolated
    public var defaultInputDevice: AnyAudioDevice {
        get throws(SwiftCoreAudioError) {
            let id = try getPropertyValue(property: SystemProperty.defaultInputDevice)
            let device = AnyAudioDevice(id: id)
            return device
        }
    }

    nonisolated
    public var defaultOutputDevice: AnyAudioDevice {
        get throws(SwiftCoreAudioError) {
            let id = try getPropertyValue(property: SystemProperty.defaultOutputDevice)
            let device = AnyAudioDevice(id: id)
            return device
        }
    }

    nonisolated
    public var defaultOutputDeviceForSystemSounds: AnyAudioDevice {
        get throws(SwiftCoreAudioError) {
            let id = try getPropertyValue(property: SystemProperty.defaultOutputDeviceForSystemSounds)
            let device = AnyAudioDevice(id: id)
            return device
        }
    }

    nonisolated
    public func device<Device: AudioDeviceProperties & IDConstructibleAudioObject>(
        forUID uid: Device.UID
    ) throws(SwiftCoreAudioError) -> Device? {
        let id = try getPropertyValue(property: SystemProperty.deviceForUID, qualifier: .cfString(uid.rawValue))
        // `kAudioObjectUnknown` ID with `noErr` OSStatus means "not found" but is not an error
        guard id != kAudioObjectUnknown else { return nil }
        let device = Device(id: id)
        return device
    }

    nonisolated
    public var isStereoMixedDownToMono: Bool {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: SystemProperty.isStereoMixedDownToMono)
        }
    }

    // TODO: Replace with new `AnyAudioPlugIn` type?
    nonisolated
    public var plugIns: [AudioPlugIn] {
        get throws(SwiftCoreAudioError) {
            let ids = try getPropertyValue(property: SystemProperty.plugIns)
            return ids.map(AudioPlugIn.init(id:))
        }
    }

    // TODO: Replace return type with new `AnyAudioPlugIn` type?
    nonisolated
    public func plugIn(forBundleID bundleID: BundleID) throws(SwiftCoreAudioError) -> AudioPlugIn? {
        let id = try getPropertyValue(property: SystemProperty.plugInForBundleID, qualifier: .cfString(bundleID.rawValue))
        // `kAudioObjectUnknown` ID with `noErr` OSStatus means "not found" but is not an error
        guard id != kAudioObjectUnknown else { return nil }
        return AudioPlugIn(id: id)
    }

    nonisolated
    public var transportManagers: [AudioTransportManager] {
        get throws(SwiftCoreAudioError) {
            let ids = try getPropertyValue(property: SystemProperty.transportManagers)
            return ids.map(AudioTransportManager.init(id:))
        }
    }

    nonisolated
    public func transportManager(forBundleID bundleID: BundleID) throws(SwiftCoreAudioError) -> AudioTransportManager? {
        let id = try getPropertyValue(property: SystemProperty.transportManagerForBundleID, qualifier: .cfString(bundleID.rawValue))
        // `kAudioObjectUnknown` ID with `noErr` OSStatus means "not found" but is not an error
        guard id != kAudioObjectUnknown else { return nil }
        return AudioTransportManager(id: id)
    }

    nonisolated
    public var boxes: [AudioBox] {
        get throws(SwiftCoreAudioError) {
            let ids = try getPropertyValue(property: SystemProperty.boxes)
            return ids.map(AudioBox.init(id:))
        }
    }

    nonisolated
    public func box<Box: AudioBoxProperties & IDConstructibleAudioObject>(
        forUID uid: Box.UID
    ) throws(SwiftCoreAudioError) -> Box? {
        let id = try getPropertyValue(property: SystemProperty.boxForUID, qualifier: .cfString(uid.rawValue))
        // `kAudioObjectUnknown` ID with `noErr` OSStatus means "not found" but is not an error
        guard id != kAudioObjectUnknown else { return nil }
        return Box(id: id)
    }

    nonisolated
    public var clocks: [AudioClock] {
        get throws(SwiftCoreAudioError) {
            let ids = try getPropertyValue(property: SystemProperty.clocks)
            return ids.map(AudioClock.init(id:))
        }
    }

    nonisolated
    public func clock<Clock: AudioClockProperties & IDConstructibleAudioObject>(
        forUID uid: Clock.UID
    ) throws(SwiftCoreAudioError) -> Clock? {
        let id = try getPropertyValue(property: SystemProperty.clockForUID, qualifier: .cfString(uid.rawValue))
        // `kAudioObjectUnknown` ID with `noErr` OSStatus means "not found" but is not an error
        guard id != kAudioObjectUnknown else { return nil }
        return Clock(id: id)
    }

    nonisolated
    public var isProcessMain: Bool {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: SystemProperty.isProcessMain)
        }
    }

    nonisolated
    public var isInitingOrExiting: Bool {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: SystemProperty.isInitingOrExiting)
        }
    }

    // Note: `userIDChanged` is write-only, read is unused

    nonisolated
    public func isProcessMuted(for direction: AudioStream.Direction) throws(SwiftCoreAudioError) -> Bool {
        switch direction {
        case .input: try getPropertyValue(property: SystemProperty.isProcessMutedForInput)
        case .output: try getPropertyValue(property: SystemProperty.isProcessMutedForOutput)
        }
    }

    nonisolated
    public var isSleepingAllowed: Bool {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: SystemProperty.isSleepingAllowed)
        }
    }

    nonisolated
    public var isUnloadingAllowed: Bool {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: SystemProperty.isUnloadingAllowed)
        }
    }

    nonisolated
    public var isHogModeAllowed: Bool {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: SystemProperty.isHogModeAllowed)
        }
    }

    nonisolated
    public var isUserSessionForProcessActiveOrHeadless: Bool {
        get throws(SwiftCoreAudioError) {
            try getPropertyValue(property: SystemProperty.isUserSessionForProcessActiveOrHeadless)
        }
    }

    // Note: `serviceRestarted` is used only for notifications

    nonisolated
    public var powerHint: AudioHardwarePowerHint {
        get throws(SwiftCoreAudioError) {
            let rawValue = try getPropertyValue(property: SystemProperty.powerHint)
            guard let hint = AudioHardwarePowerHint(rawValue: rawValue) else {
                throw .notYetImplemented(message: "Unrecognized raw value for power hint: \(rawValue).")
            }
            return hint
        }
    }

    nonisolated
    public var processes: [AudioProcess] {
        get throws(SwiftCoreAudioError) {
            let ids = try getPropertyValue(property: SystemProperty.processes)
            return ids.map(AudioProcess.init(id:))
        }
    }

    nonisolated
    public func process(forPID pid: PID) throws(SwiftCoreAudioError) -> AudioProcess? {
        let id = try getPropertyValue(property: SystemProperty.processForPID, qualifier: .int32(pid.rawValue))
        // `kAudioObjectUnknown` ID with `noErr` OSStatus means either the PID is "not found" or
        // no audio object exists for the PID.
        // first check whether the PID exists and throw and error if it doesn't exist
        guard let pids = try? PID.all, pids.contains(pid) else {
            throw .pidDoesNotExist(pid: pid)
        }
        guard id != kAudioObjectUnknown else { return nil }
        return AudioProcess(id: id)
    }

    nonisolated
    public var taps: [AudioTap] {
        get throws(SwiftCoreAudioError) {
            let ids = try getPropertyValue(property: SystemProperty.taps)
            return ids.map(AudioTap.init(id:))
        }
    }

    nonisolated
    public func tap<Tap: AudioTapProperties & IDConstructibleAudioObject>(
        forUID uid: Tap.UID
    ) throws(SwiftCoreAudioError) -> Tap? {
        let id = try getPropertyValue(property: SystemProperty.tapForUID, qualifier: .cfString(uid.rawValue))
        // `kAudioObjectUnknown` ID with `noErr` OSStatus means "not found" but is not an error
        guard id != kAudioObjectUnknown else { return nil }
        return Tap(id: id)
    }
}

#endif
