//
//  AudioSystemPropertySelectorConstant.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

/// Analogous to CoreAudio `kAudioHardwareProperty*` selector constants.
///
/// `AudioObjectPropertySelector` values provided by the `AudioSystemObject` class.
public enum AudioSystemPropertySelectorConstant {
    // MARK: CoreAudio/AudioHardware.h

    /// Devices
    ///
    /// An array of the `AudioObjectID`s that represent all the devices currently
    /// available to the system.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioHardwarePropertyDevices`
    case devices

    /// Default Input Device
    ///
    /// The `AudioObjectID` of the default input `AudioDevice`.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioHardwarePropertyDefaultInputDevice`
    case defaultInputDevice

    /// Default Output Device
    ///
    /// The `AudioObjectID` of the default output `AudioDevice`.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioHardwarePropertyDefaultOutputDevice`
    case defaultOutputDevice

    /// Default System Output Device
    ///
    /// The `AudioObjectID` of the output `AudioDevice` to use for system related sound
    /// from the alert sound to digital call progress.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioHardwarePropertyDefaultSystemOutputDevice`
    case defaultSystemOutputDevice

    /// Translate UID to Device
    ///
    /// This property fetches the `AudioObjectID` that corresponds to the `AudioDevice`
    /// that has the given UID.
    ///
    /// The UID is passed in via the qualifier as a `CFString` while the `AudioObjectID`
    /// for the `AudioDevice` is returned to the caller as the property's data.
    ///
    /// Note that an error is not returned if the UID doesn't refer to any `AudioDevice`s.
    /// Rather, this property will return `kAudioObjectUnknown` as the value of the property.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioHardwarePropertyTranslateUIDToDevice`
    case translateUIDToDevice

    /// Mix Stereo to Mono
    ///
    /// A `UInt32` where a value other than `0` indicates that `AudioDevice`s should mix
    /// stereo signals down to mono. Note that the two channels on the device that
    /// comprise the stereo signal are defined on the device by
    /// `kAudioDevicePropertyPreferredChannelsForStereo`.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioHardwarePropertyMixStereoToMono`
    case mixStereoToMono

    /// Plug-In List
    ///
    /// An array of `AudioObjectID`s that represent all the `AudioPlugIn` objects
    /// currently provided by the system.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioHardwarePropertyPlugInList`
    case plugInList

    /// Translate Bundle ID to Plug-In
    ///
    /// This property fetches the `AudioObjectID` that corresponds to the `AudioPlugIn`
    /// that has the given bundle ID.
    ///
    /// The bundle ID is passed in via the qualifier as a `CFString` while the `AudioObjectID`
    /// for the `AudioPlugIn` is returned to the caller as the property's data.
    ///
    /// Note that an error is not returned if the bundle ID doesn't refer to any `AudioPlugIn`s.
    /// Rather, this property will return `kAudioObjectUnknown` as the value of the property.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioHardwarePropertyTranslateBundleIDToPlugIn`
    case translateBundleIDToPlugIn

    /// Transport Manager List
    ///
    /// An array of the `AudioObjectID`s for all the `AudioTransportManager` objects.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioHardwarePropertyTransportManagerList`
    case transportManagerList

    /// Translate Bundle ID to Transport Manager
    ///
    /// This property fetches the `AudioObjectID` that corresponds to the `AudioTransportManager`
    /// that has the given bundle ID.
    ///
    /// The bundle ID is passed in via the qualifier as a `CFString` while the `AudioObjectID`
    /// for the `AudioTransportManager` is returned to the caller as the property's data.
    ///
    /// Note that an error is not returned if the bundle ID doesn't refer to any `AudioTransportManager`s.
    /// Rather, this property will return `kAudioObjectUnknown` as the value of the property.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioHardwarePropertyTranslateBundleIDToTransportManager`
    case translateBundleIDToTransportManager

    /// Box List
    ///
    /// An array of `AudioObjectID`s that represent all the AudioBox objects currently
    /// provided by the system.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioHardwarePropertyBoxList`
    case boxList

    /// Translate UID to Box
    ///
    /// This property fetches the `AudioObjectID` that corresponds to the `AudioBox`
    /// that has the given UID.
    ///
    /// The UID is passed in via the qualifier as a `CFString` while the `AudioObjectID`
    /// for the `AudioBox` is returned to the caller as the property's data.
    ///
    /// Note that an error is not returned if the UID doesn't refer to any `AudioBox`s.
    /// Rather, this property will return `kAudioObjectUnknown` as the value of the property.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioHardwarePropertyTranslateUIDToBox`
    case translateUIDToBox

    /// Clock Device List
    ///
    /// An array of `AudioObjectID`s that represent all the `AudioClockDevice` objects
    /// currently provided by the system.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioHardwarePropertyClockDeviceList`
    case clockDeviceList

    /// Translate UID to Clock Device
    ///
    /// This property fetches the `AudioObjectID` that corresponds to the `AudioClockDevice`
    /// that has the given UID.
    ///
    /// The UID is passed in via the qualifier as a `CFString` while the `AudioObjectID`
    /// for the `AudioClockDevice` is returned to the caller as the property's data.
    ///
    /// Note that an error is not returned if the UID doesn't refer to any `AudioClockDevice`s.
    /// Rather, this property will return `kAudioObjectUnknown` as the value of the property.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioHardwarePropertyTranslateUIDToClockDevice`
    case translateUIDToClockDevice

    /// Process is Main
    ///
    /// A `UInt32` where `1` means that the current process contains the main instance
    /// of the HAL.
    ///
    /// The main instance of the HAL is the only instance in which plug-ins should save/restore
    /// their devices' settings.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioHardwarePropertyProcessIsMain`
    case processIsMain

    /// Is Initing or Exiting
    ///
    /// A `UInt32` whose value will be non-zero if the HAL is either in the midst of
    /// initializing or in the midst of exiting the process.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioHardwarePropertyIsInitingOrExiting`
    case isInitingOrExiting

    /// User ID Changed
    ///
    /// This property exists so that clients can tell the HAL when they are changing
    /// the effective user ID of the process. The way it works is that a client will
    /// set the value of this property and the HAL will flush all its cached per-
    /// user preferences such as the default devices.
    ///
    /// The value of this property is a `UInt32`, but its value has no currently defined
    /// meaning and clients may pass any value when setting it to trigger the cache flush.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioHardwarePropertyUserIDChanged`
    case userIDChanged

    /// Process Input Mute
    ///
    /// A `UInt32` where a non-zero value indicates that all data coming into the process
    /// for all devices will be silent. A value of `0` indicates that input data will be
    /// received normally.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioHardwarePropertyProcessInputMute`
    case processInputMute

    /// Process Is Audible
    ///
    /// A `UInt32` where a non-zero value indicates that the audio of the process will
    /// be heard. A value of `0` indicates that all audio in the process will not be
    /// heard.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioHardwarePropertyProcessIsAudible`
    case processIsAudible

    /// Sleeping Is Allowed
    ///
    /// A `UInt32` where `1` means that the process will allow the CPU to idle sleep
    /// even if there is audio IO in progress. A `0` means that the CPU will not be
    /// allowed to idle sleep.
    ///
    /// Note that this property won't affect when the CPU is forced to sleep.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioHardwarePropertySleepingIsAllowed`
    case sleepingIsAllowed

    /// Unloading Is Allowed
    ///
    /// A `UInt32` where `1` means that this process wants the HAL to unload itself
    /// after a period of inactivity where there are no `IOProc`s and no listeners
    /// registered with any `AudioObject`.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioHardwarePropertyUnloadingIsAllowed`
    case unloadingIsAllowed

    /// Hog Mode is Allowed
    ///
    /// A `UInt32` where `1` means that this process wants the HAL to automatically take
    /// hog mode and `0` means that the HAL should not automatically take hog mode on
    /// behalf of the process.
    ///
    /// Processes that only ever use the default device are the sort that should set
    /// this property's value to `0`.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioHardwarePropertyHogModeIsAllowed`
    case hogModeIsAllowed

    /// User Session is Active or Headless
    ///
    /// A `UInt32` where a value other than `0` indicates that the login session of the
    /// user of the process is either an active console session or a headless
    /// session.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioHardwarePropertyUserSessionIsActiveOrHeadless`
    case userSessionIsActiveOrHeadless

    /// Service Restarted
    ///
    /// A `UInt32` whose value has no meaning. Rather, this property exists so that
    /// clients can be informed when the service has been reset for some reason.
    /// When a reset happens, any state the client has, such as cached data or
    /// added listeners, must be re-established by the client.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioHardwarePropertyServiceRestarted`
    case serviceRestarted

    /// Power Hint
    ///
    /// A `UInt32` whose values are drawn from the `AudioHardwarePowerHint` enum.
    /// Only those values are allowed.
    ///
    /// This property allows a process to indicate how aggressive the system can be with
    /// optimizations that save power. The default value is `kAudioHardwarePowerHintNone`.
    ///
    /// Note that the value of this property can be set in an application's `Info.plist`
    /// the key, `AudioHardwarePowerHint`. The values for this key are the strings that
    /// correspond to the values in the Power Hints enum.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioHardwarePropertyPowerHint`
    case powerHint

    /// Process Object List
    ///
    /// An array of `AudioObjectID`s that represent the Process objects for all client processes
    /// currently connected to the system.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioHardwarePropertyProcessObjectList`
    case processObjectList

    /// Translate PID to Process Object
    ///
    /// This property fetches the `AudioObjectID` that corresponds to the process object
    /// that has the given PID.
    ///
    /// The PID is passed in via the qualifier as a `pid_t` while the `AudioObjectID` for the
    /// process is returned to the caller as the property's data.
    ///
    /// Note that an error is not returned if the PID doesn't refer to any process. Rather,
    /// this property will return `kAudioObjectUnknown` as the value of the property.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioHardwarePropertyTranslatePIDToProcessObject`
    case translatePIDToProcessObject

    /// Tap List
    ///
    /// An array of `AudioObjectID`s that represent the tap objects on the system.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioHardwarePropertyTapList`
    case tapList

    /// Translate UID to Tap
    ///
    /// This property fetches the `AudioObjectID` that corresponds to the `AudioTap`
    /// that has the given UID.
    ///
    /// The UID is passed in via the qualifier as a CFString while the `AudioObjectID` for the
    /// `AudioTap` is returned to the caller as the property's data.
    ///
    /// Note that an error is not returned if the UID doesn't refer to any `AudioTap`. Rather,
    /// this property will return `kAudioObjectUnknown` as the value of the property.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioHardwarePropertyTranslateUIDToTap`
    case translateUIDToTap
}

extension AudioSystemPropertySelectorConstant: AudioPropertySelectorConstant { }

extension AudioSystemPropertySelectorConstant: Equatable { }

extension AudioSystemPropertySelectorConstant: Hashable { }

extension AudioSystemPropertySelectorConstant: CaseIterable { }

extension AudioSystemPropertySelectorConstant: Sendable { }

// MARK: - Inits

extension AudioSystemPropertySelectorConstant {
    /// Same as ``init(rawValue:)`` but throws an error instead of returning `nil` when a match is not found.
    nonisolated
    public init(tryingRawValue rawValue: FourCharCode) throws(SwiftCoreAudioError) { // a.k.a. UInt32
        guard let match = Self(rawValue: rawValue) else {
            throw .notYetImplemented(
                message: "Unhandled/unrecognized audio system property selector constant value: \(rawValue)"
            )
        }
        self = match
    }
}

// MARK: - RawRepresentable

extension AudioSystemPropertySelectorConstant: RawRepresentable {
    nonisolated
    public init?(rawValue: FourCharCode) { // a.k.a. UInt32
        guard let match = Self.allCases
            .first(where: { $0.rawValue == rawValue })
        else {
            return nil
        }
        self = match
    }

    nonisolated
    public var rawValue: FourCharCode { // a.k.a. UInt32
        switch self {
        // MARK: CoreAudio/AudioHardware.h

        case .devices: kAudioHardwarePropertyDevices // "dev#"
        case .defaultInputDevice: kAudioHardwarePropertyDefaultInputDevice // "dIn "
        case .defaultOutputDevice: kAudioHardwarePropertyDefaultOutputDevice // "dOut"
        case .defaultSystemOutputDevice: kAudioHardwarePropertyDefaultSystemOutputDevice // "sOut"
        case .translateUIDToDevice: kAudioHardwarePropertyTranslateUIDToDevice // "uidd"
        case .mixStereoToMono: kAudioHardwarePropertyMixStereoToMono // "stmo"
        case .plugInList: kAudioHardwarePropertyPlugInList // "plg#"
        case .translateBundleIDToPlugIn: kAudioHardwarePropertyTranslateBundleIDToPlugIn // "bidp"
        case .transportManagerList: kAudioHardwarePropertyTransportManagerList // "tmg#"
        case .translateBundleIDToTransportManager: kAudioHardwarePropertyTranslateBundleIDToTransportManager // "tmbi"
        case .boxList: kAudioHardwarePropertyBoxList // "box#"
        case .translateUIDToBox: kAudioHardwarePropertyTranslateUIDToBox // "uidb"
        case .clockDeviceList: kAudioHardwarePropertyClockDeviceList // "clk#"
        case .translateUIDToClockDevice: kAudioHardwarePropertyTranslateUIDToClockDevice // "uidc"
        case .processIsMain: kAudioHardwarePropertyProcessIsMain // "main"
        case .isInitingOrExiting: kAudioHardwarePropertyIsInitingOrExiting // "inot"
        case .userIDChanged: kAudioHardwarePropertyUserIDChanged // "euid"
        case .processInputMute: kAudioHardwarePropertyProcessInputMute // "pmin"
        case .processIsAudible: kAudioHardwarePropertyProcessIsAudible // "pmut"
        case .sleepingIsAllowed: kAudioHardwarePropertySleepingIsAllowed // "slep"
        case .unloadingIsAllowed: kAudioHardwarePropertyUnloadingIsAllowed // "unld"
        case .hogModeIsAllowed: kAudioHardwarePropertyHogModeIsAllowed // "hogr"
        case .userSessionIsActiveOrHeadless: kAudioHardwarePropertyUserSessionIsActiveOrHeadless // "user"
        case .serviceRestarted: kAudioHardwarePropertyServiceRestarted // "srst"
        case .powerHint: kAudioHardwarePropertyPowerHint // "powh"
        case .processObjectList: kAudioHardwarePropertyProcessObjectList // "prs#"
        case .translatePIDToProcessObject: kAudioHardwarePropertyTranslatePIDToProcessObject // "id2p"
        case .tapList: kAudioHardwarePropertyTapList // "tps#"
        case .translateUIDToTap: kAudioHardwarePropertyTranslateUIDToTap // "uidt"
        }
    }
}

extension AudioSystemPropertySelectorConstant: CustomStringConvertible {
    nonisolated
    public var description: String {
        switch self {
        // MARK: CoreAudio/AudioHardware.h

        case .devices: "Devices"
        case .defaultInputDevice: "Default Input Device"
        case .defaultOutputDevice: "Default Output Device"
        case .defaultSystemOutputDevice: "Default System Output Device"
        case .translateUIDToDevice: "Translate UID to Device"
        case .mixStereoToMono: "Mix Stereo to Mono"
        case .plugInList: "Plug-In List"
        case .translateBundleIDToPlugIn: "Translate Bundle ID to Plug-In"
        case .transportManagerList: "Transport Manager List"
        case .translateBundleIDToTransportManager: "Translate Bundle ID to Transport Manager"
        case .boxList: "Box List"
        case .translateUIDToBox: "Translate UID to Box"
        case .clockDeviceList: "Clock Device List"
        case .translateUIDToClockDevice: "Translate UID to Clock Device"
        case .processIsMain: "Process is Main"
        case .isInitingOrExiting: "Is Initing or Exiting"
        case .userIDChanged: "User ID Changed"
        case .processInputMute: "Process Input Mute"
        case .processIsAudible: "Process Is Audible"
        case .sleepingIsAllowed: "Sleeping Is Allowed"
        case .unloadingIsAllowed: "Unloading Is Allowed"
        case .hogModeIsAllowed: "Hog Mode is Allowed"
        case .userSessionIsActiveOrHeadless: "User Session is Active or Headless"
        case .serviceRestarted: "Service Restarted"
        case .powerHint: "Power Hint"
        case .processObjectList: "Process Object List"
        case .translatePIDToProcessObject: "Translate PID to Process Object"
        case .tapList: "Tap List"
        case .translateUIDToTap: "Translate UID to Tap"
        }
    }
}

// MARK: - Static Constructors

extension AudioPropertySelectorConstant where Self == AudioSystemPropertySelectorConstant {
    /// Analogous to CoreAudio `kAudioHardwareProperty*` selector constants.
    ///
    /// `AudioObjectPropertySelector` values provided by the `AudioSystemObject` class.
    public static func system(_ selector: Self) -> Self {
        selector
    }
}

#endif
