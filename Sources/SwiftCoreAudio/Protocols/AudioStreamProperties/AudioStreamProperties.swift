//
//  AudioStreamProperties.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

/// Properties offered by the Core Audio `AudioStream` class.
public protocol AudioStreamProperties where Self: AudioObject {
    // MARK: CoreAudio/AudioHardware.h

    /// Returns a boolean value indicating whether the stream is enabled and doing IO.
    nonisolated
    var isActive: Bool { get throws(SwiftCoreAudioError) }

    /// Returns the direction of the stream (input or output).
    nonisolated
    var direction: AudioStream.Direction { get throws(SwiftCoreAudioError) }

    /// Returns a ``AudioStream/TerminalType`` instance that describes the general kind of functionality
    /// attached to the stream.
    nonisolated
    var terminalType: AudioStream.TerminalType { get throws(SwiftCoreAudioError) }

    /// Starting channel number (1-based).
    ///
    /// Specifies the first element in the owning device that corresponds to element one of this
    /// stream.
    ///
    /// Channel numbers are 1:1 with user-facing channel numbers (starting from channel 1, then 2,
    /// etc...), not to be confused with channel index (zero-based).
    nonisolated
    var startingChannelNumber: UInt32 { get throws(SwiftCoreAudioError) }

    /// Returns the number of frames of latency in the stream.
    ///
    /// Note that the owning `AudioDevice` may have additional latency so it should be queried
    /// as well. If both the device and the stream say they have latency, then the total latency
    /// for the stream is the device latency summed with the stream latency.
    nonisolated
    var latency: UInt32 { get throws(SwiftCoreAudioError) }

    /// Returns a ``AudioStream/CurrentBasicDescription`` instance describing the current virtual format of the stream.
    ///
    /// The virtual format refers to the data format in which all `IOProc`s for the owning
    /// device will perform IO transactions.
    ///
    /// The underlying type is a Core Audio `AudioStreamBasicDescription`.
    nonisolated
    var virtualFormat: AudioStream.CurrentBasicDescription { get throws(SwiftCoreAudioError) }

    /// Returns an array of ``AudioStream/RangedDescription`` instances describing the available virtual formats
    /// of the stream.
    ///
    /// The virtual format refers to the data format in which all `IOProc`s for the owning
    /// device will perform IO transactions.
    ///
    /// The underlying type is an array of Core Audio `AudioStreamRangedDescription`.
    ///
    /// - Parameters:
    ///   - formatParseErrorHandler: Optionally supply an error handler that will be called for any format
    ///     that fail lookup.
    /// - Throws: Throws an error if format enumeration fails. Individual failures on a per-format basis are
    ///   passed to the `formatParseErrorHandler` closure and do not cause this method itself to throw.
    nonisolated
    func availableVirtualFormats(
        formatParseErrorHandler: ((_ rangedDescription: AudioStreamRangedDescription, _ error: SwiftCoreAudioError) -> Void)?
    ) throws(SwiftCoreAudioError) -> [AudioStream.RangedDescription]

    /// Returns a ``AudioStream/CurrentBasicDescription`` instance describing the current physical format of the stream.
    ///
    /// The physical format refers to the data format in which the hardware for the owning
    /// device performs its IO transactions.
    ///
    /// The underlying type is a Core Audio `AudioStreamBasicDescription`.
    nonisolated
    var physicalFormat: AudioStream.CurrentBasicDescription { get throws(SwiftCoreAudioError) }

    /// Returns an array of ``AudioStream/RangedDescription`` instances describing the available physical formats
    /// of the stream.
    ///
    /// The physical format refers to the data format in which the hardware for the owning
    /// device performs its IO transactions.
    ///
    /// The underlying type is an array of Core Audio `AudioStreamRangedDescription`.
    nonisolated
    var availablePhysicalFormats: [AudioStream.RangedDescription] { get throws(SwiftCoreAudioError) }
}

#endif
