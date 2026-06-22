//
//  AudioTap+UIDIdentifiableAudioObject.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

extension AudioTap: UIDIdentifiableAudioObject {
    nonisolated
    public var uid: UID {
        get throws(SwiftCoreAudioError) {
            try tapUID
        }
    }
}

#endif
