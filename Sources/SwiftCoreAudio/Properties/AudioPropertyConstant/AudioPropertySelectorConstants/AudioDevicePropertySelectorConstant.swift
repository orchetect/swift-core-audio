//
//  AudioDevicePropertySelectorConstant.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

/// Analogous to CoreAudio `kAudioDeviceProperty*` selector constants.
///
/// `AudioObjectPropertySelector` values provided by the `AudioDevice` class.
public enum AudioDevicePropertySelectorConstant {
    // MARK: Aliased to AudioObject

    /// Element Name
    ///
    /// A `CFString` that contains a human readable name for the given element in the given scope.
    ///
    /// The caller is responsible for releasing the returned `CFObject`.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: Aliased to `kAudioObjectPropertyElementName`
    case elementName

    /// Element Category Name
    ///
    /// A `CFString` that contains a human readable name for the category of the given
    /// element in the given scope.
    ///
    /// The caller is responsible for releasing the returned `CFObject`.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: Aliased to `kAudioObjectPropertyElementCategoryName`
    case elementCategoryName

    /// Element Number Name
    ///
    /// A `CFString` that contains a human readable name for the number of the given
    /// element in the given scope.
    ///
    /// The caller is responsible for releasing the returned `CFObject`.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: Aliased to `kAudioObjectPropertyElementNumberName`
    case elementNumberName

    // MARK: CoreAudio/AudioHardwareBase.h

    /// Configuration Application
    ///
    /// A `CFString` that contains the bundle ID for an application that provides a GUI for
    /// configuring the `AudioDevice`.
    ///
    /// By default, the value of this property is the bundle ID for Audio MIDI Setup.
    ///
    /// The caller is responsible for releasing the returned `CFObject`.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioDevicePropertyConfigurationApplication`
    case configurationApplication

    /// Device UID
    ///
    /// A `CFString` that contains a persistent identifier for the `AudioDevice`.
    /// An `AudioDevice`'s UID is persistent across boots.
    ///
    /// The content of the UID string is a black box and may contain information that is unique
    /// to a particular instance of an `AudioDevice`'s hardware or unique to the CPU. Therefore
    /// they are not suitable for passing between CPUs or for identifying similar models of
    /// hardware.
    ///
    /// The caller is responsible for releasing the returned `CFObject`.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioDevicePropertyDeviceUID`
    case deviceUID

    /// Model UID
    ///
    /// A `CFString` that contains a persistent identifier for the model of an `AudioDevice`.
    ///
    /// The identifier is unique such that the identifier from two `AudioDevice`s are equal if
    /// and only if the two `AudioDevice`s are the exact same model from the same manufacturer.
    ///
    /// Further, the identifier has to be the same no matter on what machine the `AudioDevice`
    /// appears.
    ///
    /// The caller is responsible for releasing the returned `CFObject`.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioDevicePropertyModelUID`
    case modelUID

    /// Transport Type
    ///
    /// A `UInt32` whose value indicates how the `AudioDevice` is connected to the CPU.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioDevicePropertyTransportType`
    case transportType

    /// Related Devices
    ///
    /// An array of `AudioDeviceID`s for devices related to the `AudioDevice`.
    ///
    /// For IOAudio-based devices, `AudioDevice`s are related if they share the same
    /// `IOAudioDevice` object.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioDevicePropertyRelatedDevices`
    case relatedDevices

    /// Clock Domain
    ///
    /// A `UInt32` whose value indicates the clock domain to which this AudioDevice belongs.
    ///
    /// `AudioDevice`s that have the same value for this property are able to be synchronized in
    /// hardware. However, a value of `0` indicates that the clock domain for the device is
    /// unspecified and should be assumed to be separate from every other device's clock domain,
    /// even if they have the value of `0` as their clock domain as well.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioDevicePropertyClockDomain`
    case clockDomain

    /// Device Is Alive
    ///
    /// A `UInt32` where a value of `1` means the device is ready and available and `0`
    /// means the device is unusable and will most likely go away shortly.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioDevicePropertyDeviceIsAlive`
    case deviceIsAlive

    /// Device Is Running
    ///
    /// A `UInt32` where a value of `0` means the `AudioDevice` is not performing IO and
    /// a value of `1` means that it is.
    ///
    /// Note that the device can be running even if there are no active `IOProc`s such as by
    /// calling `AudioDeviceStart()` and passing a `NULL` `IOProc`.
    ///
    /// Note that the notification for this property is usually sent from the `AudioDevice`'s
    /// IO thread.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioDevicePropertyDeviceIsRunning`
    case deviceIsRunning

    /// Device Can Be Default Device
    ///
    /// A `UInt32` where `1` means that the `AudioDevice` is a possible selection for
    /// `kAudioHardwarePropertyDefaultInputDevice` or
    /// `kAudioHardwarePropertyDefaultOutputDevice` depending on the scope.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioDevicePropertyDeviceCanBeDefaultDevice`
    case deviceCanBeDefaultDevice

    /// Device Can Be Default System Device
    ///
    /// A `UInt32` where `1` means that the `AudioDevice` is a possible selection for
    /// `kAudioHardwarePropertyDefaultSystemOutputDevice`.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioDevicePropertyDeviceCanBeDefaultSystemDevice`
    case deviceCanBeDefaultSystemDevice

    /// Latency
    ///
    /// A `UInt32` containing the number of frames of latency in the `AudioDevice`.
    ///
    /// Note that input and output latency may differ. Further, the `AudioDevice`'s `AudioStream`s
    /// may have additional latency so they should be queried as well. If both the device and the
    /// stream say they have latency, then the total latency for the stream is the device latency
    /// summed with the stream latency.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioDevicePropertyLatency`
    case latency

    /// Streams
    ///
    /// An array of `AudioStreamID`s that represent the `AudioStream`s of the `AudioDevice`.
    ///
    /// Note that if a notification is received for this property, any cached `AudioStreamID`s
    /// or the device become invalid and need to be re-fetched.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioDevicePropertyStreams`
    case streams

    /// Control List
    ///
    /// An array of `AudioObjectID`s that represent the `AudioControl`s of the `AudioDevice`.
    ///
    /// Note that if a notification is received for this property, any cached `AudioObjectID`s
    /// for the device become invalid and need to be re-fetched.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioObjectPropertyControlList`
    case controlList

    /// Safety Offset
    ///
    /// A `UInt32` whose value indicates the number for frames ahead (for output)
    /// or behind (for input) the current hardware position that is safe to do IO.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioDevicePropertySafetyOffset`
    case safetyOffset

    /// Nominal Sample Rate
    ///
    /// A `Float64` that indicates the current nominal sample rate of the `AudioDevice`.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioDevicePropertyNominalSampleRate`
    case nominalSampleRate

    /// Available Nominal Sample Rates
    ///
    /// An array of `AudioValueRange` structs that indicates the valid ranges for the
    /// nominal sample rate of the `AudioDevice`.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioDevicePropertyAvailableNominalSampleRates`
    case availableNominalSampleRates

    /// Icon
    ///
    /// A `CFURLRef` that indicates an image file that can be used to represent the
    /// device visually.
    ///
    /// The caller is responsible for releasing the returned `CFObject`.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioDevicePropertyIcon`
    case icon

    /// Is Hidden
    ///
    /// A `UInt32` where a non-zero value indicates that the device is not included
    /// in the normal list of devices provided by `kAudioHardwarePropertyDevices` nor
    /// can it be the default device. Hidden devices can only be discovered by
    /// knowing their UID and using `kAudioHardwarePropertyDeviceForUID`.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioDevicePropertyIsHidden`
    case isHidden

    /// Preferred Channels For Stereo
    ///
    /// An array of two `UInt32`s, the first for the left channel, the second for the
    /// right channel, that indicate the channel numbers to use for stereo IO on the
    /// device. The value of this property can be different for input and output and
    /// there are no restrictions on the channel numbers that can be used.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioDevicePropertyPreferredChannelsForStereo`
    case preferredChannelsForStereo

    /// Preferred Channel Layout
    ///
    /// An `AudioChannelLayout` that indicates how each channel of the `AudioDevice`
    /// should be used.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioDevicePropertyPreferredChannelLayout`
    case preferredChannelLayout

    // MARK: CoreAudio/AudioHardware.h

    /// Plug-In Load Status
    ///
    /// An `OSStatus` that contains any error codes generated by loading the `IOAudio` driver
    /// plug-in for the `AudioDevice` or `kAudioHardwareNoError` if the plug-in loaded
    /// successfully.
    ///
    /// This property only exists for `IOAudio`-based `AudioDevice`s whose driver has specified
    /// a plug-in to load.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioDevicePropertyPlugIn`
    case plugIn

    /// Device Has Changed
    ///
    /// The type of this property is a `UInt32`, but its value has no meaning.
    ///
    /// This property exists so that clients can listen to it and be told when the configuration
    /// of the `AudioDevice` has changed in ways that cannot otherwise be conveyed through other
    /// notifications. In response to this notification, clients should re-evaluate everything
    /// they need to know about the device, particularly the layout and values of the controls.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioDevicePropertyDeviceHasChanged`
    case deviceHasChanged

    /// Device is Running Somewhere
    ///
    /// A `UInt32` where `1` means that the `AudioDevice` is running in at least one process on
    /// the system and `0` means that it isn't running at all.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioDevicePropertyDeviceIsRunningSomewhere`
    case deviceIsRunningSomewhere

    /// Processor Overload
    ///
    /// A `UInt32` where the value has no meaning.
    ///
    /// This property exists so that clients can be notified when the `AudioDevice` detects that
    /// an IO cycle has run past its deadline. Note that the notification for this property is
    /// usually sent from the `AudioDevice`'s IO thread.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioDeviceProcessorOverload`
    case processorOverload

    /// IO Stopped Abnormally
    ///
    /// A `UInt32` where the value has no meaning.
    ///
    /// This property exists so that clients can be notified when IO on the device has stopped
    /// outside of the normal mechanisms. This typically comes up when IO is stopped after
    /// `AudioDeviceStart` has returned successfully but prior to the notification for
    /// `kAudioDevicePropertyIsRunning` being sent.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioDevicePropertyIOStoppedAbnormally`
    case ioStoppedAbnormally

    /// Hog Mode
    ///
    /// A `pid_t` indicating the process that currently owns exclusive access to the `AudioDevice`
    /// or a value of `-1` indicating that the device is currently available to all processes.
    ///
    /// If the `AudioDevice` is in a non-mixable mode, the HAL will automatically take hog mode
    /// on behalf of the first process to start an `IOProc`.
    ///
    /// Note that when setting this property, the value passed in is ignored.
    /// If another process owns exclusive access, that remains unchanged.
    /// If the current process owns exclusive access, it is released and made available to all
    /// processes again. If no process has exclusive access (meaning the current value is `-1`),
    /// this process gains ownership of exclusive access.
    ///
    /// On return, the `pid_t` pointed to by `inPropertyData` will contain the new value of the
    /// property.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioDevicePropertyHogMode`
    case hogMode

    /// Buffer Frame Size
    ///
    /// A `UInt32` whose value indicates the number of frames in the IO buffers.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioDevicePropertyBufferFrameSize`
    case bufferFrameSize

    /// Buffer Frame Size Range
    ///
    /// An `AudioValueRange` indicating the minimum and maximum values, inclusive, for
    /// `kAudioDevicePropertyBufferFrameSize`.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioDevicePropertyBufferFrameSizeRange`
    case bufferFrameSizeRange

    /// Uses Variable Buffer Frame Sizes
    ///
    /// A `UInt32` that, if implemented by a device, indicates that the sizes of the buffers
    /// passed to an `IOProc` will vary by a small amount.
    ///
    /// The value of this property will indicate the largest buffer that will be passed and
    /// `kAudioDevicePropertyBufferFrameSize` will indicate the smallest buffer that will get
    /// passed to the IOProc.
    ///
    /// The usage of this property is narrowed to only allow for devices whose buffer sizes vary
    /// by small amounts greater than `kAudioDevicePropertyBufferFrameSize`. It is not intended
    /// to be a license for devices to be able to send buffers however they please.
    /// Rather, it is intended to allow for hardware whose natural rhythms lead to this necessity.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioDevicePropertyUsesVariableBufferFrameSizes`
    case usesVariableBufferFrameSizes

    /// IO Cycle Usage
    ///
    /// A `Float32` whose range is from `0` to `1`.
    ///
    /// This value indicates how much of the client portion of the IO cycle the process will use.
    ///
    /// The client portion of the IO cycle is the portion of the cycle in which the device calls the
    /// `IOProc`s so this property does not the apply to the duration of the entire cycle.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioDevicePropertyIOCycleUsage`
    case ioCycleUsage

    /// Stream Configuration
    ///
    /// This property returns the stream configuration of the device in an `AudioBufferList`
    /// (with the buffer pointers set to `NULL`) which describes the list of streams and the number
    /// of channels in each stream. This corresponds to what will be passed into the `IOProc`.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioDevicePropertyStreamConfiguration`
    case streamConfiguration

    /// IOProc Stream Usage
    ///
    /// An `AudioHardwareIOProcStreamUsage` structure which details the stream usage of a given
    /// `IOProc`. If a stream is marked as not being used, the given `IOProc` will see a corresponding
    /// `NULL` buffer pointer in the `AudioBufferList` passed to its IO proc.
    ///
    /// Note that the number of streams detailed in the `AudioHardwareIOProcStreamUsage` must include
    /// all the streams of that direction on the device.
    ///
    /// Also, when getting the value of the property, one must fill out the `mIOProc` field of the
    /// `AudioHardwareIOProcStreamUsage` with the address of the of the `IOProc` whose stream usage
    /// is to be retrieved.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioDevicePropertyIOProcStreamUsage`
    case ioProcStreamUsage

    /// Actual Sample Rate
    ///
    /// A `Float64` that indicates the current actual sample rate of the `AudioDevice`as measured
    /// by its time stamps.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioDevicePropertyActualSampleRate`
    case actualSampleRate

    /// Clock Device
    ///
    /// A `CFString` that contains the UID for the `AudioClockDevice` that is currently serving
    /// as the main time base of the device.
    ///
    /// The caller is responsible for releasing the returned `CFObject`.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioDevicePropertyClockDevice`
    case clockDevice

    /// IO Thread OS Workgroup
    ///
    /// An `os_workgroup_t` that represents the thread workgroup the `AudioDevice`'s IO thread
    /// belongs to.
    ///
    /// The caller is responsible for releasing the returned object.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioDevicePropertyIOThreadOSWorkgroup`
    case ioThreadOSWorkgroup

    /// Process Mute
    ///
    /// A `UInt32` where a non-zero value indicates that the current process's audio will be
    /// zeroed out by the system.
    ///
    /// Note that this property does not apply to aggregate devices—just real, physical devices.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioDevicePropertyProcessMute`
    case processMute

    // MARK: CoreAudio/AudioHardwareDeprecated.h

    /// Volume Decibels to Scalar Transfer Function
    ///
    /// A `UInt32` whose value indicates the transfer function the HAL uses to convert
    /// between decibel values and scalar values.
    ///
    /// This property is implemented by an `AudioControl` object that is a subclass of
    /// `AudioVolumeControl`.
    ///
    /// > File: CoreAudio/AudioHardwareDeprecated.h
    ///
    /// > Constant: `kAudioDevicePropertyVolumeDecibelsToScalarTransferFunction`
    case volumeDecibelsToScalarTransferFunction

    /// Play Through Volume Decibels to Scalar Transfer Function
    ///
    /// A `UInt32` whose value indicates the transfer function the HAL uses to convert
    /// between decibel values and scalar values.
    ///
    /// This property is implemented by an `AudioControl` object that is a subclass of
    /// `AudioVolumeControl`.
    ///
    /// Further, the control that implements this property is only available through
    /// `kAudioDevicePropertyScopePlayThrough`.
    ///
    /// > File: CoreAudio/AudioHardwareDeprecated.h
    ///
    /// > Constant: `kAudioDevicePropertyPlayThruVolumeDecibelsToScalarTransferFunction`
    case playThruVolumeDecibelsToScalarTransferFunction

    /// Driver Should Own iSub
    ///
    /// A `UInt32` where a value of `0` means that the `AudioDevice` should not claim
    /// ownership of any attached iSub and a value of `1` means that it should.
    ///
    /// Note that this property is only available for built-in devices and for USB Audio
    /// devices that use the standard class compliant driver.
    ///
    /// This property is implemented by an `AudioControl` object that is a subclass of
    /// `AudioISubOwnerControl`.
    ///
    /// > File: CoreAudio/AudioHardwareDeprecated.h
    ///
    /// > Constant: `kAudioDevicePropertyDriverShouldOwniSub`
    case driverShouldOwniSub

    /// Sub Volume Decibels to Scalar Transfer Function
    ///
    /// A `UInt32` whose value indicates the transfer function the HAL uses to convert
    /// between decibel values and scalar values.
    ///
    /// This property is implemented by an `AudioControl` object that is a subclass of
    /// `AudioLFEVolumeControl`.
    ///
    /// > File: CoreAudio/AudioHardwareDeprecated.h
    ///
    /// > Constant: `kAudioDevicePropertySubVolumeDecibelsToScalarTransferFunction`
    case subVolumeDecibelsToScalarTransferFunction

    // (Note that the CoreAudio/AudioHardwareDeprecated.h enum labelled
    // "AudioDevice Properties That Ought To Some Day Be Deprecated" is not implemented here,
    // as all of its contents have preferable alternatives.)
}

extension AudioDevicePropertySelectorConstant: AudioPropertySelectorConstant { }

extension AudioDevicePropertySelectorConstant: Equatable { }

extension AudioDevicePropertySelectorConstant: Hashable { }

extension AudioDevicePropertySelectorConstant: CaseIterable { }

extension AudioDevicePropertySelectorConstant: Sendable { }

// MARK: - Inits

extension AudioDevicePropertySelectorConstant {
    /// Same as ``init(rawValue:)`` but throws an error instead of returning `nil` when a match is not found.
    nonisolated
    public init(tryingRawValue rawValue: FourCharCode) throws(SwiftCoreAudioError) { // a.k.a. UInt32
        guard let match = Self(rawValue: rawValue) else {
            throw .notYetImplemented(
                message: "Unhandled/unrecognized audio device property selector constant value: \(rawValue)"
            )
        }
        self = match
    }
}

// MARK: - RawRepresentable

extension AudioDevicePropertySelectorConstant: RawRepresentable {
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
        // MARK: Aliased to AudioObject

        case .elementName: AudioObjectPropertySelectorConstant.elementName.rawValue
        case .elementCategoryName: AudioObjectPropertySelectorConstant.elementCategoryName.rawValue
        case .elementNumberName: AudioObjectPropertySelectorConstant.elementNumberName.rawValue

        // MARK: CoreAudio/AudioHardwareBase.h
        case .configurationApplication: kAudioDevicePropertyConfigurationApplication // "capp"
        case .deviceUID: kAudioDevicePropertyDeviceUID // "uid "
        case .modelUID: kAudioDevicePropertyModelUID // "muid"
        case .transportType: kAudioDevicePropertyTransportType // "tran"
        case .relatedDevices: kAudioDevicePropertyRelatedDevices // "akin"
        case .clockDomain: kAudioDevicePropertyClockDomain // "clkd"
        case .deviceIsAlive: kAudioDevicePropertyDeviceIsAlive // "livn"
        case .deviceIsRunning: kAudioDevicePropertyDeviceIsRunning // "goin"
        case .deviceCanBeDefaultDevice: kAudioDevicePropertyDeviceCanBeDefaultDevice // "dflt"
        case .deviceCanBeDefaultSystemDevice: kAudioDevicePropertyDeviceCanBeDefaultSystemDevice // "sflt"
        case .latency: kAudioDevicePropertyLatency // "ltnc"
        case .streams: kAudioDevicePropertyStreams // "stm#"
        case .controlList: kAudioObjectPropertyControlList // "ctrl"
        case .safetyOffset: kAudioDevicePropertySafetyOffset // "saft"
        case .nominalSampleRate: kAudioDevicePropertyNominalSampleRate // "nsrt"
        case .availableNominalSampleRates: kAudioDevicePropertyAvailableNominalSampleRates // "nsr#"
        case .icon: kAudioDevicePropertyIcon // "icon"
        case .isHidden: kAudioDevicePropertyIsHidden // "hidn"
        case .preferredChannelsForStereo: kAudioDevicePropertyPreferredChannelsForStereo // "dch2"
        case .preferredChannelLayout: kAudioDevicePropertyPreferredChannelLayout // "srnd"

        // MARK: CoreAudio/AudioHardware.h
        case .plugIn: kAudioDevicePropertyPlugIn // "plug"
        case .deviceHasChanged: kAudioDevicePropertyDeviceHasChanged // "diff"
        case .deviceIsRunningSomewhere: kAudioDevicePropertyDeviceIsRunningSomewhere // "gone"
        case .processorOverload: kAudioDeviceProcessorOverload // "over"
        case .ioStoppedAbnormally: kAudioDevicePropertyIOStoppedAbnormally // "stpd"
        case .hogMode: kAudioDevicePropertyHogMode // "oink"
        case .bufferFrameSize: kAudioDevicePropertyBufferFrameSize // "fsiz"
        case .bufferFrameSizeRange: kAudioDevicePropertyBufferFrameSizeRange // "fsz#"
        case .usesVariableBufferFrameSizes: kAudioDevicePropertyUsesVariableBufferFrameSizes // "vfsz"
        case .ioCycleUsage: kAudioDevicePropertyIOCycleUsage // "ncyc"
        case .streamConfiguration: kAudioDevicePropertyStreamConfiguration // "slay"
        case .ioProcStreamUsage: kAudioDevicePropertyIOProcStreamUsage // "suse"
        case .actualSampleRate: kAudioDevicePropertyActualSampleRate // "asrt"
        case .clockDevice: kAudioDevicePropertyClockDevice // "apcd"
        case .ioThreadOSWorkgroup: kAudioDevicePropertyIOThreadOSWorkgroup // "oswg"
        case .processMute: kAudioDevicePropertyProcessMute // "appm"

        // MARK: CoreAudio/AudioHardwareDeprecated.h
        case .volumeDecibelsToScalarTransferFunction: kAudioDevicePropertyVolumeDecibelsToScalarTransferFunction // "vctf"
        case .playThruVolumeDecibelsToScalarTransferFunction: kAudioDevicePropertyPlayThruVolumeDecibelsToScalarTransferFunction // "mvtf"
        case .driverShouldOwniSub: kAudioDevicePropertyDriverShouldOwniSub // "isub"
        case .subVolumeDecibelsToScalarTransferFunction: kAudioDevicePropertySubVolumeDecibelsToScalarTransferFunction // "svtf"
        }
    }
}

extension AudioDevicePropertySelectorConstant: CustomStringConvertible {
    nonisolated
    public var description: String {
        switch self {
        // MARK: Aliased to AudioObject

        case .elementName: AudioObjectPropertySelectorConstant.elementName.description
        case .elementCategoryName: AudioObjectPropertySelectorConstant.elementCategoryName.description
        case .elementNumberName: AudioObjectPropertySelectorConstant.elementNumberName.description

        // MARK: CoreAudio/AudioHardwareBase.h
        case .configurationApplication: "Configuration Application"
        case .deviceUID: "Device UID"
        case .modelUID: "Model UID"
        case .transportType: "Transport Type"
        case .relatedDevices: "Related Devices"
        case .clockDomain: "clock Domain"
        case .deviceIsAlive: "Device Is Alive"
        case .deviceIsRunning: "Device Is Running"
        case .deviceCanBeDefaultDevice: "Device Can Be Default Device"
        case .deviceCanBeDefaultSystemDevice: "Device Can Be Default System Device"
        case .latency: "Latency"
        case .streams: "Streams"
        case .controlList: "Control List"
        case .safetyOffset: "Safety Offset"
        case .nominalSampleRate: "Nominal Sample Rate"
        case .availableNominalSampleRates: "Available Nominal Sample Rates"
        case .icon: "Icon"
        case .isHidden: "Is Hidden"
        case .preferredChannelsForStereo: "Preferred Channels For Stereo"
        case .preferredChannelLayout: "Preferred Channel Layout"

        // MARK: CoreAudio/AudioHardware.h
        case .plugIn: "Plug-In"
        case .deviceHasChanged: "Device Has Changed"
        case .deviceIsRunningSomewhere: "Device is Running Somewhere"
        case .processorOverload: "Processor Overload"
        case .ioStoppedAbnormally: "IO Stopped Abnormally"
        case .hogMode: "Hog Mode"
        case .bufferFrameSize: "Buffer Frame Size"
        case .bufferFrameSizeRange: "Buffer Frame Size Range"
        case .usesVariableBufferFrameSizes: "Uses Variable Buffer Frame Sizes"
        case .ioCycleUsage: "IO Cycle Usage"
        case .streamConfiguration: "Stream Configuration"
        case .ioProcStreamUsage: "IOProc Stream Usage"
        case .actualSampleRate: "Actual Sample Rate"
        case .clockDevice: "Clock Device"
        case .ioThreadOSWorkgroup: "IO Thread OS Workgroup"
        case .processMute: "Process Mute"

        // MARK: CoreAudio/AudioHardwareDeprecated.h
        case .volumeDecibelsToScalarTransferFunction: "Volume Decibels to Scalar Transfer Function"
        case .playThruVolumeDecibelsToScalarTransferFunction: "Play Through Volume Decibels to Scalar Transfer Function"
        case .driverShouldOwniSub: "Driver Should Own iSub"
        case .subVolumeDecibelsToScalarTransferFunction: "Sub Volume Decibels to Scalar Transfer Function"
        }
    }
}

// MARK: - Static Constructors

extension AudioPropertySelectorConstant where Self == AudioDevicePropertySelectorConstant {
    /// Analogous to CoreAudio `kAudioDeviceProperty*` selector constants.
    ///
    /// `AudioObjectPropertySelector` values provided by the `AudioDevice` class.
    public static func device(_ selector: Self) -> Self {
        selector
    }
}

#endif
