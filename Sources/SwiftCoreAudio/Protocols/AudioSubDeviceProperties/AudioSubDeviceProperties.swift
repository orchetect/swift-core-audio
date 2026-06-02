//
//  AudioSubDeviceProperties.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

/// Properties offered by the Core Audio `AudioSubDevice` class.
nonisolated
public protocol AudioSubDeviceProperties where Self: AudioObject {
    // MARK: CoreAudio/AudioHardware.h
    
    /// The number of sample frames to add to or subtract from the latency compensation used for this subdevice.
    nonisolated
    var extraLatency: Double { get throws(SwiftCoreAudioError) }
    
    // TODO: needs testing
    /// Set the number of sample frames to add to or subtract from the latency compensation used for this subdevice.
    nonisolated
    func setExtraLatency(_ value: Double) throws(SwiftCoreAudioError)
    
    /// A boolean value describing whether drift compensation is enabled for the subdevice.
    nonisolated
    var isDriftCompensationEnabled: Bool { get throws(SwiftCoreAudioError) }
    
    // TODO: needs testing
    /// Sets the boolean value describing whether drift compensation is enabled for the subdevice.
    nonisolated
    func setIsDriftCompensationEnabled(_ value: Bool) throws(SwiftCoreAudioError)
    
    /// The quality of the drift compensation for the subdevice.
    ///
    /// This value controls the trade-off between quality and CPU load in the drift compensation.
    /// The range of values is from `0` to `127`, where the lower the number, the worse the
    /// quality but also the less CPU is used to do the compensation.
    nonisolated
    var driftCompensationQuality: AudioAggregateDevice.DriftCompensationQuality { get throws(SwiftCoreAudioError) }
    
    // TODO: needs testing
    /// Sets the quality of the drift compensation for the subdevice.
    ///
    /// This value controls the trade-off between quality and CPU load in the drift compensation.
    /// The range of values is from `0` to `127`, where the lower the number, the worse the
    /// quality but also the less CPU is used to do the compensation.
    nonisolated
    func setDriftCompensationQuality(_ quality: AudioAggregateDevice.DriftCompensationQuality) throws(SwiftCoreAudioError)
}

#endif

