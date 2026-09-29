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
    ///   - cachedModelUID: Optionally supply the model UID property value if it is known, otherwise
    ///     it will be queried from Core Audio.
    @available(macOS 11, macCatalyst 13, iOS 13, tvOS 13, watchOS 6, visionOS 1, *) // SF Symbols 1.0
    nonisolated
    public func iconImageSystemName(
        for direction: AudioStream.Direction,
        cachedTransportType: AudioDevice.TransportType? = nil,
        cachedModelUID: String? = nil
    ) throws(SwiftCoreAudioError) -> String? {
        let transportType = if let cachedTransportType {
            cachedTransportType
        } else {
            try self.transportType
        }

        let modelUID = if let cachedModelUID {
            cachedModelUID
        } else {
            try? self.modelUID
        }

        return transportType.iconSystemName(for: direction, deviceModelUID: modelUID)
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
    ///   - cachedModelUID: Optionally supply the model UID property value if it is known, otherwise
    ///     it will be queried from Core Audio.
    @available(macOS 11, macCatalyst 13, iOS 13, tvOS 13, watchOS 6, visionOS 1, *) // SF Symbols 1.0
    nonisolated
    public func iconImage(
        for direction: AudioStream.Direction,
        isDriverIconAllowed: Bool = true,
        cachedTransportType: AudioDevice.TransportType? = nil,
        cachedModelUID: String? = nil
    ) -> Image {
        if isDriverIconAllowed,
           let iconURL = try? icon
        {
            #if os(macOS)
            if let nsImage = NSImage(contentsOf: iconURL) {
                return Image(nsImage: nsImage)
            }
            #else
            if let uiImage = UIImage(contentsOfFile: iconURL.path) {
                return Image(uiImage: uiImage)
            }
            #endif
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
            cachedModelUID: cachedModelUID
        ) else {
            return defaultImage()
        }

        return Image(systemName: systemName)
    }
}

#endif

#endif
