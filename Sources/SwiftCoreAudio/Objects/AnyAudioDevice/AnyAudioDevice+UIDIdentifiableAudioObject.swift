//
//  AnyAudioDevice+UIDIdentifiableAudioObject.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

extension AnyAudioDevice: UIDIdentifiableAudioObject {
    public var uid: UID {
        get throws(SwiftCoreAudioError) {
            switch self {
            case let .device(device): try UID(device.uid.rawValue)
            case let .aggregate(aggregate): try UID(aggregate.uid.rawValue)
            }
        }
    }
}

#endif
