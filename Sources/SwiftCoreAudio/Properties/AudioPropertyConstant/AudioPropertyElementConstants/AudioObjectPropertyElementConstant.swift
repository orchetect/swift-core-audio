//
//  AudioObjectPropertyElementConstant.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

/// Analogous to CoreAudio `kAudioObjectPropertyElement*` element constants.
public enum AudioObjectPropertyElementConstant {
    // MARK: CoreAudio/AudioHardwareBase.h

    /// Main element.
    ///
    /// The `AudioObjectPropertyElement` value for properties that apply to the main element or to the entire scope.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioObjectPropertyElementMain`, formerly `kAudioObjectPropertyElementMaster`
    case main
}

extension AudioObjectPropertyElementConstant: AudioPropertyElementConstant { }

extension AudioObjectPropertyElementConstant: Equatable { }

extension AudioObjectPropertyElementConstant: Hashable { }

extension AudioObjectPropertyElementConstant: CaseIterable { }

extension AudioObjectPropertyElementConstant: Sendable { }

// MARK: - Inits

extension AudioObjectPropertyElementConstant {
    /// Same as ``init(rawValue:)`` but throws an error instead of returning `nil` when a match is not found.
    nonisolated
    public init(tryingRawValue rawValue: UInt32) throws(SwiftCoreAudioError) {
        guard let match = Self(rawValue: rawValue) else {
            throw .notYetImplemented(
                message: "Unhandled/unrecognized audio object property element constant value: \(rawValue)"
            )
        }
        self = match
    }
}

// MARK: - RawRepresentable

extension AudioObjectPropertyElementConstant: RawRepresentable {
    nonisolated
    public init?(rawValue: UInt32) {
        guard let match = Self.allCases
            .first(where: { $0.rawValue == rawValue })
        else {
            return nil
        }
        self = match
    }

    nonisolated
    public var rawValue: UInt32 {
        switch self {
        // MARK: CoreAudio/AudioHardwareBase.h

        case .main: kAudioObjectPropertyElementMain // 0
        }
    }
}

extension AudioObjectPropertyElementConstant: CustomStringConvertible {
    nonisolated
    public var description: String {
        switch self {
        // MARK: CoreAudio/AudioHardwareBase.h

        case .main: "Main"
        }
    }
}

// MARK: - Static Constructors

extension AudioPropertyElementConstant where Self == AudioObjectPropertyElementConstant {
    /// Analogous to CoreAudio `kAudioObjectPropertyElement*` element constants.
    public static func object(_ element: Self) -> Self {
        element
    }
}

#endif
