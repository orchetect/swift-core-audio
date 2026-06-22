//
//  AudioTapPropertySelectorConstant.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

/// Analogous to CoreAudio `kAudioTapProperty*` selector constants.
///
/// `AudioObjectPropertySelector` values provided by the `AudioTap` class.
public enum AudioTapPropertySelectorConstant {
    // MARK: CoreAudio/AudioHardware.h

    /// UID
    ///
    /// A `CFString` that contains a persistent identifier for the Tap. A Tap's UID
    /// persists until the tap is destroyed.
    ///
    /// The caller is responsible for releasing the returned `CFObject`.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioTapPropertyUID`
    case uid

    /// Description
    ///
    /// The `CATapDescription` used to initially create this tap. This property can be used
    /// to modify and set the description of an existing tap.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioTapPropertyDescription`
    case description

    /// Format
    ///
    /// An `AudioStreamBasicDescription` that describes the current data format for
    /// the tap. This is the format of that data that will be accessible in any aggregate
    /// device that contains the tap.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioTapPropertyFormat`
    case format
}

extension AudioTapPropertySelectorConstant: AudioPropertySelectorConstant { }

extension AudioTapPropertySelectorConstant: Equatable { }

extension AudioTapPropertySelectorConstant: Hashable { }

extension AudioTapPropertySelectorConstant: CaseIterable { }

extension AudioTapPropertySelectorConstant: Sendable { }

// MARK: - Inits

extension AudioTapPropertySelectorConstant {
    /// Same as ``init(rawValue:)`` but throws an error instead of returning `nil` when a match is not found.
    nonisolated
    public init(tryingRawValue rawValue: FourCharCode) throws(SwiftCoreAudioError) { // a.k.a. UInt32
        guard let match = Self(rawValue: rawValue) else {
            throw .notYetImplemented(
                message: "Unhandled/unrecognized audio tap property selector constant value: \(rawValue)"
            )
        }
        self = match
    }
}

// MARK: - RawRepresentable

extension AudioTapPropertySelectorConstant: RawRepresentable {
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

        case .uid: kAudioTapPropertyUID // "tuid"
        case .description: kAudioTapPropertyDescription // "tdsc"
        case .format: kAudioTapPropertyFormat // "tfmt"
        }
    }
}

extension AudioTapPropertySelectorConstant: CustomStringConvertible {
    nonisolated
    public var description: String {
        switch self {
        // MARK: CoreAudio/AudioHardware.h

        case .uid: "UID"
        case .description: "Description"
        case .format: "Format"
        }
    }
}

// MARK: - Static Constructors

extension AudioPropertySelectorConstant where Self == AudioTapPropertySelectorConstant {
    /// Analogous to CoreAudio `kAudioTapProperty*` selector constants.
    ///
    /// `AudioObjectPropertySelector` values provided by the `AudioTap` class.
    public static func tap(_ selector: Self) -> Self {
        selector
    }
}

#endif
