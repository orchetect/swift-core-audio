//
//  AudioObjectSnapshot ObjectPropertyKey.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

extension AudioObjectSnapshot {
    /// Keys listed in the order they appear where their property getters are defined.
    public enum ObjectPropertyKey: String {
        case baseClassID
        case classID
        case owner
        case name
        case modelName
        case manufacturer
        case ownedObjects
        case isIdentifying
        case serialNumber
        case firmwareVersion
        case creator
    }
}

extension AudioObjectSnapshot.ObjectPropertyKey: AudioObjectSnapshot.PropertyKey {
    public var asAnyPropertyKey: AudioObjectSnapshot.AnyPropertyKey {
        .object(self)
    }
}

extension AudioObjectSnapshot.ObjectPropertyKey {
    public func getValue(of object: some AudioObjectProperties) -> String? {
        // swiftformat:disable hoistTry
        switch self {
        case .baseClassID:
            withErrorCapture(key: self, try object.baseClassID, transform: \.rawValue.description)
        case .classID:
            withErrorCapture(key: self, try object.classID, transform: \.rawValue.description)
        case .owner:
            withErrorCapture(key: self, try object.owner, transform: \.asAnyAudioObject.id.rawValue.description)
        case .name:
            withErrorCapture(key: self, try object.name)
        case .modelName:
            withErrorCapture(key: self, try object.modelName)
        case .manufacturer:
            withErrorCapture(key: self, try object.manufacturer)
        case .ownedObjects:
            withErrorCapture(key: self, try object.ownedObjects, transform: {
                let string = $0
                    .map(\.asAnyAudioObject.id.rawValue)
                    .map(String.init)
                    .joined(separator: ", ")
                return string.isEmpty ? nil : string
            })
        case .isIdentifying:
            withErrorCapture(key: self, try object.isIdentifying.description)
        case .serialNumber:
            withErrorCapture(key: self, try object.serialNumber)
        case .firmwareVersion:
            withErrorCapture(key: self, try object.firmwareVersion)
        case .creator:
            withErrorCapture(key: self, try object.creator, transform: \.rawValue)
        }
        // swiftformat:enable hoistTry
    }
}

#endif
