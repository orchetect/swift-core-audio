//
//  AnyAudioDevice+AudioObjectProperties.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

extension AnyAudioDevice: AudioObjectProperties {
    public var id: ID {
        switch self {
        case let .device(device): ID(device.id.rawValue)
        case let .aggregate(aggregate): ID(aggregate.id.rawValue)
        }
    }
}

#endif
