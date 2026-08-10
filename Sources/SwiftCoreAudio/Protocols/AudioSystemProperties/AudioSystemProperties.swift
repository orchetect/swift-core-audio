//
//  AudioSystemProperties.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

/// Properties offered by the Core Audio `AudioSystem` class.
public protocol AudioSystemProperties where Self: AudioObject {
    // MARK: CoreAudio/AudioHardware.h

    /// Returns an array of devices (including aggregate devices) currently available to the system.
    /// The order of devices in the array matches the order of devices as seen in Audio MIDI Setup.
    nonisolated
    var devices: [AnyAudioDevice] { get throws(SwiftCoreAudioError) }

    /// Returns the device assigned as the default device for input.
    nonisolated
    var defaultInputDevice: AnyAudioDevice { get throws(SwiftCoreAudioError) }

    /// Set the device assigned as the default device for input.
    nonisolated
    func setDefaultInputDevice(_ device: some AudioDeviceProperties) throws(SwiftCoreAudioError)

    /// Returns the device assigned as the default device for output.
    nonisolated
    var defaultOutputDevice: AnyAudioDevice { get throws(SwiftCoreAudioError) }

    /// Set the device assigned as the default device for output.
    nonisolated
    func setDefaultOutputDevice(_ device: some AudioDeviceProperties) throws(SwiftCoreAudioError)

    /// Returns the device assigned as the default device for output of system sounds.
    nonisolated
    var defaultOutputDeviceForSystemSounds: AnyAudioDevice { get throws(SwiftCoreAudioError) }

    /// Set the device assigned as the default device for output of system sounds.
    nonisolated
    func setDefaultOutputDeviceForSystemSounds(_ device: some AudioDeviceProperties) throws(SwiftCoreAudioError)

    /// Returns the device that corresponds to the device UID, if one exists.
    @_disfavoredOverload
    nonisolated
    func device<Device: AudioDeviceProperties & IDConstructibleAudioObject>(
        forUID uid: Device.UID
    ) throws(SwiftCoreAudioError) -> Device?

    /// A boolean value that indicates whether devices in the system should mix
    /// stereo signals down to mono.
    ///
    /// Note that the two preferred stereo channels on the device comprise the stereo signal to be
    /// mixed down.
    nonisolated
    var isStereoMixedDownToMono: Bool { get throws(SwiftCoreAudioError) }

    // TODO: Replace with new `AnyAudioPlugIn` type?
    /// Returns an array of plug-ins currently available to the system.
    nonisolated
    var plugIns: [AudioPlugIn] { get throws(SwiftCoreAudioError) }

    // TODO: Replace with new `AnyAudioPlugIn` type?
    /// Returns the plug-in that corresponds to the bundle ID, if one exists.
    nonisolated
    func plugIn(forBundleID bundleID: BundleID) throws(SwiftCoreAudioError) -> AudioPlugIn?

    /// Returns an array of transport managers currently available to the system.
    nonisolated
    var transportManagers: [AudioTransportManager] { get throws(SwiftCoreAudioError) }

    /// Returns the transport manager that corresponds to the bundle ID, if one exists.
    nonisolated
    func transportManager(forBundleID bundleID: BundleID) throws(SwiftCoreAudioError) -> AudioTransportManager?

    /// Returns an array of boxes currently available to the system.
    nonisolated
    var boxes: [AudioBox] { get throws(SwiftCoreAudioError) }

    /// Returns the box that corresponds to the box UID, if one exists.
    nonisolated
    func box<Box: AudioBoxProperties & IDConstructibleAudioObject>(
        forUID uid: Box.UID
    ) throws(SwiftCoreAudioError) -> Box?

    /// Returns an array of clocks currently available to the system.
    nonisolated
    var clocks: [AudioClock] { get throws(SwiftCoreAudioError) }

    /// Returns the clock that corresponds to the clock UID, if one exists.
    nonisolated
    func clock<Clock: AudioClockProperties & IDConstructibleAudioObject>(
        forUID uid: Clock.UID
    ) throws(SwiftCoreAudioError) -> Clock?

    /// Returns a boolean value that indicates whether the current process contains the main instance
    /// of the HAL.
    ///
    /// The main instance of the HAL is the only instance in which plug-ins should save/restore their
    /// devices' settings.
    nonisolated
    var isProcessMain: Bool { get throws(SwiftCoreAudioError) }

    /// Returns a boolean value that, when `true`, indicates whether the HAL is either in the midst of
    /// initializing or in the midst of exiting the process.
    nonisolated
    var isInitingOrExiting: Bool { get throws(SwiftCoreAudioError) }

    // Note: `userIDChanged` is write-only, read is unused

    /// Returns a boolean value that indicates whether audio of the process is muted for a particular
    /// stream direction.
    nonisolated
    func isProcessMuted(for direction: AudioStream.Direction) throws(SwiftCoreAudioError) -> Bool

    /// Returns a boolean value that indicates whether the current process will allow the CPU to idle
    /// sleep even if there is audio IO in progress.
    ///
    /// Note that this property won't affect when the CPU is forced to sleep.
    nonisolated
    var isSleepingAllowed: Bool { get throws(SwiftCoreAudioError) }

    /// Returns a boolean value that indicates whether the current process wants the HAL to unload
    /// itself after a period of inactivity where there are no `IOProc`s and no listeners
    /// registered with any audio object.
    nonisolated
    var isUnloadingAllowed: Bool { get throws(SwiftCoreAudioError) }

    /// Returns a boolean value that indicates whether the current process wants the HAL to
    /// automatically take hog mode. A value of `false` means that the HAL should not automatically
    /// take hog mode on behalf of the process.
    ///
    /// Processes that only ever use the default device are the sort that should set
    /// this property's value to `false`.
    nonisolated
    var isHogModeAllowed: Bool { get throws(SwiftCoreAudioError) }

    /// Returns a boolean value that, when `true`, indicates whether the login session of the user
    /// of the current process is either an active console session or a headless session.
    nonisolated
    var isUserSessionForProcessActiveOrHeadless: Bool { get throws(SwiftCoreAudioError) }

    // Note: `serviceRestarted` is used only for notifications

    /// Returns the power hint for the current process.
    ///
    /// The underlying type is a `UInt32` whose values are drawn from the `AudioHardwarePowerHint` enum.
    /// Only those values are allowed.
    ///
    /// This property allows a process to indicate how aggressive the system can be with
    /// optimizations that save power. The default value is `kAudioHardwarePowerHintNone`.
    ///
    /// Note that the value of this property can be set in an application's `Info.plist`
    /// the key, `AudioHardwarePowerHint`. The values for this key are the strings that
    /// correspond to the values in the Power Hints enum.
    nonisolated
    var powerHint: AudioHardwarePowerHint { get throws(SwiftCoreAudioError) }

    /// Returns an array of client audio processes currently available to the system.
    nonisolated
    var processes: [AudioProcess] { get throws(SwiftCoreAudioError) }

    /// Returns the audio process that corresponds to the process ID (PID), if one exists.
    /// If no running process has the given PID, an error is thrown.
    nonisolated
    func process(forPID pid: PID) throws(SwiftCoreAudioError) -> AudioProcess?

    /// Returns an array of taps currently available to the system.
    nonisolated
    var taps: [AudioTap] { get throws(SwiftCoreAudioError) }

    /// Returns the tap that corresponds to the tap UID, if one exists.
    nonisolated
    func tap<Tap: AudioTapProperties & IDConstructibleAudioObject>(
        forUID uid: Tap.UID
    ) throws(SwiftCoreAudioError) -> Tap?
}

#endif
