//
//  AudioObjectSnapshot SubDevicePropertyKey.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

extension AudioObjectSnapshot {
    /// Keys listed in the order they appear where their property getters are defined.
    public enum SubDevicePropertyKey: String {
        case extraLatency
        case isDriftCompensationEnabled
        case driftCompensationQuality
    }
}

extension AudioObjectSnapshot.SubDevicePropertyKey: AudioObjectSnapshot.PropertyKey {
    public var asAnyPropertyKey: AudioObjectSnapshot.AnyPropertyKey {
        .subDevice(self)
    }
}

extension AudioObjectSnapshot.SubDevicePropertyKey {
    public func getValue(of object: some AudioSubDeviceProperties) -> String? {
        switch self {
        case .extraLatency:
            withErrorCapture(key: self, try object.extraLatency, transform: \.description)
            
        case .isDriftCompensationEnabled:
            withErrorCapture(key: self, try object.isDriftCompensationEnabled, transform: \.description)
            
        case .driftCompensationQuality:
            withErrorCapture(key: self, try object.driftCompensationQuality, transform: \.rawValue.description)
        }
    }
}

#endif
