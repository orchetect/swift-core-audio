//
//  AudioBoxPropertySelectorConstant.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

/// Analogous to CoreAudio `kAudioBoxProperty*` selector constants.
///
/// `AudioObjectPropertySelector` values provided by the `AudioBox` class.
public enum AudioBoxPropertySelectorConstant {
    // MARK: CoreAudio/AudioHardwareBase.h
    
    /// A `CFString` that contains a persistent identifier for the `AudioBox`.
    ///
    /// An AudioBox's UID is persistent across boots. The content of the UID string is a
    /// black box and may contain information that is unique to a particular instance of an
    /// `AudioBox`'s hardware or unique to the CPU. Therefore they are not suitable for passing
    /// between CPUs or for identifying similar models of hardware.
    ///
    /// The caller is responsible for releasing the returned `CFObject`.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioBoxPropertyBoxUID`
    case boxUID
    
    /// A `UInt32` whose value indicates how the `AudioBox` is connected to the system.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioBoxPropertyTransportType`
    case transportType
    
    /// A `UInt32` where a non-zero value indicates that the box supports audio.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioBoxPropertyHasAudio`
    case hasAudio
    
    /// A `UInt32` where a non-zero value indicates that the box supports video.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioBoxPropertyHasVideo`
    case hasVideo
    
    /// A `UInt32` where a non-zero value indicates that the box supports MIDI.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioBoxPropertyHasMIDI`
    case hasMIDI
    
    /// A `UInt32` where a non-zero value indicates that the box requires authentication to use.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioBoxPropertyIsProtected`
    case isProtected
    
    /// A UInt32 where a non-zero value indicates that the box's contents are available to the system.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioBoxPropertyAcquired`
    case acquired
    
    /// An `OSStatus` that indicates the reason for an attempt to acquire a box failed.
    /// Note that this property is primarily used for notifications.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioBoxPropertyAcquisitionFailed`
    case acquisitionFailed
    
    /// An array of `AudioObjectID`s that represent all the `AudioDevice` objects that
    /// came out of the given `AudioBox`.
    ///
    /// Note that until a box is enabled, this list will be empty.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioBoxPropertyDeviceList`
    case deviceList
    
    /// An array of `AudioObjectID`s that represent all the `AudioClockDevice` objects that
    /// came out of the given `AudioBox`.
    ///
    /// Note that until a box is enabled, this list will be empty.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioBoxPropertyClockDeviceList`
    case clockDeviceList
}

extension AudioBoxPropertySelectorConstant: AudioPropertySelectorConstant { }

extension AudioBoxPropertySelectorConstant: Equatable { }

extension AudioBoxPropertySelectorConstant: Hashable { }

extension AudioBoxPropertySelectorConstant: CaseIterable { }

extension AudioBoxPropertySelectorConstant: Sendable { }

// MARK: - Inits

extension AudioBoxPropertySelectorConstant {
    /// Same as ``init(rawValue:)`` but throws an error instead of returning `nil` when a match is not found.
    nonisolated
    public init(tryingRawValue rawValue: FourCharCode) throws(SwiftCoreAudioError) { // a.k.a. UInt32
        guard let match = Self(rawValue: rawValue) else {
            throw .notYetImplemented(
                message: "Unhandled/unrecognized audio box property selector constant value: \(rawValue)"
            )
        }
        self = match
    }
}

// MARK: - RawRepresentable

extension AudioBoxPropertySelectorConstant: RawRepresentable {
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
        case .boxUID: kAudioBoxPropertyBoxUID // "buid"
        case .transportType: kAudioBoxPropertyTransportType // "tran"
        case .hasAudio: kAudioBoxPropertyHasAudio // "bhau"
        case .hasVideo: kAudioBoxPropertyHasVideo // "bhvi"
        case .hasMIDI: kAudioBoxPropertyHasMIDI // "bhmi"
        case .isProtected: kAudioBoxPropertyIsProtected // "bpro"
        case .acquired: kAudioBoxPropertyAcquired // "bxon"
        case .acquisitionFailed: kAudioBoxPropertyAcquisitionFailed // "bxof"
        case .deviceList: kAudioBoxPropertyDeviceList // "bdv#"
        case .clockDeviceList: kAudioBoxPropertyClockDeviceList // "bcl#"
        }
    }
}

extension AudioBoxPropertySelectorConstant: CustomStringConvertible {
    nonisolated
    public var description: String {
        switch self {
        // MARK: CoreAudio/AudioHardwareBase.h
        case .boxUID: "Box UID"
        case .transportType: "Transport Type"
        case .hasAudio: "Has Audio"
        case .hasVideo: "Has Video"
        case .hasMIDI: "Has MIDI"
        case .isProtected: "Is Protected"
        case .acquired: "Acquired"
        case .acquisitionFailed: "Acquisition Failed"
        case .deviceList: "Device List"
        case .clockDeviceList: "Clock Device List"
        }
    }
}

// MARK: - Static Constructors

extension AudioPropertySelectorConstant where Self == AudioBoxPropertySelectorConstant {
    /// Analogous to CoreAudio `kAudioBoxProperty*` selector constants.
    ///
    /// `AudioObjectPropertySelector` values provided by the `AudioBox` class.
    public static func box(_ selector: Self) -> Self {
        selector
    }
}

#endif
