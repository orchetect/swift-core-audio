//
//  AudioStream TerminalType.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import Foundation

extension AudioStream {
    /// Audio stream terminal types.
    ///
    /// CoreAudio `kAudioStreamTerminalType*` constants.
    public enum TerminalType {
        // MARK: CoreAudio/AudioHardwareBase.h
        
        /// Unknown
        ///
        /// The ID used when the terminal type for the `AudioStream` is non known.
        ///
        /// > File: CoreAudio/AudioHardwareBase.h
        ///
        /// > Constant: `kAudioStreamTerminalTypeUnknown`
        case unknown
        
        /// Line
        ///
        /// The ID for a terminal type of a line level stream. Note that this applies to
        /// both input streams and output streams.
        ///
        /// > File: CoreAudio/AudioHardwareBase.h
        ///
        /// > Constant: `kAudioStreamTerminalTypeLine`
        case line
        
        /// Digital Audio Interface
        ///
        /// The ID for a terminal type of stream from/to a digital audio interface as
        /// defined by ISO 60958 (aka SPDIF or AES/EBU). Note that this applies to both
        /// input streams and output streams.
        ///
        /// > File: CoreAudio/AudioHardwareBase.h
        ///
        /// > Constant: `kAudioStreamTerminalTypeDigitalAudioInterface`
        case digitalAudioInterface
        
        /// Speaker
        ///
        /// The ID for a terminal type of a speaker.
        ///
        /// > File: CoreAudio/AudioHardwareBase.h
        ///
        /// > Constant: `kAudioStreamTerminalTypeSpeaker`
        case speaker
        
        /// Headphones
        ///
        /// The ID for a terminal type of headphones.
        ///
        /// > File: CoreAudio/AudioHardwareBase.h
        ///
        /// > Constant: `kAudioStreamTerminalTypeHeadphones`
        case headphones
        
        /// LFE Speaker
        ///
        /// The ID for a terminal type of a speaker for low frequency effects.
        ///
        /// > File: CoreAudio/AudioHardwareBase.h
        ///
        /// > Constant: `kAudioStreamTerminalTypeLFESpeaker`
        case lfeSpeaker
        
        /// Receiver Speaker
        ///
        /// The ID for a terminal type of a speaker on a telephone handset receiver.
        ///
        /// > File: CoreAudio/AudioHardwareBase.h
        ///
        /// > Constant: `kAudioStreamTerminalTypeReceiverSpeaker`
        case receiverSpeaker
        
        /// Microphone
        ///
        /// The ID for a terminal type of a microphone.
        ///
        /// > File: CoreAudio/AudioHardwareBase.h
        ///
        /// > Constant: `kAudioStreamTerminalTypeMicrophone`
        case microphone
        
        /// Headset Microphone
        ///
        /// The ID for a terminal type of a microphone attached to an headset.
        ///
        /// > File: CoreAudio/AudioHardwareBase.h
        ///
        /// > Constant: `kAudioStreamTerminalTypeHeadsetMicrophone`
        case headsetMicrophone
        
        /// Receiver Microphone
        ///
        /// The ID for a terminal type of a microphone on a telephone handset receiver.
        ///
        /// > File: CoreAudio/AudioHardwareBase.h
        ///
        /// > Constant: `kAudioStreamTerminalTypeReceiverMicrophone`
        case receiverMicrophone
        
        /// TTY
        ///
        /// The ID for a terminal type of a device providing a TTY signal.
        ///
        /// > File: CoreAudio/AudioHardwareBase.h
        ///
        /// > Constant: `kAudioStreamTerminalTypeTTY`
        case tty
        
        /// HDMI
        ///
        /// The ID for a terminal type of a stream from/to an HDMI port.
        ///
        /// > File: CoreAudio/AudioHardwareBase.h
        ///
        /// > Constant: `kAudioStreamTerminalTypeHDMI`
        case hdmi
        
        /// DisplayPort
        ///
        /// The ID for a terminal type of a stream from/to an DisplayPort port.
        ///
        /// > File: CoreAudio/AudioHardwareBase.h
        ///
        /// > Constant: `kAudioStreamTerminalTypeDisplayPort`
        case displayPort
    }
}

// MARK: - Inits

extension AudioStream.TerminalType {
    /// Same as ``init(rawValue:)`` but throws an error instead of returning `nil` when a match is not found.
    nonisolated
    public init(tryingRawValue rawValue: FourCharCode) throws(SwiftCoreAudioError) { // a.k.a. UInt32
        guard let match = Self(rawValue: rawValue) else {
            throw .notYetImplemented(message: "Unhandled/unrecognized audio stream terminal type value: \(rawValue)")
        }
        self = match
    }
}

// MARK: - RawRepresentable

extension AudioStream.TerminalType: Equatable { }

extension AudioStream.TerminalType: Hashable { }

extension AudioStream.TerminalType: CaseIterable { }

extension AudioStream.TerminalType: Sendable { }

extension AudioStream.TerminalType: RawRepresentable {
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
        case .unknown: kAudioStreamTerminalTypeUnknown // 0
        case .line: kAudioStreamTerminalTypeLine // "line"
        case .digitalAudioInterface: kAudioStreamTerminalTypeDigitalAudioInterface // "spdf"
        case .speaker: kAudioStreamTerminalTypeSpeaker // "spkr"
        case .headphones: kAudioStreamTerminalTypeHeadphones // "hdph"
        case .lfeSpeaker: kAudioStreamTerminalTypeLFESpeaker // "lfes"
        case .receiverSpeaker: kAudioStreamTerminalTypeReceiverSpeaker // "rspk"
        case .microphone: kAudioStreamTerminalTypeMicrophone // "micr"
        case .headsetMicrophone: kAudioStreamTerminalTypeHeadsetMicrophone // "hmic"
        case .receiverMicrophone: kAudioStreamTerminalTypeReceiverMicrophone // "rmic"
        case .tty: kAudioStreamTerminalTypeTTY // "tty_"
        case .hdmi: kAudioStreamTerminalTypeHDMI // "hdmi"
        case .displayPort: kAudioStreamTerminalTypeDisplayPort // "dprt"
        }
    }
}

extension AudioStream.TerminalType: CustomStringConvertible {
    nonisolated
    public var description: String {
        switch self {
        // MARK: CoreAudio/AudioHardwareBase.h
        case .unknown: "Unknown"
        case .line: "Line"
        case .digitalAudioInterface: "Digital Audio Interface"
        case .speaker: "Speaker"
        case .headphones: "Headphones"
        case .lfeSpeaker: "LFE Speaker"
        case .receiverSpeaker: "Receiver Speaker"
        case .microphone: "Microphone"
        case .headsetMicrophone: "Headset Microphone"
        case .receiverMicrophone: "Receiver Microphone"
        case .tty: "TTY"
        case .hdmi: "HDMI"
        case .displayPort: "DisplayPort"
        }
    }
}

#endif
