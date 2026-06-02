//
//  AudioObjectSnapshot ClockPropertyKey.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

extension AudioObjectSnapshot {
    /// Keys listed in the order they appear where their property getters are defined.
    public enum ClockPropertyKey: String {
        case deviceUID
        case transportType
        case clockDomain
        case isAlive
        case isRunning
        case latency
        case controls
        case nominalSampleRate
        case availableNominalSampleRates
    }
}

extension AudioObjectSnapshot.ClockPropertyKey: AudioObjectSnapshot.PropertyKey {
    public var asAnyPropertyKey: AudioObjectSnapshot.AnyPropertyKey {
        .clock(self)
    }
}

extension AudioObjectSnapshot.ClockPropertyKey {
    public func getValue(of object: some AudioClockProperties) -> String? {
        switch self {
        case .deviceUID:
            withErrorCapture(key: self, try object.deviceUID, transform: \.rawValue)
        case .transportType:
            withErrorCapture(key: self, try object.transportType, transform: \.rawValue.description)
        case .clockDomain:
            withErrorCapture(key: self, try object.clockDomain, transform: \.description)
        case .isAlive:
            withErrorCapture(key: self, try object.isAlive, transform: \.description)
        case .isRunning:
            withErrorCapture(key: self, try object.isRunning, transform: \.description)
        case .latency:
            withErrorCapture(key: self, try object.latency, transform: \.description)
        case .controls:
            withErrorCapture(key: self, try object.controls, transform: {
                let string = $0
                    .map(\.asAnyAudioObject.id.rawValue)
                    .map(String.init)
                    .joined(separator: ", ")
                return string.isEmpty ? nil : string
            })
        case .nominalSampleRate:
            withErrorCapture(key: self, try object.nominalSampleRate, transform: \.description)
        case .availableNominalSampleRates:
            withErrorCapture(key: self, try object.availableNominalSampleRates, transform: {
                let string = $0
                    .map {
                        // if range has identical min/max, consolidate it to a single value
                        $0.lowerBound == $0.upperBound ? "\($0.lowerBound)" : $0.description
                    }
                    .joined(separator: ", ")
                return string.isEmpty ? nil : string
            })
        }
    }
}

#endif
