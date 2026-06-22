//
//  AudioBooleanControlPropertySelectorConstant.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

/// Analogous to CoreAudio `kAudioBooleanControlProperty*` selector constants.
///
/// `AudioObjectPropertySelector` values provided by the `AudioBooleanControl` class.
public enum AudioBooleanControlPropertySelectorConstant {
    // MARK: CoreAudio/AudioHardwareBase.h

    /// Value
    ///
    /// A `UInt32` where `0` means off/false and non-zero means on/true.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioBooleanControlPropertyValue`
    case value
}

extension AudioBooleanControlPropertySelectorConstant: AudioPropertySelectorConstant { }

extension AudioBooleanControlPropertySelectorConstant: Equatable { }

extension AudioBooleanControlPropertySelectorConstant: Hashable { }

extension AudioBooleanControlPropertySelectorConstant: CaseIterable { }

extension AudioBooleanControlPropertySelectorConstant: Sendable { }

// MARK: - Inits

extension AudioBooleanControlPropertySelectorConstant {
    /// Same as ``init(rawValue:)`` but throws an error instead of returning `nil` when a match is not found.
    nonisolated
    public init(tryingRawValue rawValue: FourCharCode) throws(SwiftCoreAudioError) { // a.k.a. UInt32
        guard let match = Self(rawValue: rawValue) else {
            throw .notYetImplemented(
                message: "Unhandled/unrecognized audio boolean control property selector constant value: \(rawValue)"
            )
        }
        self = match
    }
}

// MARK: - RawRepresentable

extension AudioBooleanControlPropertySelectorConstant: RawRepresentable {
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

        case .value: kAudioBooleanControlPropertyValue // "bcvl"
        }
    }
}

extension AudioBooleanControlPropertySelectorConstant: CustomStringConvertible {
    nonisolated
    public var description: String {
        switch self {
        // MARK: CoreAudio/AudioHardwareBase.h

        case .value: "Value"
        }
    }
}

// MARK: - Static Constructors

extension AudioPropertySelectorConstant where Self == AudioBooleanControlPropertySelectorConstant {
    /// Analogous to CoreAudio `kAudioBooleanControlProperty*` selector constants.
    ///
    /// `AudioObjectPropertySelector` values provided by the `AudioBooleanControl` class.
    public static func booleanControl(_ selector: Self) -> Self {
        selector
    }
}

#endif
