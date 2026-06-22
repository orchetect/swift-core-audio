//
//  AudioDevice TransportType.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import Foundation

extension AudioDevice {
    /// Audio device transport types.
    ///
    /// CoreAudio `kAudioDeviceTransportType*` constants.
    ///
    /// Transport type is available for ``AudioBox``, ``AudioClock``, and ``AudioDevice``.
    public enum TransportType {
        // MARK: CoreAudio/AudioHardwareBase.h

        /// The transport type ID returned when a device doesn't provide a transport type.
        ///
        /// > File: CoreAudio/AudioHardwareBase.h
        ///
        /// > Constant: `kAudioDeviceTransportTypeUnknown`
        case unknown

        /// Audio devices built into the system.
        ///
        /// > File: CoreAudio/AudioHardwareBase.h
        ///
        /// > Constant: `kAudioDeviceTransportTypeBuiltIn`
        case builtIn

        /// Aggregate devices (virtual software devices).
        ///
        /// > File: CoreAudio/AudioHardwareBase.h
        ///
        /// > Constant: `kAudioDeviceTransportTypeAggregate`
        case aggregate

        /// Audio devices that don't correspond to real audio hardware.
        ///
        /// > File: CoreAudio/AudioHardwareBase.h
        ///
        /// > Constant: `kAudioDeviceTransportTypeVirtual`
        case virtual

        /// Audio devices connected via the PCI bus.
        ///
        /// > File: CoreAudio/AudioHardwareBase.h
        ///
        /// > Constant: `kAudioDeviceTransportTypePCI`
        case pci

        /// Audio devices connected via USB.
        ///
        /// > File: CoreAudio/AudioHardwareBase.h
        ///
        /// > Constant: `kAudioDeviceTransportTypeUSB`
        case usb

        /// Audio devices connected via FireWire.
        ///
        /// > File: CoreAudio/AudioHardwareBase.h
        ///
        /// > Constant: `kAudioDeviceTransportTypeFireWire`
        case firewire

        /// Audio devices connected via Bluetooth.
        ///
        /// > File: CoreAudio/AudioHardwareBase.h
        ///
        /// > Constant: `kAudioDeviceTransportTypeBluetooth`
        case bluetooth

        /// Audio devices connected via Bluetooth LE.
        ///
        /// > File: CoreAudio/AudioHardwareBase.h
        ///
        /// > Constant: `kAudioDeviceTransportTypeBluetoothLE`
        case bluetoothLE

        /// Audio devices connected via HDMI.
        ///
        /// > File: CoreAudio/AudioHardwareBase.h
        ///
        /// > Constant: `kAudioDeviceTransportTypeHDMI`
        case hdmi

        /// Audio devices connected via DisplayPort.
        ///
        /// > File: CoreAudio/AudioHardwareBase.h
        ///
        /// > Constant: `kAudioDeviceTransportTypeDisplayPort`
        case displayPort

        /// Audio devices connected via AirPlay.
        ///
        /// > File: CoreAudio/AudioHardwareBase.h
        ///
        /// > Constant: `kAudioDeviceTransportTypeAirPlay`
        case airPlay

        /// Audio devices connected via AVB (Audio Video Bridging).
        ///
        /// > File: CoreAudio/AudioHardwareBase.h
        ///
        /// > Constant: `kAudioDeviceTransportTypeAVB`
        case audioVideoBridging // a.k.a. AVB

        /// Audio devices connected via Thunderbolt.
        ///
        /// > File: CoreAudio/AudioHardwareBase.h
        ///
        /// > Constant: `kAudioDeviceTransportTypeThunderbolt`
        case thunderbolt

        /// Continuity Capture audio devices connected via a cable.
        ///
        /// > File: CoreAudio/AudioHardwareBase.h
        ///
        /// > Constant: `kAudioDeviceTransportTypeContinuityCaptureWired`
        case continuityCaptureWired

        /// Continuity Capture audio devices connected via wireless networking.
        ///
        /// > File: CoreAudio/AudioHardwareBase.h
        ///
        /// > Constant: `kAudioDeviceTransportTypeContinuityCaptureWireless`
        case continuityCaptureWireless

        // MARK: CoreAudio/AudioHardwareDeprecated.h

        /// Automatically-generated aggregate devices.
        ///
        /// > File: CoreAudio/AudioHardwareDeprecated.h
        ///
        /// > Constant: `kAudioDeviceTransportTypeAutoAggregate`
        case autoAggregate

        // MARK: Unknowns - Discovered During Debugging and need to find the source of their constants

        /// Used by Apple "TimeSync Clock"
        case _atac
    }
}

extension AudioDevice.TransportType: Equatable { }

extension AudioDevice.TransportType: Hashable { }

extension AudioDevice.TransportType: CaseIterable { }

extension AudioDevice.TransportType: Sendable { }

// MARK: - Inits

extension AudioDevice.TransportType {
    /// Same as ``init(rawValue:)`` but throws an error instead of returning `nil` when a match is not found.
    nonisolated
    public init(tryingRawValue rawValue: FourCharCode) throws(SwiftCoreAudioError) { // a.k.a. UInt32
        guard let match = Self(rawValue: rawValue) else {
            throw .notYetImplemented(message: "Unhandled/unrecognized audio device transport type value: \(rawValue)")
        }
        self = match
    }
}

// MARK: - RawRepresentable

extension AudioDevice.TransportType: RawRepresentable {
    nonisolated
    public init?(rawValue: FourCharCode) { // a.k.a. UInt32
        guard let match = Self.allCases
            .first(where: { $0.rawValue == rawValue })
        else {
            return nil
        }
        self = match
    }

    nonisolated
    public var rawValue: FourCharCode { // a.k.a. UInt32
        switch self {
        // MARK: CoreAudio/AudioHardwareBase.h

        case .unknown: kAudioDeviceTransportTypeUnknown // 0
        case .builtIn: kAudioDeviceTransportTypeBuiltIn // "bltn"
        case .aggregate: kAudioDeviceTransportTypeAggregate // "grup"
        case .virtual: kAudioDeviceTransportTypeVirtual // "virt"
        case .pci: kAudioDeviceTransportTypePCI // "pci "
        case .usb: kAudioDeviceTransportTypeUSB // "usb "
        case .firewire: kAudioDeviceTransportTypeFireWire // "1394"
        case .bluetooth: kAudioDeviceTransportTypeBluetooth // "blue"
        case .bluetoothLE: kAudioDeviceTransportTypeBluetoothLE // "blea"
        case .hdmi: kAudioDeviceTransportTypeHDMI // "hdmi"
        case .displayPort: kAudioDeviceTransportTypeDisplayPort // "dprt"
        case .airPlay: kAudioDeviceTransportTypeAirPlay // "airp"
        case .audioVideoBridging: kAudioDeviceTransportTypeAVB // "eavb"
        case .thunderbolt: kAudioDeviceTransportTypeThunderbolt // "thun"
        case .continuityCaptureWired: kAudioDeviceTransportTypeContinuityCaptureWired // "ccwd"
        case .continuityCaptureWireless: kAudioDeviceTransportTypeContinuityCaptureWireless // "ccwl"

        // MARK: CoreAudio/AudioHardwareDeprecated.h
        case .autoAggregate: kAudioDeviceTransportTypeAutoAggregate
        case ._atac: 0x6174_6163 // int 1635017059, "atac"
        }
    }
}

extension AudioDevice.TransportType: CustomStringConvertible {
    nonisolated
    public var description: String {
        switch self {
        // MARK: CoreAudio/AudioHardwareBase.h

        case .unknown: "Unknown"
        case .builtIn: "Built-In"
        case .aggregate: "Aggregate"
        case .virtual: "Virtual"
        case .pci: "PCI"
        case .usb: "USB"
        case .firewire: "Firewire"
        case .bluetooth: "Bluetooth"
        case .bluetoothLE: "Bluetooth LE"
        case .hdmi: "HDMI"
        case .displayPort: "Display Port"
        case .airPlay: "AirPlay"
        case .audioVideoBridging: "Audio Video Bridging (AVB)"
        case .thunderbolt: "Thunderbolt"
        case .continuityCaptureWired: "Continuity Capture (Wired)"
        case .continuityCaptureWireless: "Continuity Capture (Wireless)"

        // MARK: CoreAudio/AudioHardwareDeprecated.h
        case .autoAggregate: "Auto-Aggregate"
        case ._atac: "'atac'"
        }
    }
}

#endif
