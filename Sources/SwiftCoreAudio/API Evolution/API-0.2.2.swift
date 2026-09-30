//
//  API-0.2.2.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import Foundation
import SwiftProcess
import SwiftUI

// MARK: - AudioDevice TransportType+Icon.swift

extension AudioDevice.TransportType {
    @available(macOS 11, macCatalyst 13, iOS 13, tvOS 13, watchOS 6, visionOS 1, *) // SF Symbols 1.0
    @_documentation(visibility: internal)
    @available(
        *,
        deprecated,
        renamed: "iconSystemName(for:deviceModelUID:)",
        message: "This method now takes a device model UID property value instead of a model name."
    )
    nonisolated
    public func iconSystemName(
        for direction: AudioStream.Direction,
        deviceModelName: String?
    ) -> String? {
        iconSystemName(for: direction, deviceModelUID: deviceModelName)
    }
}

// MARK: - AudioDeviceProperties+Icon.swift

extension AudioDeviceProperties where Self: AudioObjectProperties {
    @available(macOS 11, macCatalyst 13, iOS 13, tvOS 13, watchOS 6, visionOS 1, *) // SF Symbols 1.0
    @_documentation(visibility: internal)
    @available(
        *,
         deprecated,
         renamed: "iconImageSystemName(for:cachedTransportType:cachedModelUID:)",
         message: "This method now takes a device model UID property value instead of a model name."
    )
    nonisolated
    public func iconImageSystemName(
        for direction: AudioStream.Direction,
        cachedTransportType: AudioDevice.TransportType? = nil,
        cachedModelName: String? = nil
    ) throws(SwiftCoreAudioError) -> String? {
        try iconImageSystemName(
            for: direction,
            cachedTransportType: cachedTransportType,
            cachedModelUID: cachedModelName
        )
    }

    @available(macOS 11, macCatalyst 13, iOS 13, tvOS 13, watchOS 6, visionOS 1, *) // SF Symbols 1.0
    @_documentation(visibility: internal)
    @available(
        *,
         deprecated,
         renamed: "iconImage(for:isDriverIconAllowed:cachedTransportType:cachedModelUID:)",
         message: "This method now takes a device model UID property value instead of a model name."
    )
    nonisolated
    public func iconImage(
        for direction: AudioStream.Direction,
        isDriverIconAllowed: Bool = true,
        cachedTransportType: AudioDevice.TransportType? = nil,
        cachedModelName: String? = nil
    ) -> Image {
        iconImage(
            for: direction,
            isDriverIconAllowed: isDriverIconAllowed,
            cachedTransportType: cachedTransportType,
            cachedModelUID: cachedModelName
        )
    }
}

#endif
