//
//  AudioSubDevice+UIDIdentifiableAudioObject.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

extension AudioSubDevice: UIDIdentifiableAudioObject {
    nonisolated
    public var uid: UID {
        get throws(SwiftCoreAudioError) {
            // assuming we don't want to conform `Self` to AudioDeviceProperties since not all of
            // its properties are applicable to a sub-device, defer to AudioDevice for this property.
            let string = try AudioDevice(id: id.rawValue).deviceUID.rawValue
            return UID(rawValue: string)
        }
    }
}

#endif
