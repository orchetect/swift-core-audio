//
//  AudioControlPropertySelectorConstant.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

/// Analogous to CoreAudio `kAudioControlProperty*` selector constants.
///
/// `AudioObjectPropertySelector` values provided by the `AudioControl` class.
public enum AudioControlPropertySelectorConstant {
    // MARK: CoreAudio/AudioHardwareBase.h

    /// Scope
    ///
    /// An `AudioServerPlugIn_PropertyScope` that indicates which part of a device the
    /// control applies to.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioControlPropertyScope`
    case scope

    /// Element
    ///
    /// An `AudioServerPlugIn_PropertyElement` that indicates which element of the
    /// device the control applies to.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioControlPropertyElement`
    case element

    // MARK: CoreAudio/AudioHardwareDeprecated.h

    /// Variant
    ///
    /// A `UInt32` that identifies the specific variant of an `AudioControl`.
    ///
    /// This allows the owning `AudioObject` to support controls that are of the same basic
    /// class (that is, the values of `kAudioObjectPropertyClass` are the same) but may
    /// control a part of the object for which the standard controls do not control.
    ///
    /// > File: CoreAudio/AudioHardwareDeprecated.h
    ///
    /// > Constant: `kAudioControlPropertyVariant`
    case variant
}

extension AudioControlPropertySelectorConstant: AudioPropertySelectorConstant { }

extension AudioControlPropertySelectorConstant: Equatable { }

extension AudioControlPropertySelectorConstant: Hashable { }

extension AudioControlPropertySelectorConstant: CaseIterable { }

extension AudioControlPropertySelectorConstant: Sendable { }

// MARK: - Inits

extension AudioControlPropertySelectorConstant {
    /// Same as ``init(rawValue:)`` but throws an error instead of returning `nil` when a match is not found.
    nonisolated
    public init(tryingRawValue rawValue: FourCharCode) throws(SwiftCoreAudioError) { // a.k.a. UInt32
        guard let match = Self(rawValue: rawValue) else {
            throw .notYetImplemented(
                message: "Unhandled/unrecognized audio control property selector constant value: \(rawValue)"
            )
        }
        self = match
    }
}

// MARK: - RawRepresentable

extension AudioControlPropertySelectorConstant: RawRepresentable {
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

        case .scope: kAudioControlPropertyScope // "cscp"
        case .element: kAudioControlPropertyElement // "celm"

        // MARK: CoreAudio/AudioHardwareDeprecated.h

        case .variant: kAudioControlPropertyVariant // "cvar"
        }
    }
}

extension AudioControlPropertySelectorConstant: CustomStringConvertible {
    nonisolated
    public var description: String {
        switch self {
        // MARK: CoreAudio/AudioHardwareBase.h

        case .scope: "Scope"

        case .element: "Element"

        // MARK: CoreAudio/AudioHardwareDeprecated.h

        case .variant: "Variant"
        }
    }
}

// MARK: - Static Constructors

extension AudioPropertySelectorConstant where Self == AudioControlPropertySelectorConstant {
    /// Analogous to CoreAudio `kAudioControlProperty*` selector constants.
    ///
    /// `AudioObjectPropertySelector` values provided by the `AudioControl` class.
    public static func control(_ selector: Self) -> Self {
        selector
    }
}

#endif
