//
//  AudioSystem+AudioObject.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

extension AudioSystem: AudioObject {
    nonisolated
    public var id: ID {
        // `kAudioObjectSystemObject`:
        // The AudioObjectID that always refers to the one and only instance of the
        // AudioSystemObject class.
        
        ID(UInt32(kAudioObjectSystemObject))
    }
}

#endif
