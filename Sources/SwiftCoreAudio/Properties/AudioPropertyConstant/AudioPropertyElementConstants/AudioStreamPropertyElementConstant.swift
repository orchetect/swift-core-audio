//
//  AudioStreamPropertyElementConstant.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

/// Core Audio audio stream element constants.
public enum AudioStreamPropertyElementConstant {
    // MARK: CoreAudio/AudioHardwareBase.h
    
    /// Stream channel number (1-based).
    ///
    /// Channel numbers are 1:1 with user-facing channel numbers (starting from channel 1, then 2,
    /// etc...), not to be confused with channel index (zero-based).
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: None. Channel number integer is used in-place of a constant.
    case channelNumber(Int)
}

extension AudioStreamPropertyElementConstant: AudioPropertyElementConstant { }

extension AudioStreamPropertyElementConstant: Equatable { }

extension AudioStreamPropertyElementConstant: Hashable { }

extension AudioStreamPropertyElementConstant: Sendable { }

// MARK: - RawRepresentable

extension AudioStreamPropertyElementConstant: RawRepresentable {
    nonisolated
    public init?(rawValue: UInt32) {
        // The only case we have is channel number, so just use that
        self = .channelNumber(Int(rawValue))
    }
    
    nonisolated
    public var rawValue: UInt32 {
        switch self {
        // MARK: CoreAudio/AudioHardwareBase.h
        case let .channelNumber(chan): AudioObjectPropertyElement(chan)
        }
    }
}

extension AudioStreamPropertyElementConstant: CustomStringConvertible {
    nonisolated
    public var description: String {
        switch self {
        // MARK: CoreAudio/AudioHardwareBase.h
        case let .channelNumber(chan): "Channel #\(chan)"
        }
    }
}

// MARK: - Static Constructors

extension AudioPropertyElementConstant where Self == AudioStreamPropertyElementConstant {
    /// Core Audio audio stream element constants.
    public static func stream(_ element: Self) -> Self {
        element
    }
}

#endif
