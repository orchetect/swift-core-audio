//
//  AudioID+Static.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

extension AudioID {
    /// Unknown object.
    ///
    /// This is the sentinel value. No object will have an ID whose value is `0`.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioObjectUnknown`
    nonisolated
    public static var unknown: Self {
        Self(kAudioObjectUnknown)
    }
}

#endif
