//
//  AudioObjectSnapshot BoxPropertyKey.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

extension AudioObjectSnapshot {
    /// Keys listed in the order they appear where their property getters are defined.
    public enum BoxPropertyKey: String {
        case boxUID
        case transportType
        case hasAudio
        case hasVideo
        case hasMIDI
        case isProtected
        case isEnabled
        // case acquisitionFailed -- omitted, only used after a call to acquire if acquisition fails
        case devices
        case clocks
    }
}

extension AudioObjectSnapshot.BoxPropertyKey: AudioObjectSnapshot.PropertyKey {
    public var asAnyPropertyKey: AudioObjectSnapshot.AnyPropertyKey {
        .box(self)
    }
}

extension AudioObjectSnapshot.BoxPropertyKey {
    public func getValue(of object: some AudioBoxProperties) -> String? {
        switch self {
        case .boxUID:
            withErrorCapture(key: self, try object.boxUID, transform: \.rawValue)
        case .transportType:
            withErrorCapture(key: self, try object.transportType, transform: \.rawValue.description)
        case .hasAudio:
            withErrorCapture(key: self, try object.hasAudio, transform: \.description)
        case .hasVideo:
            withErrorCapture(key: self, try object.hasVideo, transform: \.description)
        case .hasMIDI:
            withErrorCapture(key: self, try object.hasMIDI, transform: \.description)
        case .isProtected:
            withErrorCapture(key: self, try object.isProtected, transform: \.description)
        case .isEnabled:
            withErrorCapture(key: self, try object.isEnabled, transform: \.description)
        case .devices:
            withErrorCapture(key: self, try object.devices, transform: {
                let string = $0
                    .map(\.asAnyAudioObject.id.rawValue)
                    .map(String.init)
                    .joined(separator: ", ")
                return string.isEmpty ? nil : string
            })
        case .clocks:
            withErrorCapture(key: self, try object.clocks, transform: {
                let string = $0
                    .map(\.asAnyAudioObject.id.rawValue)
                    .map(String.init)
                    .joined(separator: ", ")
                return string.isEmpty ? nil : string
            })
        }
    }
}

#endif
