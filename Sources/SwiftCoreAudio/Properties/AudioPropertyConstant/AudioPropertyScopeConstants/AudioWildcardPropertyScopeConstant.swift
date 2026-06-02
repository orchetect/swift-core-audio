//
//  AudioWildcardPropertyScopeConstant.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

// MARK: CoreAudio/AudioHardwareBase.h

/// The wildcard value for `AudioObjectPropertyScope`s.
///
/// Wildcards match any and all values for their associated type. They are useful when registering
/// to receive notifications.
///
/// > File: CoreAudio/AudioHardwareBase.h
///
/// > Constant: `kAudioObjectPropertyScopeWildcard`
public struct AudioWildcardPropertyScopeConstant {
    public init() { }
}

extension AudioWildcardPropertyScopeConstant: AudioPropertyScopeConstant { }

extension AudioWildcardPropertyScopeConstant: Equatable { }

extension AudioWildcardPropertyScopeConstant: Hashable { }

extension AudioWildcardPropertyScopeConstant: Sendable { }

extension AudioWildcardPropertyScopeConstant: RawRepresentable {
    nonisolated
    public init?(rawValue: FourCharCode) { // a.k.a. UInt32
        guard rawValue == self.rawValue else { return nil }
    }
    
    nonisolated
    public var rawValue: FourCharCode { // a.k.a. UInt32
        kAudioObjectPropertyScopeWildcard // "****"
    }
}

extension AudioWildcardPropertyScopeConstant: CustomStringConvertible {
    nonisolated
    public var description: String {
        "Wildcard"
    }
}

// MARK: - Static Constructors

extension AudioPropertyScopeConstant where Self == AudioWildcardPropertyScopeConstant {
    /// The wildcard value for `AudioObjectPropertyScope`s.
    ///
    /// Wildcards match any and all values for their associated type. They are useful when registering
    /// to receive notifications.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioObjectPropertyScopeWildcard`
    public static var wildcard: AudioWildcardPropertyScopeConstant {
        Self()
    }
}

#endif
