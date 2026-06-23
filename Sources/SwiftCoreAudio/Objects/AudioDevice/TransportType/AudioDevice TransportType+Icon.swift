//
//  AudioDevice TransportType+Icon.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import Foundation

extension AudioDevice.TransportType {
    /// Returns a standard system image name (SF Symbol) appropriate for generic device input or output.
    public static func defaultIconSystemName(for direction: AudioStream.Direction) -> String {
        switch direction {
        case .input: "mic.fill"
        case .output: "speaker.wave.2.fill"
        }
    }

    /// Returns a suggested system image name (SF Symbol) appropriate for the transport type
    /// for use in UI.
    public func iconSystemName(for direction: AudioStream.Direction, deviceModelName: String?) -> String? {
        switch self {
        // MARK: CoreAudio/AudioHardwareBase.h

        case .unknown:
            Self.defaultIconSystemName(for: direction)

        case .builtIn:
            switch SystemInfo.localMachineModelName.lowercased() {
            case let n where n.hasPrefix("macbook"): // verbatim modelname: "MacBook"
                "laptopcomputer"
            case let n where n.hasPrefix("macpro7"): // verbatim modelname: "MacPro7"
                "macpro.gen3"
            case let n where n.hasPrefix("macpro6"): // verbatim modelname: "MacPro6"
                "macpro.gen2"
            case let n where n.hasPrefix("macpro"): // verbatim modelname: "MacPro"
                "macpro.gen1"
            case let n where n.hasPrefix("mac13"): // verbatim modelname: "Mac13"
                "macstudio"
            case let n where n.hasPrefix("imac"): // verbatim modelname: "iMac"
                "desktopcomputer"
            case let n where n.hasPrefix("macmini"): // verbatim modelname: "Macmini"
                "macmini"
            default: "laptopcomputer"
            }

        case .aggregate:
            Self.defaultIconSystemName(for: direction)

        case .virtual:
            Self.defaultIconSystemName(for: direction)

        case .bluetooth, .bluetoothLE:
            switch deviceModelName?.lowercased() {
            case "200a 4c": "airpodsmax"
            case "200e 4c": "airpodspro"
            case "200f 4c": "airpods.gen3"
            case "2013 4c", "2002 4c": "airpods"
            case "2012 4c": "beats.fit.pro"
            default: "headphones"
            }

        case .hdmi, .displayPort:
            "tv"

        case .airPlay:
            "tv"

        case .continuityCaptureWired, .continuityCaptureWireless:
            "iphone"

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
}

#endif
