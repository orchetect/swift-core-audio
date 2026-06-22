//
//  AudioObjectSnapshot AnyPropertyKey.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

extension AudioObjectSnapshot {
    /// Audio object property keys organized by class type.
    public enum AnyPropertyKey {
        case system(SystemPropertyKey)
        case object(ObjectPropertyKey)
        case box(BoxPropertyKey)
        case clock(ClockPropertyKey)
        case device(DevicePropertyKey)
        case aggregate(AggregatePropertyKey)
        case tap(TapPropertyKey)
        case process(ProcessPropertyKey)
        case plugin(PlugInPropertyKey)
        case transportManager(TransportManagerPropertyKey)
        case subTap(SubTapPropertyKey)
        case subDevice(SubDevicePropertyKey)
        // TODO: add additional key collections as they are implemented
    }
}

extension AudioObjectSnapshot.AnyPropertyKey: Equatable { }

extension AudioObjectSnapshot.AnyPropertyKey: Hashable { }

extension AudioObjectSnapshot.AnyPropertyKey: Sendable { }

extension AudioObjectSnapshot.AnyPropertyKey: CaseIterable {
    public static var allCases: [AudioObjectSnapshot.AnyPropertyKey] {
        // swiftformat:disable preferKeyPath
        allKeyTypes.flatMap { $0.allCasesAsAnyPropertyKeys }
        // swiftformat:enable preferKeyPath
    }

    public static var allKeyTypes: [any AudioObjectSnapshot.PropertyKey.Type] {
        [
            AudioObjectSnapshot.SystemPropertyKey.self,
            AudioObjectSnapshot.ObjectPropertyKey.self,
            AudioObjectSnapshot.BoxPropertyKey.self,
            AudioObjectSnapshot.ClockPropertyKey.self,
            AudioObjectSnapshot.DevicePropertyKey.self,
            AudioObjectSnapshot.AggregatePropertyKey.self,
            AudioObjectSnapshot.TapPropertyKey.self,
            AudioObjectSnapshot.ProcessPropertyKey.self,
            AudioObjectSnapshot.PlugInPropertyKey.self,
            AudioObjectSnapshot.TransportManagerPropertyKey.self,
            AudioObjectSnapshot.SubTapPropertyKey.self,
            AudioObjectSnapshot.SubDevicePropertyKey.self
            // TODO: add additional key collections as they are implemented
        ]
    }
}

extension AudioObjectSnapshot.AnyPropertyKey: RawRepresentable {
    public init?(rawValue: String) {
        for keyType in Self.allKeyTypes {
            if let key = keyType.init(rawValue: rawValue) {
                self = key.asAnyPropertyKey
                return
            }
        }
        return nil
    }

    public var rawValue: String {
        switch self {
        case let .system(key): key.rawValue
        case let .object(key): key.rawValue
        case let .box(key): key.rawValue
        case let .clock(key): key.rawValue
        case let .device(key): key.rawValue
        case let .aggregate(key): key.rawValue
        case let .tap(key): key.rawValue
        case let .process(key): key.rawValue
        case let .plugin(key): key.rawValue
        case let .transportManager(key): key.rawValue
        case let .subTap(key): key.rawValue
        case let .subDevice(key): key.rawValue
        }
    }
}

extension AudioObjectSnapshot.AnyPropertyKey: Codable {
    public init(from decoder: any Decoder) throws {
        // decode as if Self was a flat list of keys, with the assumption that all possible keys are unique
        guard let rawValue = try? decoder.singleValueContainer().decode(String.self) else {
            throw DecodingError.dataCorrupted(
                DecodingError.Context(codingPath: [], debugDescription: "Key is in an invalid format.")
            )
        }

        guard let key = Self(rawValue: rawValue) else {
            throw DecodingError.dataCorrupted(
                DecodingError.Context(codingPath: [], debugDescription: "Key not recognized.")
            )
        }

        self = key
    }

    public func encode(to encoder: any Encoder) throws {
        // encode as if Self was a flat list of keys, with the assumption that all possible keys are unique
        var container = encoder.singleValueContainer()

        switch self {
        case let .system(key): try container.encode(key)
        case let .object(key): try container.encode(key)
        case let .box(key): try container.encode(key)
        case let .clock(key): try container.encode(key)
        case let .device(key): try container.encode(key)
        case let .aggregate(key): try container.encode(key)
        case let .tap(key): try container.encode(key)
        case let .process(key): try container.encode(key)
        case let .plugin(key): try container.encode(key)
        case let .transportManager(key): try container.encode(key)
        case let .subTap(key): try container.encode(key)
        case let .subDevice(key): try container.encode(key)
        }
    }
}

extension AudioObjectSnapshot.AnyPropertyKey: AudioObjectSnapshot.PropertyKey {
    public var asAnyPropertyKey: AudioObjectSnapshot.AnyPropertyKey {
        self
    }
}

extension AudioObjectSnapshot.AnyPropertyKey {
    public func getValue(of object: any AudioObject) -> String? {
        var object = object

        // unwrap meta types
        if let anyObject = object as? AnyAudioObject,
           let typedObject = try? AudioSystem.shared.object(forID: anyObject.objectID)
        {
            object = typedObject
        } else if let anyDevice = object as? AnyAudioDevice {
            object = switch anyDevice {
            case let .device(device): device
            case let .aggregate(aggregate): aggregate
            }
        }

        switch self {
        case let .system(key):
            guard let typedObject = object as? any AudioSystemProperties else { return nil }
            return key.getValue(of: typedObject)
        case let .object(key):
            guard let typedObject = object as? any AudioObjectProperties else { return nil }
            return key.getValue(of: typedObject)
        case let .box(key):
            guard let typedObject = object as? any AudioBoxProperties else { return nil }
            return key.getValue(of: typedObject)
        case let .clock(key):
            guard let typedObject = object as? any AudioClockProperties else { return nil }
            return key.getValue(of: typedObject)
        case let .device(key):
            guard let typedObject = object as? any AudioDeviceProperties else { return nil }
            return key.getValue(of: typedObject)
        case let .aggregate(key):
            guard let typedObject = object as? any AudioAggregateDeviceProperties else { return nil }
            return key.getValue(of: typedObject)
        case let .tap(key):
            guard let typedObject = object as? any AudioTapProperties else { return nil }
            return key.getValue(of: typedObject)
        case let .process(key):
            guard let typedObject = object as? any AudioProcessProperties else { return nil }
            return key.getValue(of: typedObject)
        case let .plugin(key):
            guard let typedObject = object as? any AudioPlugInProperties else { return nil }
            return key.getValue(of: typedObject)
        case let .transportManager(key):
            guard let typedObject = object as? any AudioTransportManagerProperties else { return nil }
            return key.getValue(of: typedObject)
        case let .subTap(key):
            guard let typedObject = object as? any AudioSubTapProperties else { return nil }
            return key.getValue(of: typedObject)
        case let .subDevice(key):
            guard let typedObject = object as? any AudioSubDeviceProperties else { return nil }
            return key.getValue(of: typedObject)
        }
    }
}

#endif
