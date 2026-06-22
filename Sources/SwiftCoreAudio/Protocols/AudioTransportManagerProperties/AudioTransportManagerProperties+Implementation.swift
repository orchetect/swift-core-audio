//
//  AudioTransportManagerProperties+Implementation.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

extension AudioTransportManagerProperties {
    // MARK: CoreAudio/AudioHardwareBase.h

    nonisolated
    public var endpoints: [AudioEndPointDevice] {
        get throws(SwiftCoreAudioError) {
            let ids = try getPropertyValue(property: TransportManagerProperty.endPointList)
            return ids.map { AudioEndPointDevice(id: $0) }
        }
    }

    nonisolated
    public func endpoint(forUID uid: AudioEndPointDevice.UID) throws(SwiftCoreAudioError) -> AudioEndPointDevice? {
        let id = try getPropertyValue(
            property: TransportManagerProperty.translateUIDToEndPoint,
            qualifier: .init(initialValue: uid.rawValue)
        )
        // `kAudioObjectUnknown` ID with `noErr` OSStatus means "not found" but is not an error
        guard id != kAudioObjectUnknown else { return nil }
        return AudioEndPointDevice(id: id)
    }

    nonisolated
    public var transportType: AudioDevice.TransportType {
        get throws(SwiftCoreAudioError) {
            let rawValue: FourCharCode = try getPropertyValue(property: TransportManagerProperty.transportType)
            let transport = try AudioDevice.TransportType(tryingRawValue: rawValue)
            return transport
        }
    }

    // MARK: CoreAudio/AudioHardware.h

    // TODO: needs testing
    nonisolated
    public func makeEndPointDevice(composition: CFDictionary) throws(SwiftCoreAudioError) -> AudioEndPointDevice {
        let id = try getPropertyValue(property: TransportManagerProperty.createEndPointDevice, qualifier: .init(initialValue: composition))
        return AudioEndPointDevice(id: id)
    }

    // TODO: needs testing
    nonisolated
    public func destroyEndPointDevice(_ endPointDevice: AudioEndPointDevice) throws(SwiftCoreAudioError) {
        var value = endPointDevice.id.rawValue
        _ = try getPropertyValue(address: TransportManagerProperty.destroyEndPointDevice.address, value: &value, qualifier: .none)
        // TODO: not sure if a value gets returned (OSStatus? docs don't say.)
    }
}

#endif
