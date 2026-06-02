//
//  AudioObjectSnapshot TransportManagerPropertyKey.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

extension AudioObjectSnapshot {
    /// Keys listed in the order they appear where their property getters are defined.
    public enum TransportManagerPropertyKey: String {
        // TODO: implement after implementing properties on AudioTransportManager
        case foo
    }
}

extension AudioObjectSnapshot.TransportManagerPropertyKey: AudioObjectSnapshot.PropertyKey {
    public var asAnyPropertyKey: AudioObjectSnapshot.AnyPropertyKey {
        .transportManager(self)
    }
}

extension AudioObjectSnapshot.TransportManagerPropertyKey {
    public func getValue(of object: some AudioTransportManagerProperties) -> String? {
        // TODO: implement after implementing properties on AudioTransportManager
        switch self {
        case .foo: nil
        }
    }
}

#endif
