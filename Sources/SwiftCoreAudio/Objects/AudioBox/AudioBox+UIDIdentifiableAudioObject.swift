//
//  AudioBox+UIDIdentifiableAudioObject.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

extension AudioBox: UIDIdentifiableAudioObject {
    nonisolated
    public var uid: UID {
        get throws(SwiftCoreAudioError) {
            try boxUID
        }
    }
}

#endif
