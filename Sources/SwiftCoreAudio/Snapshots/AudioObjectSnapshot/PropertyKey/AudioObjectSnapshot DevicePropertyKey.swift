//
//  AudioObjectSnapshot DevicePropertyKey.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

extension AudioObjectSnapshot {
    /// Keys listed in the order they appear where their property getters are defined.
    public enum DevicePropertyKey: String {
        case configurationApplication
        case deviceUID
        case modelUID
        case transportType
        case relatedDevices
        case clockDomain
        case isDeviceAlive
        case isDeviceRunning
        case isSettableAsDefaultDeviceForInput
        case isSettableAsDefaultDeviceForOutput
        case latencyForInput
        case latencyForOutput
        case streams
        case controls
        case safetyOffsetForInput
        case safetyOffsetForOutput
        case nominalSampleRate
        case availableNominalSampleRates
        case icon
        case isHidden
        case preferredStereoChannelsForInput
        case preferredStereoChannelsForOutput
        case preferredChannelLayout
        case plugIn
        case hogModePID
        case bufferFrameSize
        case bufferFrameSizeRange
        // case isVariableBufferFrameSizesUsed // TODO: not yet implemented, property name may change
        case ioCycleUsage
        case streamConfiguration
        case ioProcStreamUsage
        case actualSampleRate
        case clockDeviceUID
        case workgroup
        case isCurrentProcessMutedForInput
        case isCurrentProcessMutedForOutput
    }
}

extension AudioObjectSnapshot.DevicePropertyKey: AudioObjectSnapshot.PropertyKey {
    public var asAnyPropertyKey: AudioObjectSnapshot.AnyPropertyKey {
        .device(self)
    }
}

extension AudioObjectSnapshot.DevicePropertyKey {
    public func getValue(of object: some AudioDeviceProperties) -> String? {
        switch self {
        case .configurationApplication:
            withErrorCapture(key: self, try object.configurationApplication, transform: \.rawValue)
        case .deviceUID:
            withErrorCapture(key: self, try object.deviceUID, transform: \.rawValue)
        case .modelUID:
            withErrorCapture(key: self, try object.modelUID)
        case .transportType:
            withErrorCapture(key: self, try object.transportType, transform: \.rawValue.description)
        case .relatedDevices:
            withErrorCapture(key: self, try object.relatedDevices, transform: {
                let string = $0
                    .map(\.asAnyAudioObject.id.rawValue)
                    .map(String.init)
                    .joined(separator: ", ")
                return string.isEmpty ? nil : string
            })
        case .clockDomain: // TODO: not yet implemented
            nil
        case .isDeviceAlive:
            withErrorCapture(key: self, try object.isDeviceAlive, transform: \.description)
        case .isDeviceRunning:
            withErrorCapture(key: self, try object.isDeviceRunning, transform: \.description)
        case .isSettableAsDefaultDeviceForInput:
            withErrorCapture(key: self, try object.isSettableAsDefaultDevice(for: .input), transform: \.description)
        case .isSettableAsDefaultDeviceForOutput:
            withErrorCapture(key: self, try object.isSettableAsDefaultDevice(for: .output), transform: \.description)
        case .latencyForInput:
            withErrorCapture(key: self, try object.latency(for: .input), transform: \.description)
        case .latencyForOutput:
            withErrorCapture(key: self, try object.latency(for: .output), transform: \.description)
        case .streams:
            withErrorCapture(key: self, try object.streams, transform: {
                let string = $0
                    .map(\.asAnyAudioObject.id.rawValue)
                    .map(String.init)
                    .joined(separator: ", ")
                return string.isEmpty ? nil : string
            })
        case .controls:
            withErrorCapture(key: self, try object.controls, transform: {
                let string = $0
                    .map(String.init)
                    .joined(separator: ", ")
                return string.isEmpty ? nil : string
            })
        case .safetyOffsetForInput:
            withErrorCapture(key: self, try object.safetyOffset(for: .input), transform: \.description)
        case .safetyOffsetForOutput:
            withErrorCapture(key: self, try object.safetyOffset(for: .output), transform: \.description)
        case .nominalSampleRate:
            withErrorCapture(key: self, try object.nominalSampleRate, transform: \.description)
        case .availableNominalSampleRates:
            withErrorCapture(key: self, try object.availableNominalSampleRates, transform: {
                let string = $0.map {
                    // if range has identical min/max, consolidate it to a single value
                    $0.lowerBound == $0.upperBound ? "\($0.lowerBound)" : $0.description
                }
                    .joined(separator: ", ")
                return string.isEmpty ? nil : string
            })
        case .icon:
            withErrorCapture(key: self, try object.icon, transform: \.path)
        case .isHidden:
            withErrorCapture(key: self, try object.isHidden, transform: \.description)
        case .preferredStereoChannelsForInput:
            withErrorCapture(key: self, try object.preferredStereoChannels(for: .input), transform: {
                "\($0.left), \($0.right)"
            })
        case .preferredStereoChannelsForOutput:
            withErrorCapture(key: self, try object.preferredStereoChannels(for: .output), transform: {
                "\($0.left), \($0.right)"
            })
        case .preferredChannelLayout:
            withErrorCapture(key: self, try object.preferredChannelLayout, transform: { v -> String in String(describing: v) })
        case .plugIn: // TODO: not yet implemented
            nil
        case .hogModePID:
            withErrorCapture(key: self, try object.hogModePID, transform: \.description)
        case .bufferFrameSize:
            withErrorCapture(key: self, try object.bufferFrameSize, transform: \.description)
        case .bufferFrameSizeRange:
            withErrorCapture(key: self, try object.bufferFrameSizeRange, transform: \.description)
            // case .isVariableBufferFrameSizesUsed: // TODO: not yet implemented
            //     nil
        case .ioCycleUsage:
            withErrorCapture(key: self, try object.ioCycleUsage, transform: \.description)
        case .streamConfiguration: // TODO: not yet implemented
            nil
        case .ioProcStreamUsage: // TODO: not yet implemented
            nil
        case .actualSampleRate:
            withErrorCapture(key: self, try object.actualSampleRate, transform: \.description)
        case .clockDeviceUID:
            withErrorCapture(key: self, try object.clockDeviceUID, transform: \.rawValue)
        case .workgroup:
            withErrorCapture(key: self, try object.workgroup, transform: \.description)
        case .isCurrentProcessMutedForInput:
            withErrorCapture(key: self, try object.isCurrentProcessMuted(for: .input), transform: \.description)
        case .isCurrentProcessMutedForOutput:
            withErrorCapture(key: self, try object.isCurrentProcessMuted(for: .output), transform: \.description)
        }
    }
}

#endif
