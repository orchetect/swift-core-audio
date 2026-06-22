//
//  AudioObjectPropertyScopeConstant.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

/// Analogous to CoreAudio `kAudioObjectPropertyScope*` scope constants.
public enum AudioObjectPropertyScopeConstant {
    // MARK: CoreAudio/AudioHardwareBase.h

    /// Global scope.
    ///
    /// The `AudioObjectPropertyScope` for properties that apply to the object as a whole.
    /// All objects have a global scope and for most it is their only scope.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioObjectPropertyScopeGlobal`
    case global

    /// Input scope.
    ///
    /// The `AudioObjectPropertyScope` for properties that apply to the input side of an object.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioObjectPropertyScopeInput`
    case input

    /// Output scope.
    ///
    /// The `AudioObjectPropertyScope` for properties that apply to the output side of an object.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioObjectPropertyScopeOutput`
    case output

    /// PlayThrough scope.
    ///
    /// The `AudioObjectPropertyScope` for properties that apply to the play through side of an object.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioObjectPropertyScopePlayThrough`
    case playThrough
}

extension AudioObjectPropertyScopeConstant: AudioPropertyScopeConstant { }

extension AudioObjectPropertyScopeConstant: Equatable { }

extension AudioObjectPropertyScopeConstant: Hashable { }

extension AudioObjectPropertyScopeConstant: CaseIterable { }

extension AudioObjectPropertyScopeConstant: Sendable { }

// MARK: - Inits

extension AudioObjectPropertyScopeConstant {
    /// Same as ``init(rawValue:)`` but throws an error instead of returning `nil` when a match is not found.
    nonisolated
    public init(tryingRawValue rawValue: FourCharCode) throws(SwiftCoreAudioError) { // a.k.a. UInt32
        guard let match = Self(rawValue: rawValue) else {
            throw .notYetImplemented(
                message: "Unhandled/unrecognized audio object property scope constant value: \(rawValue)"
            )
        }
        self = match
    }
}

// MARK: - RawRepresentable

extension AudioObjectPropertyScopeConstant: RawRepresentable {
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

        case .global: kAudioObjectPropertyScopeGlobal // "glob"
        case .input: kAudioObjectPropertyScopeInput // "inpt"
        case .output: kAudioObjectPropertyScopeOutput // "outp"
        case .playThrough: kAudioObjectPropertyScopePlayThrough // "ptru"
        }
    }
}

extension AudioObjectPropertyScopeConstant: CustomStringConvertible {
    nonisolated
    public var description: String {
        switch self {
        // MARK: CoreAudio/AudioHardwareBase.h

        case .global: "Global"
        case .input: "Input"
        case .output: "Output"
        case .playThrough: "Play Through"
        }
    }
}

// MARK: - Static Constructors

extension AudioPropertyScopeConstant where Self == AudioObjectPropertyScopeConstant {
    /// Analogous to CoreAudio `kAudioObjectPropertyScope*` scope constants.
    public static func object(_ scope: Self) -> Self {
        scope
    }
}

#endif
