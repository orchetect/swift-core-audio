//
//  AudioWildcardPropertyElementConstant.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

// MARK: CoreAudio/AudioHardwareBase.h

/// The wildcard value for `AudioObjectPropertyElement`s.
///
/// Wildcards match any and all values for their associated type. They are useful when registering
/// to receive notifications.
///
/// > File: CoreAudio/AudioHardwareBase.h
///
/// > Constant: `kAudioObjectPropertyElementWildcard`
public struct AudioWildcardPropertyElementConstant {
    public init() { }
}

extension AudioWildcardPropertyElementConstant: AudioPropertyElementConstant { }

extension AudioWildcardPropertyElementConstant: Equatable { }

extension AudioWildcardPropertyElementConstant: Hashable { }

extension AudioWildcardPropertyElementConstant: Sendable { }

extension AudioWildcardPropertyElementConstant: RawRepresentable {
    nonisolated
    public init?(rawValue: UInt32) {
        guard rawValue == self.rawValue else { return nil }
    }

    nonisolated
    public var rawValue: UInt32 {
        kAudioObjectPropertyElementWildcard // 0xFFFFFFFF
    }
}

extension AudioWildcardPropertyElementConstant: CustomStringConvertible {
    nonisolated
    public var description: String {
        "Wildcard"
    }
}

// MARK: - Static Constructors

extension AudioPropertyElementConstant where Self == AudioWildcardPropertyElementConstant {
    /// The wildcard value for `AudioObjectPropertyElement`s.
    ///
    /// Wildcards match any and all values for their associated type. They are useful when registering
    /// to receive notifications.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioObjectPropertyElementWildcard`
    public static var wildcard: Self {
        Self()
    }
}

#endif
