//
//  AudioDevice TransportType+Icon.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import Foundation

@available(macOS 11, macCatalyst 13, iOS 13, tvOS 13, watchOS 6, visionOS 1, *) // SF Symbols 1.0
extension AudioDevice.TransportType {
    /// Returns a standard system image name (SF Symbol) appropriate for generic device input or output.
    public static func defaultIconSystemName(for direction: AudioStream.Direction) -> String {
        switch direction {
        case .input:
            if SFSymbolsVersion.v6_0.isAvailable {
                "microphone.fill" // SF 6.0
            } else {
                "mic.fill" // SF 1.0

            }
        case .output:
            if SFSymbolsVersion.v2_0.isAvailable {
                "speaker.wave.2.fill" // SF 2.0
            } else {
                "speaker.2.fill" // SF 1.0
            }
        }
    }

    /// Returns a suggested system image name (SF Symbol) appropriate for the transport type
    /// for use in UI.
    ///
    /// - Parameters:
    ///   - direction: Audio stream direction (input or output), which dictates either a microphone-related
    ///     image variant or a speaker-related image, where possible.
    ///   - deviceModelUID: The `modelUID` property value returned by the Core Audio device. This value
    ///     helps differentiate between certain product models, especially for Bluetooth audio devices.
    /// - Returns: SF Symbol image name.
    public func iconSystemName(for direction: AudioStream.Direction, deviceModelUID: String?) -> String {
        switch self {
        // MARK: CoreAudio/AudioHardwareBase.h

        case .unknown:
            Self.defaultIconSystemName(for: direction)

        case .builtIn:
            _builtInIconSystemName()

        case .aggregate:
            Self.defaultIconSystemName(for: direction)

        case .virtual:
            Self.defaultIconSystemName(for: direction)

        case .bluetooth, .bluetoothLE:
            if let deviceModelUID,
               let product = BluetoothAudioProduct(coreAudioDeviceModelName: deviceModelUID)
            {
                product.systemImageName
            } else {
                Self.defaultIconSystemName(for: direction)
            }

        case .hdmi, .displayPort:
            "tv" // SF 1.0

        case .airPlay:
            "tv" // SF 1.0

        case .continuityCaptureWired, .continuityCaptureWireless:
            if SFSymbolsVersion.v2_0.isAvailable {
                "iphone" // SF 2.0
            } else {
                Self.defaultIconSystemName(for: direction)
            }

        case .audioVideoBridging:
            Self.defaultIconSystemName(for: direction)

        case .firewire, .pci, .thunderbolt, .usb:
            Self.defaultIconSystemName(for: direction)

        // MARK: CoreAudio/AudioHardwareDeprecated.h

        case .autoAggregate:
            Self.defaultIconSystemName(for: direction)

        // MARK: Unknowns - Discovered During Debugging and need to find the source of their constants

        case .atac:
            Self.defaultIconSystemName(for: direction)
        }
    }

    private func _builtInIconSystemName() -> String {
        // this is a simplified heuristic to broadly cover many device types, but is not exhaustive

        switch SystemInfo.localMachineModelName.lowercased() {
        case let n where n.hasPrefix("macbook"): // verbatim: "MacBook"
            AudioDeviceSFSymbol.macBook
        case let n where n.hasPrefix("macpro7"): // verbatim: "MacPro7"
            AudioDeviceSFSymbol.macProGen3
        case let n where n.hasPrefix("macpro6"): // verbatim: "MacPro6"
            AudioDeviceSFSymbol.macProGen2
        case let n where n.hasPrefix("macpro"): // verbatim: "MacPro"
            AudioDeviceSFSymbol.macProGen1
        case let n where n.hasPrefix("mac13"): // verbatim: "Mac13"
            AudioDeviceSFSymbol.macStudio
        case let n where n.hasPrefix("imac"): // verbatim: "iMac"
            AudioDeviceSFSymbol.iMac
        case let n where n.hasPrefix("macmini"): // verbatim: "Macmini"
            AudioDeviceSFSymbol.macMini
        case let n where n.hasPrefix("macstudio"): // TODO: needs check for accuracy
            AudioDeviceSFSymbol.macStudio
        default:
            AudioDeviceSFSymbol._genericDesktopComputer
        }
    }
}

#if canImport(SwiftUI)

import SwiftUI

@available(macOS 11, macCatalyst 13, iOS 13, tvOS 13, watchOS 6, visionOS 1, *) // SF Symbols 1.0
extension AudioDevice.TransportType {
    public func iconImage(for direction: AudioStream.Direction, deviceModelUID: String?) -> Image {
        // special case: BlackHole audio devices
        if let deviceModelUID, deviceModelUID.isBlackHoleModelUID {
            Image(.blackHoleSymbol)
        }
        // fallback to SF Symbols
        else {
            Image(systemName: iconSystemName(for: direction, deviceModelUID: deviceModelUID))
        }
    }
}

#endif

#endif
