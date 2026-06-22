//
//  AudioClockProperties.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

/// Properties offered by the Core Audio `AudioClock` class.
public protocol AudioClockProperties where Self: AudioObject & UIDIdentifiableAudioObject {
    // MARK: CoreAudio/AudioHardwareBase.h

    /// A `String` that contains a persistent identifier for the clock.
    ///
    /// An clock's UID is persistent across boots. The content of the UID string
    /// is a black box and may contain information that is unique to a particular instance of
    /// an clock's hardware or unique to the CPU. Therefore they are not suitable for passing
    /// between CPUs or for identifying similar models of hardware.
    nonisolated
    var deviceUID: UID { get throws(SwiftCoreAudioError) }

    /// A ``AudioDevice/TransportType`` instance indicating how the clock is connected to the CPU.
    nonisolated
    var transportType: AudioDevice.TransportType { get throws(SwiftCoreAudioError) }

    // TODO: refactor as new enum of known clock domains?
    /// A `UInt32` whose value indicates the clock domain to which this `AudioClockDevice` belongs.
    ///
    /// Clocks and devices that have the same value for this property are able
    /// to be synchronized in hardware. However, a value of `0` indicates that the clock domain
    /// for the device is unspecified and should be assumed to be separate from every other
    /// device's clock domain, even if they have the value of `0` as their clock domain as well.
    nonisolated
    var clockDomain: UInt32 { get throws(SwiftCoreAudioError) }

    /// Returns a boolean value where a value of `true` indicates the device is ready and available,
    /// and `false` means the device is usable and will most likely go away shortly.
    nonisolated
    var isAlive: Bool { get throws(SwiftCoreAudioError) }

    /// Returns a boolean value indicating whether the clock is providing times or not.
    nonisolated
    var isRunning: Bool { get throws(SwiftCoreAudioError) }

    /// A `UInt32` containing the number of frames of latency in the clock.
    nonisolated
    var latency: UInt32 { get throws(SwiftCoreAudioError) }

    // TODO: refactor in a way that can constrain this to only audio controls and provide stronger type hints.
    // Could implement controls as nested types in lieu of no class inheritance model.
    /// Returns an array containing controls of the clock.
    ///
    /// Note that if a notification is received for this property, any cached object identifiers
    /// for the clock become invalid and need to be re-fetched.
    nonisolated
    var controls: [any AudioObject] { get throws(SwiftCoreAudioError) }

    /// Returns the current nominal sample rate of the clock.
    nonisolated
    var nominalSampleRate: Double { get throws(SwiftCoreAudioError) }

    /// An array of ranges that indicates the valid ranges for the nominal sample rate of the clock.
    nonisolated
    var availableNominalSampleRates: [ClosedRange<Double>] { get throws(SwiftCoreAudioError) }
}

#endif
