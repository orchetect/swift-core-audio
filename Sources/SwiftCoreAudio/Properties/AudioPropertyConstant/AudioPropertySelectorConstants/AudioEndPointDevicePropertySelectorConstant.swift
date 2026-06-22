//
//  AudioEndPointDevicePropertySelectorConstant.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

/// Analogous to CoreAudio `kAudioEndPointDeviceProperty*` selector constants.
///
/// `AudioObjectPropertySelector` values provided by the `AudioEndPointDevice` class.
public enum AudioEndPointDevicePropertySelectorConstant {
    // MARK: CoreAudio/AudioHardwareBase.h

    /// Composition
    ///
    /// A `CFDictionary` that describes the composition of the `AudioEndPointDevice`.
    ///
    /// The caller is responsible for releasing the returned `CFObject`.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioEndPointDevicePropertyComposition`
    case composition

    /// EndPoint List
    ///
    /// An array of `AudioObjectID`s for all the `AudioEndPoint`s in the device.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioEndPointDevicePropertyEndPointList`
    case endPointList

    /// Is Private
    ///
    /// A non-zero value indicates the `pid_t` of the process that owns the device.
    /// A value of `0` indicates that the device is public.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioEndPointDevicePropertyIsPrivate`
    case isPrivate
}

extension AudioEndPointDevicePropertySelectorConstant: AudioPropertySelectorConstant { }

extension AudioEndPointDevicePropertySelectorConstant: Equatable { }

extension AudioEndPointDevicePropertySelectorConstant: Hashable { }

extension AudioEndPointDevicePropertySelectorConstant: CaseIterable { }

extension AudioEndPointDevicePropertySelectorConstant: Sendable { }

// MARK: - Inits

extension AudioEndPointDevicePropertySelectorConstant {
    /// Same as ``init(rawValue:)`` but throws an error instead of returning `nil` when a match is not found.
    nonisolated
    public init(tryingRawValue rawValue: FourCharCode) throws(SwiftCoreAudioError) { // a.k.a. UInt32
        guard let match = Self(rawValue: rawValue) else {
            throw .notYetImplemented(
                message: "Unhandled/unrecognized audio endpoint device property selector constant value: \(rawValue)"
            )
        }
        self = match
    }
}

// MARK: - RawRepresentable

extension AudioEndPointDevicePropertySelectorConstant: RawRepresentable {
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

        case .composition: kAudioEndPointDevicePropertyComposition // "acom"
        case .endPointList: kAudioEndPointDevicePropertyEndPointList // "agrp"
        case .isPrivate: kAudioEndPointDevicePropertyIsPrivate // "priv"
        }
    }
}

extension AudioEndPointDevicePropertySelectorConstant: CustomStringConvertible {
    nonisolated
    public var description: String {
        switch self {
        // MARK: CoreAudio/AudioHardwareBase.h

        case .composition: "Composition"
        case .endPointList: "EndPoint List"
        case .isPrivate: "Is Private"
        }
    }
}

// MARK: - Static Constructors

extension AudioPropertySelectorConstant where Self == AudioEndPointDevicePropertySelectorConstant {
    /// Analogous to CoreAudio `kAudioEndPointDeviceProperty*` selector constants.
    ///
    /// `AudioObjectPropertySelector` values provided by the `AudioEndPointDevice` class.
    public static func endPointDevice(_ selector: Self) -> Self {
        selector
    }
}

#endif
