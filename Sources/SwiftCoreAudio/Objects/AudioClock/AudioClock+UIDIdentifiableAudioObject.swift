//
//  AudioClock+UIDIdentifiableAudioObject.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

extension AudioClock: UIDIdentifiableAudioObject {
    nonisolated
    public var uid: UID {
        get throws(SwiftCoreAudioError) {
            try deviceUID
        }
    }
}

#endif
