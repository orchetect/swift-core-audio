//
//  AudioTap+UIDConstructibleAudioObject.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

extension AudioTap: UIDConstructibleAudioObject {
    nonisolated
    public init?(uid: UID) throws(SwiftCoreAudioError) {
        guard let tap = try AudioSystem.shared.tap(forUID: uid)
        else { return nil }

        self.init(id: tap.id.rawValue)
    }
}

#endif
