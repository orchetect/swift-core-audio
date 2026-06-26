//
//  AudioID+Properties.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

extension AudioID {
    /// Returns the audio object ID type-erased as an `AnyAudioObject.ID` instance.
    nonisolated
    public var asAnyAudioObjectID: AnyAudioObject.ID {
        AnyAudioObject.ID(rawValue)
    }
}

#endif
