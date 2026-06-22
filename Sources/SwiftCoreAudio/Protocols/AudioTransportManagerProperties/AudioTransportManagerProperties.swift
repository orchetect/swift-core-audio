//
//  AudioTransportManagerProperties.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

/// Properties offered by the Core Audio `AudioTransportManager` class.
nonisolated
public protocol AudioTransportManagerProperties where Self: AudioObject {
    // MARK: CoreAudio/AudioHardwareBase.h

    /// Returns all the endpoint devices the transport manager is tracking.
    nonisolated
    var endpoints: [AudioEndPointDevice] { get throws(SwiftCoreAudioError) }

    /// Returns the endpoint device for the given UID.
    nonisolated
    func endpoint(forUID uid: AudioEndPointDevice.UID) throws(SwiftCoreAudioError) -> AudioEndPointDevice?

    /// A ``AudioDevice/TransportType`` instance indicating how the device is connected to the CPU.
    nonisolated
    var transportType: AudioDevice.TransportType { get throws(SwiftCoreAudioError) }

    // MARK: CoreAudio/AudioHardware.h

    // TODO: needs testing
    /// Tell the transport manager to create a new endpoint device.
    nonisolated
    func makeEndPointDevice(composition: CFDictionary) throws(SwiftCoreAudioError) -> AudioEndPointDevice

    // TODO: needs testing
    /// Tell the transport manager to destroy an endpoint device.
    nonisolated
    func destroyEndPointDevice(_ endPointDevice: AudioEndPointDevice) throws(SwiftCoreAudioError)
}

#endif
