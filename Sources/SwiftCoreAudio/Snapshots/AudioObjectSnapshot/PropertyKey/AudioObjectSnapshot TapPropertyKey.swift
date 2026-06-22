//
//  AudioObjectSnapshot TapPropertyKey.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

extension AudioObjectSnapshot {
    /// Keys listed in the order they appear where their property getters are defined.
    public enum TapPropertyKey: String {
        case tapUID
        case tapDescription
        case format
    }
}

extension AudioObjectSnapshot.TapPropertyKey: AudioObjectSnapshot.PropertyKey {
    public var asAnyPropertyKey: AudioObjectSnapshot.AnyPropertyKey {
        .tap(self)
    }
}

extension AudioObjectSnapshot.TapPropertyKey {
    public func getValue(of object: some AudioTapProperties) -> String? {
        // swiftformat:disable hoistTry
        switch self {
        case .tapUID:
            withErrorCapture(key: self, try object.tapUID, transform: \.rawValue)
        case .tapDescription:
            if #available(macOS 12.0, macCatalyst 15.0, *) {
                // TODO: may need custom serialization
                withErrorCapture(key: self, try object.tapDescription, transform: \.description)
            } else { nil }
        case .format:
            // TODO: may need custom serialization
            withErrorCapture(key: self, try object.format, transform: \.description)
        }
        // swiftformat:enable hoistTry
    }
}

#endif
