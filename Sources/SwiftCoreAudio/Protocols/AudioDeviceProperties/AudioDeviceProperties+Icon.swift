//
//  AudioDeviceProperties+Icon.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

extension AudioDeviceProperties where Self: AudioObjectProperties {
    /// Returns a suggested system image name (SF Symbol) appropriate for the device
    /// for use in UI.
    public func iconImageSystemName(
        for direction: AudioStream.Direction
    ) throws(SwiftCoreAudioError) -> String? {
        let transportType = try self.transportType
        let modelName = try? self.modelName
        return transportType.iconSystemName(for: direction, deviceModelName: modelName)
    }
}

#endif
