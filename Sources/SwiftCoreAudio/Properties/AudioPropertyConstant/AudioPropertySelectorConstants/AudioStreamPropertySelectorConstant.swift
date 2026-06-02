//
//  AudioStreamPropertySelectorConstant.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

/// Analogous to CoreAudio `kAudioStreamProperty*` selector constants.
///
/// `AudioObjectPropertySelector` values provided by the `AudioStream` class.
public enum AudioStreamPropertySelectorConstant {
    // MARK: CoreAudio/AudioHardwareBase.h
    
    /// Is Active
    ///
    /// A `UInt32` where a non-zero value indicates that the stream is enabled and doing IO.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioStreamPropertyIsActive`
    case isActive
    
    /// Direction
    ///
    /// A `UInt32` where a value of `0` means that this `AudioStream` is an output stream
    /// and a value of `1` means that it is an input stream.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioStreamPropertyDirection`
    case direction
    
    /// Terminal Type
    ///
    /// A `UInt32` whose value describes the general kind of functionality attached
    /// to the `AudioStream`.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioStreamPropertyTerminalType`
    case terminalType
    
    /// Starting Channel
    ///
    /// A `UInt32` that specifies the first element in the owning device that
    /// corresponds to element one of this stream.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioStreamPropertyStartingChannel`
    case startingChannel
    
    /// Latency
    ///
    /// A `UInt32` containing the number of frames of latency in the `AudioStream`.
    ///
    /// Note that the owning `AudioDevice` may have additional latency so it should be queried
    /// as well. If both the device and the stream say they have latency, then the total latency
    /// for the stream is the device latency summed with the stream latency.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioStreamPropertyLatency`
    case latency
    
    /// Virtual Format
    ///
    /// An `AudioStreamBasicDescription` that describes the current data format for
    /// the `AudioStream`. The virtual format refers to the data format in which all
    /// `IOProc`s for the owning `AudioDevice` will perform IO transactions.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioStreamPropertyVirtualFormat`
    case virtualFormat
    
    /// Available Virtual Formats
    ///
    /// An array of `AudioStreamRangedDescriptions` that describe the available data
    /// formats for the `AudioStream`. The virtual format refers to the data format in
    /// which all `IOProc`s for the owning `AudioDevice` will perform IO transactions.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioStreamPropertyAvailableVirtualFormats`
    case availableVirtualFormats
    
    /// Physical Format
    ///
    /// An `AudioStreamBasicDescription` that describes the current data format for
    /// the `AudioStream`. The physical format refers to the data format in which the
    /// hardware for the owning `AudioDevice` performs its IO transactions.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioStreamPropertyPhysicalFormat`
    case physicalFormat
    
    /// Available Physical Formats
    ///
    /// An array of `AudioStreamRangedDescriptions` that describe the available data
    /// formats for the `AudioStream`. The physical format refers to the data format
    /// in which the hardware for the owning `AudioDevice` performs its IO
    /// transactions.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioStreamPropertyAvailablePhysicalFormats`
    case availablePhysicalFormats
    
    // (Note that the CoreAudio/AudioHardwareDeprecated.h enum labelled
    // "AudioStream Properties That Ought To Some Day Be Deprecated" is not implemented here,
    // as all of its contents have preferable alternatives.)
}

extension AudioStreamPropertySelectorConstant: AudioPropertySelectorConstant { }

extension AudioStreamPropertySelectorConstant: Equatable { }

extension AudioStreamPropertySelectorConstant: Hashable { }

extension AudioStreamPropertySelectorConstant: CaseIterable { }

extension AudioStreamPropertySelectorConstant: Sendable { }

// MARK: - Inits

extension AudioStreamPropertySelectorConstant {
    /// Same as ``init(rawValue:)`` but throws an error instead of returning `nil` when a match is not found.
    nonisolated
    public init(tryingRawValue rawValue: FourCharCode) throws(SwiftCoreAudioError) { // a.k.a. UInt32
        guard let match = Self(rawValue: rawValue) else {
            throw .notYetImplemented(
                message: "Unhandled/unrecognized audio stream property selector constant value: \(rawValue)"
            )
        }
        self = match
    }
}

// MARK: - RawRepresentable

extension AudioStreamPropertySelectorConstant: RawRepresentable {
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
        // MARK: CoreAudio/AudioHardwareBase.h
        case .isActive: kAudioStreamPropertyIsActive // "sact"
        case .direction: kAudioStreamPropertyDirection // "sdir"
        case .terminalType: kAudioStreamPropertyTerminalType // "term"
        case .startingChannel: kAudioStreamPropertyStartingChannel // "schn"
        case .latency: kAudioStreamPropertyLatency // == kAudioDevicePropertyLatency
        case .virtualFormat: kAudioStreamPropertyVirtualFormat // "sfmt"
        case .availableVirtualFormats: kAudioStreamPropertyAvailableVirtualFormats // "sfma"
        case .physicalFormat: kAudioStreamPropertyPhysicalFormat // "pft "
        case .availablePhysicalFormats: kAudioStreamPropertyAvailablePhysicalFormats // "pfta"
        }
    }
}

extension AudioStreamPropertySelectorConstant: CustomStringConvertible {
    nonisolated
    public var description: String {
        switch self {
        // MARK: CoreAudio/AudioHardwareBase.h
        case .isActive: "Is Active"
        case .direction: "Direction"
        case .terminalType: "Terminal Type"
        case .startingChannel: "Starting Channel"
        case .latency: "Latency"
        case .virtualFormat: "Virtual Format"
        case .availableVirtualFormats: "Available Virtual Formats"
        case .physicalFormat: "Physical Format"
        case .availablePhysicalFormats: "Available Physical Formats"
        }
    }
}

// MARK: - Static Constructors

extension AudioPropertySelectorConstant where Self == AudioStreamPropertySelectorConstant {
    /// Analogous to CoreAudio `kAudioStreamProperty*` selector constants.
    ///
    /// `AudioObjectPropertySelector` values provided by the `AudioStream` class.
    public static func stream(_ selector: Self) -> Self {
        selector
    }
}

#endif
