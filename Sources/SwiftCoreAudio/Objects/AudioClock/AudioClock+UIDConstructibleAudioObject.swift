//
//  AudioClock+UIDConstructibleAudioObject.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

extension AudioClock: UIDConstructibleAudioObject {
    nonisolated
    public init?(uid: UID) throws(SwiftCoreAudioError) {
        guard let clock = try AudioSystem.shared.clock(forUID: uid)
        else { return nil }

        self.init(id: clock.id.rawValue)
    }
}

#endif
