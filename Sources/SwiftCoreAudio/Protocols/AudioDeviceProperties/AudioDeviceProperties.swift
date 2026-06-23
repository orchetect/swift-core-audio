//
//  AudioDeviceProperties.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

/// Properties offered by the Core Audio `AudioObject` class.
public protocol AudioDeviceProperties where Self: AudioObject & AudioClockProperties & UIDIdentifiableAudioObject {
    // MARK: - CoreAudio/AudioHardwareBase.h

    /// A `BundleID` for an application that provides a GUI for configuring the device.
    ///
    /// By default, the value of this property is the bundle ID for Audio MIDI Setup.
    nonisolated
    var configurationApplication: BundleID { get throws(SwiftCoreAudioError) }

    // TODO: Rename to `uid`?
    // Not sure if AudioDevice subclasses have distinct UIDs from their parent AudioDevice UID
    // and we'd want to have access to both UIDs instead of subclasses potentially overriding this
    // property if named `uid`. If not, can safely rename this to `uid` for simplicity, which
    // also fulfills the `UIDIdentifiableAudioObject` protocol requirement directly.
    /// A `UID` that contains a persistent identifier for the device.
    /// A device's UID is persistent across boots.
    ///
    /// The content of the UID string is a black box and may contain information that is unique
    /// to a particular instance of an `AudioDevice`'s hardware or unique to the CPU. Therefore
    /// they are not suitable for passing between CPUs or for identifying similar models of
    /// hardware.
    nonisolated
    var deviceUID: UID { get throws(SwiftCoreAudioError) }

    /// A `String` that contains a persistent identifier for the model of a device.
    ///
    /// The identifier is unique such that the identifier from two devices are equal if
    /// and only if the two devices are the exact same model from the same manufacturer.
    ///
    /// Further, the identifier has to be the same no matter on what machine the device appears.
    nonisolated
    var modelUID: String? { get throws(SwiftCoreAudioError) }

    /// A ``AudioDevice/TransportType`` instance indicating how the device is connected to the CPU.
    nonisolated
    var transportType: AudioDevice.TransportType { get throws(SwiftCoreAudioError) }

    /// An array of devices related to the device.
    ///
    /// For IOAudio-based devices, devices are related if they share the same `IOAudioDevice` object.
    nonisolated
    var relatedDevices: [AnyAudioDevice] { get throws(SwiftCoreAudioError) }

    // TODO: Implement clockDomain
    // var clockDomain: <#Type#> { get throws(SwiftCoreAudioError) }

    /// A boolean value indicating whether the device is ready and available, or unusable and will
    /// most likely go away shortly.
    nonisolated
    var isDeviceAlive: Bool { get throws(SwiftCoreAudioError) }

    /// A boolean value indicating whether the device is performing IO or not.
    ///
    /// Note that the device can be running even if there are no active `IOProc`s such as by
    /// calling `AudioDeviceStart()` and passing a `NULL` `IOProc`.
    nonisolated
    var isDeviceRunning: Bool { get throws(SwiftCoreAudioError) }

    /// A boolean value indicating whether it is possible for the device to be set as the default device.
    nonisolated
    func isSettableAsDefaultDevice(for direction: AudioStream.Direction) throws(SwiftCoreAudioError) -> Bool

    /// A `UInt32` containing the number of frames of latency in the device.
    ///
    /// The device's streams may have additional latency so they should be queried as well. If both
    /// the device and the stream say they have latency, then the total latency for the stream is the
    /// device latency summed with the stream latency.
    nonisolated
    func latency(for direction: AudioStream.Direction) throws(SwiftCoreAudioError) -> UInt32

    /// An array of `AudioStream`s that represent the streams of the device.
    nonisolated
    var streams: [AudioStream] { get throws(SwiftCoreAudioError) }

    // TODO: return new `AnyAudioControl` type?
    /// An array of `AudioObjectID`s that represent the controls of the device.
    nonisolated
    var controls: [AudioObjectID] { get throws(SwiftCoreAudioError) }

    /// A `UInt32` value indicating the number for frames of latency that is safe to do IO.
    ///
    /// Returns number of frames behind the current hardware position (input) or
    /// number for frames ahead the current hardware position (output).
    nonisolated
    func safetyOffset(for direction: AudioStream.Direction) throws(SwiftCoreAudioError) -> UInt32

    /// A `Double` that indicates the current nominal sample rate of the device in Hz (hertz).
    nonisolated
    var nominalSampleRate: Double { get throws(SwiftCoreAudioError) }

    /// An array of `Double` ranges that indicates the valid ranges for the nominal sample rate of
    /// the `AudioDevice` in Hz (hertz).
    nonisolated
    var availableNominalSampleRates: [ClosedRange<Double>] { get throws(SwiftCoreAudioError) }

    /// A file `URL` that indicates an image file that can be used to represent the
    /// device visually.
    nonisolated
    var icon: URL? { get throws(SwiftCoreAudioError) }

    /// A boolean value indicating whether the device is not included in the normal list of devices
    /// nor can it be the default device. Hidden devices can only be discovered by knowing
    /// their UID.
    nonisolated
    var isHidden: Bool { get throws(SwiftCoreAudioError) }

    /// Returns the preferred stereo (left & right) channel indexes for input or output IO of the device.
    ///
    /// > Note:
    /// >
    /// > Channel numbers are presented to the end-user as a 1-based number series (not 0-based indexes).
    /// > SwiftCoreAudio returns a ``StereoAudioChannelIndexes`` instance that provides both a channel index
    /// > a channel number property for each channel to avoid ambiguity.
    ///
    /// Returns `nil` if the device does not contain any channels for the given direction.
    nonisolated
    func preferredStereoChannels(for direction: AudioStream.Direction) throws(SwiftCoreAudioError) -> StereoAudioChannelIndexes?

    // TODO: replace `AudioChannelLayout` with new strongly-typed struct
    /// An `AudioChannelLayout` that indicates how each channel of the device should be used.
    nonisolated
    var preferredChannelLayout: AudioChannelLayout? { get throws(SwiftCoreAudioError) }

    // MARK: - CoreAudio/AudioHardware.h

    /// An `OSStatus` that contains any error codes generated by loading the `IOAudio` driver
    /// plug-in for the `AudioDevice` or `kAudioHardwareNoError` if the plug-in loaded
    /// successfully.
    ///
    /// This property only exists for `IOAudio`-based `AudioDevice`s whose driver has specified
    /// a plug-in to load.
    nonisolated
    var plugInLoadStatus: AudioOSStatus? { get throws(SwiftCoreAudioError) }

    // Note: `deviceHasChanged` is used in notifications

    /// A boolean value indicating whether the device is running in at least one process.
    nonisolated
    var isDeviceRunningSomewhere: Bool { get throws(SwiftCoreAudioError) }

    // Note: `processorOverload` is used in notifications

    // Note: `ioStoppedAbnormally` is used in notifications

    /// The `PID` of the process that currently owns exclusive access to the device,
    /// or `nil` if the device is currently available to all processes.
    nonisolated
    var hogModePID: PID? { get throws(SwiftCoreAudioError) }

    /// A `UInt32` whose value indicates the number of frames in the IO buffers.
    nonisolated
    var bufferFrameSize: UInt32 { get throws(SwiftCoreAudioError) }

    /// A range indicating the minimum and maximum values, inclusive, for ``bufferFrameSize``.
    nonisolated
    var bufferFrameSizeRange: ClosedRange<UInt32> { get throws(SwiftCoreAudioError) }

    // TODO: need to rethink how this is vended. it can return a min/max value set too.
    // /// A boolean value indicating whether the sizes of the buffers passed to an `IOProc` will
    // /// vary by a small amount for the device.
    // var isVariableBufferFrameSizesUsed: Bool { get throws(SwiftCoreAudioError) }

    /// A `Float32` unit interval (`0.0 ... 1.0`) indicating how much of the client portion of the
    /// IO cycle the process will use.
    ///
    /// The client portion of the IO cycle is the portion of the cycle in which the device calls the
    /// `IOProc`s so this property does not the apply to the duration of the entire cycle.
    nonisolated
    var ioCycleUsage: Float32 { get throws(SwiftCoreAudioError) }

    // TODO: Implement input/output streamConfiguration
    // func streamConfiguration(for direction: AudioStream.Direction) throws(SwiftCoreAudioError) -> <#Type#>

    // TODO: Implement ioProcStreamUsage
    // var ioProcStreamUsage: <#Type#> { get throws(SwiftCoreAudioError) }

    /// A `Float64` that indicates the current actual sample rate of the device as measured
    /// by its time stamps.
    nonisolated
    var actualSampleRate: Float64 { get throws(SwiftCoreAudioError) }

    /// An `AudioUID` that contains the UID for the clock device that is currently serving
    /// as the main time base of the device.
    nonisolated
    var clockDeviceUID: AudioClock.UID? { get throws(SwiftCoreAudioError) }

    /// An `WorkGroup` that represents the thread workgroup the device's IO thread belongs to.
    nonisolated
    var workgroup: WorkGroup { get throws(SwiftCoreAudioError) }

    /// A boolean value indicating whether the current process's audio will be zeroed out by the system
    /// for a particular stream direction.
    ///
    /// Note that this property does not apply to aggregate devices—just real, physical devices.
    nonisolated
    func isCurrentProcessMuted(for direction: AudioStream.Direction) throws(SwiftCoreAudioError) -> Bool

    // MARK: CoreAudio/AudioHardwareDeprecated.h

    // Note that constants here are meant to be used by objects other than AudioDevice:
    // - volumeDecibelsToScalarTransferFunction
    // - playThruVolumeDecibelsToScalarTransferFunction
    // - driverShouldOwniSub
    // - subVolumeDecibelsToScalarTransferFunction
}

#endif
