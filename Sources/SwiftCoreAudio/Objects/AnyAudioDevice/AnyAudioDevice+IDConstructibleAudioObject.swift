//
//  AnyAudioDevice+IDConstructibleAudioObject.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

extension AnyAudioDevice: IDConstructibleAudioObject {
    /// Construct a new instance, determining the device type by querying Core Audio.
    nonisolated
    public init(id: ID) {
        let id = id.rawValue

        assert(id != kAudioObjectUnknown)

        let classID: AudioObjectClassID?
        do throws(SwiftCoreAudioError) {
            classID = try AnyAudioObject(id: id).classID
        } catch {
            Logging.log(.error, "Failed to get classID for object ID \(id): \(error)")
            classID = nil
        }

        switch classID {
        case .device:
            let device = AudioDevice(id: id)
            self = .device(device)
        case .aggregate:
            let device = AudioAggregateDevice(id: id)
            self = .aggregate(device)
        default:
            Logging.log(
                .error,
                """
                Attempted to create an AnyAudioDevice from an object that is not a device or an aggregate device. \
                The object is of type \(classID?.description ?? "unknown"). Using AudioDevice as a fallback.
                """
            )
            // just return as an AudioDevice as a fallback
            let device = AudioDevice(id: id)
            self = .device(device)
        }
    }

    /// Construct a new instance, determining the device type by querying Core Audio.
    nonisolated
    public init(id: AudioDeviceID) {
        self.init(id: ID(id))
    }
}

// MARK: - Convenience

extension AnyAudioDevice {
    nonisolated
    public init(_ device: AudioDevice) {
        self = .device(device)
    }

    nonisolated
    public init(_ aggregate: AudioAggregateDevice) {
        self = .aggregate(aggregate)
    }

    nonisolated
    public init(_ deviceID: AudioDevice.ID) {
        self = .device(AudioDevice(id: deviceID))
    }

    nonisolated
    public init(_ aggregateID: AudioAggregateDevice.ID) {
        self = .aggregate(AudioAggregateDevice(id: aggregateID))
    }
}

#endif
