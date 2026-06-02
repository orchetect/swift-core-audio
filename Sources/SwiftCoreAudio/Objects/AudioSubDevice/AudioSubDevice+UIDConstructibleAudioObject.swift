//
//  AudioSubDevice+UIDConstructibleAudioObject.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

extension AudioSubDevice: UIDConstructibleAudioObject {
    nonisolated
    public init?(uid: UID) throws(SwiftCoreAudioError) {
        // defer to AudioDevice lookup
        guard let device = try AudioSystem.shared
            .device(forUID: AudioDevice.UID(uid.rawValue)) // re-wrap UID
        else { return nil }
        
        self.init(id: device.id.rawValue)
    }
}

#endif
