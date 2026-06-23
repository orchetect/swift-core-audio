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
    ///
    /// - Parameters:
    ///   - direction: Audio direction (input for recording, output for playback).
    ///   - cachedTransportType: Optionally supply the transport type if it is known, otherwise
    ///     it will be queried from Core Audio.
    ///   - cachedModelName: Optionally supply the model name if it is known, otherwise
    ///     it will be queried from Core Audio.
    nonisolated
    public func iconImageSystemName(
        for direction: AudioStream.Direction,
        cachedTransportType: AudioDevice.TransportType? = nil,
        cachedModelName: String? = nil
    ) throws(SwiftCoreAudioError) -> String? {
        let transportType = if let cachedTransportType {
            cachedTransportType
        } else {
            try self.transportType
        }

        let modelName = if let cachedModelName {
            cachedModelName
        } else {
            try? self.modelName
        }

        return transportType.iconSystemName(for: direction, deviceModelName: modelName)
    }
}

#if canImport(SwiftUI)

import SwiftUI

extension AudioDeviceProperties where Self: AudioObjectProperties {
    /// Returns a suggested system image name (SF Symbol) appropriate for the device
    /// for use in UI.
    ///
    /// - Parameters:
    ///   - direction: Audio direction (input for recording, output for playback).
    ///   - isDriverIconAllowed: When `true`, the icon image supplied by the device is
    ///     preferred when available. When not available, a suggested SF Symbol image is provided.
    ///     When `false`, a SF Symbol image is always returned.
    ///   - cachedTransportType: Optionally supply the transport type if it is known, otherwise
    ///     it will be queried from Core Audio.
    ///   - cachedModelName: Optionally supply the model name if it is known, otherwise
    ///     it will be queried from Core Audio.
    @available(macOS 11.0, *)
    nonisolated
    public func iconImage(
        for direction: AudioStream.Direction,
        isDriverIconAllowed: Bool = true,
        cachedTransportType: AudioDevice.TransportType? = nil,
        cachedModelName: String? = nil
    ) -> Image {
        if isDriverIconAllowed,
           let iconURL = try? icon,
           let nsImage = NSImage(contentsOf: iconURL)
        {
            return Image(nsImage: nsImage)
        }

        func defaultImage() -> Image {
            let systemName = AudioDevice.TransportType.defaultIconSystemName(for: direction)
            return Image(systemName: systemName)
        }

        guard let uid = try? self.uid else {
            return defaultImage()
        }

        // special case: BlackHole audio devices
        if uid.isBlackHole {
            return Image(.blackHoleIcon)
        }

        guard let systemName = try? iconImageSystemName(
            for: direction,
            cachedTransportType: cachedTransportType,
            cachedModelName: cachedModelName
        ) else {
            return defaultImage()
        }

        return Image(systemName: systemName)
    }
}

#endif

#endif
