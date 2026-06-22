//
//  AudioProcessPropertySelectorConstant.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

/// Analogous to CoreAudio `kAudioProcessProperty*` selector constants.
///
/// `AudioObjectPropertySelector` values provided by the `AudioProcess` class.
public enum AudioProcessPropertySelectorConstant {
    // MARK: CoreAudio/AudioHardware.h

    /// Process ID (PID)
    ///
    /// A `pid_t` indicating the process ID associated with the process.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioProcessPropertyPID`
    case pid

    /// Bundle ID
    ///
    /// A `CFString` that contains the bundle ID of the process.
    ///
    /// The caller is responsible for releasing the returned `CFObject`.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioProcessPropertyBundleID`
    case bundleID

    /// Devices
    ///
    /// An array of `AudioObjectID`s that represent the devices currently used by the
    /// process for input and/or output.
    ///
    /// The scope will select the input or output device list.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioProcessPropertyDevices`
    case devices

    /// Is Running
    ///
    /// A `UInt32` where a value of `0` indicates that there is not audio IO in progress
    /// in the process, and a value of `1` indicates that there is audio IO in progress
    /// in the process. Note that audio IO may in progress even if no input or output
    /// streams are active.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioProcessPropertyIsRunning`
    case isRunning

    /// Is Running Input
    ///
    /// A `UInt32` where a value of `0` indicates that the process is not running any
    /// IO or there is not any active input streams, and a value of `1` indicates that
    /// the process is running IO and there is at least one active input stream.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioProcessPropertyIsRunningInput`
    case isRunningInput

    /// Is Running Output
    ///
    /// A `UInt32` where a value of `0` indicates that the process is not running any
    /// IO or there is not any active output streams, and a value of `1` indicates that
    /// the process is running IO and there is at least one active output stream.
    ///
    /// > File: CoreAudio/AudioHardware.h
    ///
    /// > Constant: `kAudioProcessPropertyIsRunningOutput`
    case isRunningOutput
}

extension AudioProcessPropertySelectorConstant: AudioPropertySelectorConstant { }

extension AudioProcessPropertySelectorConstant: Equatable { }

extension AudioProcessPropertySelectorConstant: Hashable { }

extension AudioProcessPropertySelectorConstant: CaseIterable { }

extension AudioProcessPropertySelectorConstant: Sendable { }

// MARK: - Inits

extension AudioProcessPropertySelectorConstant {
    /// Same as ``init(rawValue:)`` but throws an error instead of returning `nil` when a match is not found.
    nonisolated
    public init(tryingRawValue rawValue: FourCharCode) throws(SwiftCoreAudioError) { // a.k.a. UInt32
        guard let match = Self(rawValue: rawValue) else {
            throw .notYetImplemented(
                message: "Unhandled/unrecognized audio process property selector constant value: \(rawValue)"
            )
        }
        self = match
    }
}

// MARK: - RawRepresentable

extension AudioProcessPropertySelectorConstant: RawRepresentable {
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

        case .pid: kAudioProcessPropertyPID // "ppid"
        case .bundleID: kAudioProcessPropertyBundleID // "pbid"
        case .devices: kAudioProcessPropertyDevices // "pdv#"
        case .isRunning: kAudioProcessPropertyIsRunning // "pir?"
        case .isRunningInput: kAudioProcessPropertyIsRunningInput // "piri"
        case .isRunningOutput: kAudioProcessPropertyIsRunningOutput // "piro"
        }
    }
}

extension AudioProcessPropertySelectorConstant: CustomStringConvertible {
    nonisolated
    public var description: String {
        switch self {
        // MARK: CoreAudio/AudioHardware.h

        case .pid: "PID"
        case .bundleID: "Bundle ID"
        case .devices: "Devices"
        case .isRunning: "Is Running"
        case .isRunningInput: "Is Running Input"
        case .isRunningOutput: "Is Running Output"
        }
    }
}

// MARK: - Static Constructors

extension AudioPropertySelectorConstant where Self == AudioProcessPropertySelectorConstant {
    /// Analogous to CoreAudio `kAudioProcessProperty*` selector constants.
    ///
    /// `AudioObjectPropertySelector` values provided by the `AudioProcess` class.
    public static func process(_ selector: Self) -> Self {
        selector
    }
}

#endif
