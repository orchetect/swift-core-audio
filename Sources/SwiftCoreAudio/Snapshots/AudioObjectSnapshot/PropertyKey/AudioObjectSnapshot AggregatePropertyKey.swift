//
//  AudioObjectSnapshot AggregatePropertyKey.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

extension AudioObjectSnapshot {
    /// Keys listed in the order they appear where their property getters are defined.
    public enum AggregatePropertyKey: String {
        case subdeviceUIDs
        case activeSubdevices
        case composition
        case mainSubdeviceUID
        case clockDeviceUID
        case subtapUIDs
        case activeSubtaps
    }
}

extension AudioObjectSnapshot.AggregatePropertyKey: AudioObjectSnapshot.PropertyKey {
    public var asAnyPropertyKey: AudioObjectSnapshot.AnyPropertyKey {
        .aggregate(self)
    }
}

extension AudioObjectSnapshot.AggregatePropertyKey {
    public func getValue(of object: some AudioAggregateDeviceProperties) -> String? {
        // swiftformat:disable hoistTry
        switch self {
        case .subdeviceUIDs:
            withErrorCapture(key: self, try object.subdeviceUIDs, transform: {
                let string = $0
                    .map(\.rawValue)
                    .joined(separator: ", ")
                return string.isEmpty ? nil : string
            })
        case .activeSubdevices:
            withErrorCapture(key: self, try object.activeSubdevices, transform: {
                let string = $0
                    .map(\.asAnyAudioObject.id.rawValue)
                    .map(String.init)
                    .joined(separator: ", ")
                return string.isEmpty ? nil : string
            })
        case .composition:
            withErrorCapture(key: self, try object.composition, transform: {
                "["
                + $0.dictionary()
                    .sorted { $0.key < $1.key }
                    .map { key, value in "\(key): \(value)" }
                    .joined(separator: ", ")
                + "]"
            })
        case .mainSubdeviceUID:
            withErrorCapture(key: self, try object.mainSubdeviceUID, transform: \.rawValue)
        case .clockDeviceUID:
            withErrorCapture(key: self, try object.clockDeviceUID, transform: \.rawValue)
        case .subtapUIDs:
            withErrorCapture(key: self, try object.tapUIDs, transform: {
                let string = $0
                    .map(\.rawValue)
                    .joined(separator: ", ")
                return string.isEmpty ? nil : string
            })
        case .activeSubtaps:
            withErrorCapture(key: self, try object.activeSubtaps, transform: {
                let string = $0
                    .map(\.asAnyAudioObject.id.rawValue)
                    .map(String.init)
                    .joined(separator: ", ")
                return string.isEmpty ? nil : string
            })
        }
        // swiftformat:enable hoistTry
    }
}

#endif
