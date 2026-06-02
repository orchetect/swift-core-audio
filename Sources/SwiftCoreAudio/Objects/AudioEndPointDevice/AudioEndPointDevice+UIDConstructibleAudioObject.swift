//
//  AudioEndPointDevice+UIDConstructibleAudioObject.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

extension AudioEndPointDevice: UIDConstructibleAudioObject {
    nonisolated
    public init?(uid: UID) throws(SwiftCoreAudioError) {
        guard let device = try AudioSystem.shared.device(forUID: uid)
        else { return nil }
        
        self = device
    }
}

#endif
