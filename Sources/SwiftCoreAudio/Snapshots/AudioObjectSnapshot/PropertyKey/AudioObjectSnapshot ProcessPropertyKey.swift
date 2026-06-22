//
//  AudioObjectSnapshot ProcessPropertyKey.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

extension AudioObjectSnapshot {
    /// Keys listed in the order they appear where their property getters are defined.
    public enum ProcessPropertyKey: String {
        case pid
        case bundleID
        case devices
        case isRunning
        case isRunningForInput
        case isRunningForOutput
    }
}

extension AudioObjectSnapshot.ProcessPropertyKey: AudioObjectSnapshot.PropertyKey {
    public var asAnyPropertyKey: AudioObjectSnapshot.AnyPropertyKey {
        .process(self)
    }
}

extension AudioObjectSnapshot.ProcessPropertyKey {
    public func getValue(of object: some AudioProcessProperties) -> String? {
        // swiftformat:disable hoistTry
        switch self {
        case .pid:
            withErrorCapture(key: self, try object.pid, transform: {
                var output = "\($0.rawValue)"
                if let name = $0.name {
                    output += " - \(name)"
                }
                return output
            })
        case .bundleID:
            withErrorCapture(key: self, try object.bundleID, transform: \.rawValue)
        case .devices:
            withErrorCapture(key: self, try object.devices, transform: {
                let string = $0
                    .map(\.asAnyAudioObject.id.rawValue)
                    .map(String.init)
                    .joined(separator: ", ")
                return string.isEmpty ? nil : string
            })
        case .isRunning:
            withErrorCapture(key: self, try object.isRunning, transform: \.description)
        case .isRunningForInput:
            withErrorCapture(key: self, try object.isRunning(for: .input), transform: \.description)
        case .isRunningForOutput:
            withErrorCapture(key: self, try object.isRunning(for: .output), transform: \.description)
        }
        // swiftformat:enable hoistTry
    }
}

#endif
