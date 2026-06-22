//
//  AudioStereoPanControlPropertySelectorConstant.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

/// Analogous to CoreAudio `kAudioStereoPanControlProperty*` selector constants.
///
/// `AudioObjectPropertySelector` values provided by the `AudioStereoPanControl` class.
public enum AudioStereoPanControlPropertySelectorConstant {
    // MARK: CoreAudio/AudioHardwareBase.h

    /// Value
    ///
    /// A `Float32` where 0.0 is full left, 1.0 is full right, and 0.5 is center.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioStereoPanControlPropertyValue`
    case value

    /// Panning Channels
    ///
    /// An array of two `UInt32`s that indicate which elements of the device the
    /// signal is being panned between.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioStereoPanControlPropertyPanningChannels`
    case panningChannels
}

extension AudioStereoPanControlPropertySelectorConstant: AudioPropertySelectorConstant { }

extension AudioStereoPanControlPropertySelectorConstant: Equatable { }

extension AudioStereoPanControlPropertySelectorConstant: Hashable { }

extension AudioStereoPanControlPropertySelectorConstant: CaseIterable { }

extension AudioStereoPanControlPropertySelectorConstant: Sendable { }

// MARK: - Inits

extension AudioStereoPanControlPropertySelectorConstant {
    /// Same as ``init(rawValue:)`` but throws an error instead of returning `nil` when a match is not found.
    nonisolated
    public init(tryingRawValue rawValue: FourCharCode) throws(SwiftCoreAudioError) { // a.k.a. UInt32
        guard let match = Self(rawValue: rawValue) else {
            throw .notYetImplemented(
                message: "Unhandled/unrecognized audio stereo pan control property selector constant value: \(rawValue)"
            )
        }
        self = match
    }
}

// MARK: - RawRepresentable

extension AudioStereoPanControlPropertySelectorConstant: RawRepresentable {
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

        case .value: kAudioStereoPanControlPropertyValue // "spcv"
        case .panningChannels: kAudioStereoPanControlPropertyPanningChannels // "spcc"
        }
    }
}

extension AudioStereoPanControlPropertySelectorConstant: CustomStringConvertible {
    nonisolated
    public var description: String {
        switch self {
        // MARK: CoreAudio/AudioHardwareBase.h

        case .value: "Value"
        case .panningChannels: "Panning Channels"
        }
    }
}

// MARK: - Static Constructors

extension AudioPropertySelectorConstant where Self == AudioStereoPanControlPropertySelectorConstant {
    /// Analogous to CoreAudio `kAudioStereoPanControlProperty*` selector constants.
    ///
    /// `AudioObjectPropertySelector` values provided by the `AudioStereoPanControl` class.
    public static func stereoPanControl(_ selector: Self) -> Self {
        selector
    }
}

#endif
