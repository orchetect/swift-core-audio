//
//  AudioWildcardPropertySelectorConstant.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

// MARK: CoreAudio/AudioHardwareBase.h

/// The wildcard value for `AudioObjectPropertySelector`s.
///
/// Wildcards match any and all values for their associated type. They are useful when registering
/// to receive notifications.
///
/// > File: CoreAudio/AudioHardwareBase.h
///
/// > Constant: `kAudioObjectPropertySelectorWildcard`
public struct AudioWildcardPropertySelectorConstant {
    public init() { }
}

extension AudioWildcardPropertySelectorConstant: AudioPropertySelectorConstant { }

extension AudioWildcardPropertySelectorConstant: Equatable { }

extension AudioWildcardPropertySelectorConstant: Hashable { }

extension AudioWildcardPropertySelectorConstant: Sendable { }

extension AudioWildcardPropertySelectorConstant: RawRepresentable {
    nonisolated
    public init?(rawValue: FourCharCode) { // a.k.a. UInt32
        guard rawValue == self.rawValue else { return nil }
    }
    
    nonisolated
    public var rawValue: FourCharCode { // a.k.a. UInt32
        kAudioObjectPropertySelectorWildcard // "****"
    }
}

extension AudioWildcardPropertySelectorConstant: CustomStringConvertible {
    nonisolated
    public var description: String {
        "Wildcard"
    }
}

// MARK: - Static Constructors

extension AudioPropertySelectorConstant where Self == AudioWildcardPropertySelectorConstant {
    /// The wildcard value for `AudioObjectPropertySelector`s.
    ///
    /// Wildcards match any and all values for their associated type. They are useful when registering
    /// to receive notifications.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioObjectPropertySelectorWildcard`
    public static var wildcard: Self {
        Self()
    }
}

#endif
