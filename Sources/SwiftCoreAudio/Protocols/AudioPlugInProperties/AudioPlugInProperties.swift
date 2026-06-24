//
//  AudioPlugInProperties.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

/// Properties offered by the Core Audio `AudioPlugIn` class.
public protocol AudioPlugInProperties where Self: AudioObject {
    // MARK: CoreAudio/AudioHardwareBase.h

    /// Returns the bundle ID string associated with the plugin.
    nonisolated
    var bundleID: BundleID? { get throws(SwiftCoreAudioError) }

    /// Returns an array of devices provided by the plugin.
    nonisolated
    var devices: [AnyAudioDevice] { get throws(SwiftCoreAudioError) }

    /// Returns the device for the given UID.
    nonisolated
    func device<Device: AudioDeviceProperties & IDConstructibleAudioObject>(
        forUID uid: Device.UID
    ) throws(SwiftCoreAudioError) -> Device?

    /// Returns an array of boxes provided by the plugin.
    nonisolated
    var boxes: [AudioBox] { get throws(SwiftCoreAudioError) }

    /// Returns the box for the given UID.
    nonisolated
    func box<Box: AudioBoxProperties & IDConstructibleAudioObject>(
        forUID uid: Box.UID
    ) throws(SwiftCoreAudioError) -> Box?

    /// Returns an array of clocks provided by the plugin.
    nonisolated
    var clocks: [AudioClock] { get throws(SwiftCoreAudioError) }

    /// Returns the device for the given UID.
    nonisolated
    func clock<Clock: AudioClockProperties & IDConstructibleAudioObject>(
        forUID uid: Clock.UID
    ) throws(SwiftCoreAudioError) -> Clock?

    /// Tell the plug-in to create a new aggregate audio device.
    ///
    /// - Parameters:
    ///   - composition: Composition data structure used to create the aggregate.
    ///   - timeout: If non-`nil`, waits synchronously for Core Audio to complete creating the
    ///     aggregate before returning.
    /// - Returns: If successful, returns an ``AudioAggregateDevice`` instance representing the newly
    ///   created aggregate.
    @discardableResult
    nonisolated
    func makeAggregateDevice(
        composition: AudioAggregateDevice.Composition,
        waitForCompletionWithTimeout timeout: TimeInterval?
    ) throws(SwiftCoreAudioError) -> AudioAggregateDevice

    /// Tell the plug-in to create a new aggregate audio device.
    ///
    /// - Parameters:
    ///   - composition: Composition dictionary used to create the aggregate.
    ///   - timeout: If non-`nil`, waits synchronously for Core Audio to complete creating the
    ///     aggregate before returning.
    /// - Returns: If successful, returns an ``AudioAggregateDevice`` instance representing the newly
    ///   created aggregate.
    @discardableResult
    nonisolated
    func makeAggregateDevice(
        composition: CFDictionary,
        waitForCompletionWithTimeout timeout: TimeInterval?
    ) throws(SwiftCoreAudioError) -> AudioAggregateDevice

    /// Tell the plug-in to destroy an aggregate audio device.
    ///
    /// - Parameters:
    ///   - aggregate: The aggregate device to destroy.
    ///   - timeout: If non-`nil`, waits synchronously for Core Audio to complete destroying the
    ///     aggregate before returning.
    nonisolated
    func destroyAggregateDevice(
        _ aggregate: AudioAggregateDevice,
        waitForCompletionWithTimeout timeout: TimeInterval?
    ) throws(SwiftCoreAudioError)
}

#endif
