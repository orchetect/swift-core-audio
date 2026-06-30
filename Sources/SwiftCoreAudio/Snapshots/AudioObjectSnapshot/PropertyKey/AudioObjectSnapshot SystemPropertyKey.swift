//
//  AudioObjectSnapshot SystemPropertyKey.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

extension AudioObjectSnapshot {
    /// Keys listed in the order they appear where their property getters are defined.
    public enum SystemPropertyKey: String {
        case defaultInputDevice
        case defaultOutputDevice
        case defaultOutputDeviceForSystemSounds
        case isStereoMixedDownToMono
        case isProcessMain
        case isInitingOrExiting
        case isProcessMutedForInput
        case isProcessMutedForOutput
        case isSleepingAllowed
        case isUnloadingAllowed
        case isHogModeAllowed
        case isUserSessionForProcessActiveOrHeadless
        case powerHint
    }
}

extension AudioObjectSnapshot.SystemPropertyKey: AudioObjectSnapshot.PropertyKey {
    public var asAnyPropertyKey: AudioObjectSnapshot.AnyPropertyKey {
        .system(self)
    }
}

extension AudioObjectSnapshot.SystemPropertyKey {
    public func getValue(of object: some AudioSystemProperties) -> String? {
        // swiftformat:disable hoistTry
        switch self {
        case .defaultInputDevice:
            withErrorCapture(key: self, try object.defaultInputDevice, transform: \.id.rawValue.description)
        case .defaultOutputDevice:
            withErrorCapture(key: self, try object.defaultOutputDevice, transform: \.id.rawValue.description)
        case .defaultOutputDeviceForSystemSounds:
            withErrorCapture(key: self, try object.defaultOutputDeviceForSystemSounds, transform: \.id.rawValue.description)
        case .isStereoMixedDownToMono:
            withErrorCapture(key: self, try object.isStereoMixedDownToMono, transform: \.description)
        case .isProcessMain:
            withErrorCapture(key: self, try object.isProcessMain, transform: \.description)
        case .isInitingOrExiting:
            withErrorCapture(key: self, try object.isInitingOrExiting, transform: \.description)
        case .isProcessMutedForInput:
            withErrorCapture(key: self, try object.isProcessMuted(for: .input), transform: \.description)
        case .isProcessMutedForOutput:
            withErrorCapture(key: self, try object.isProcessMuted(for: .output), transform: \.description)
        case .isSleepingAllowed:
            withErrorCapture(key: self, try object.isSleepingAllowed, transform: \.description)
        case .isUnloadingAllowed:
            withErrorCapture(key: self, try object.isUnloadingAllowed, transform: \.description)
        case .isHogModeAllowed:
            withErrorCapture(key: self, try object.isHogModeAllowed, transform: \.description)
        case .isUserSessionForProcessActiveOrHeadless:
            withErrorCapture(key: self, try object.isUserSessionForProcessActiveOrHeadless, transform: \.description)
        case .powerHint:
            withErrorCapture(key: self, try object.powerHint, transform: \.rawValue.description)
        }
        // swiftformat:enable hoistTry
    }
}

#endif
