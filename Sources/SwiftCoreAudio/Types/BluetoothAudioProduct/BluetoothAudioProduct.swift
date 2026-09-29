//
//  BluetoothAudioProduct.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

/// An enumeration of known Bluetooth hardware IDs for common and popular audio devices, including the Apple AirPods family.
///
/// The majority of these IDs were sourced from: https://theapplewiki.com/wiki/Bluetooth_PIDs
public enum BluetoothAudioProduct {
    /// AirPods (1st gen)
    case airPodsGen1

    /// AirPods (2nd gen)
    case airPodsGen2

    /// AirPods (3rd gen)
    case airPodsGen3

    /// AirPods 4 (ANC)
    case airPodsGen4

    // TODO: add AirPods Gen 5 when product ID info is known

    /// AirPods Pro (1st gen)
    case airPodsProGen1

    /// AirPods Pro (2nd gen / Lightning)
    case airPodsProGen2

    /// AirPods Pro (2nd gen / USB-C)
    case airPodsProGen2USBC

    /// AirPods Pro (1st gen)
    case airPodsProGen3

    /// AirPods Pro (Unreleased / TBD)
    case airPodsProUnreleased1

    /// AirPods Pro (Unreleased / TBD)
    case airPodsProUnreleased2

    /// AirPods Max (1st gen / Lightning)
    case airPodsMaxGen1

    /// AirPods Max (Gen 1 / USB-C)
    case airPodsMaxGen1USBC

    /// AirPods Max (2nd gen)
    case airPodsMaxGen2

    /// Beats 360
    case beats360

    /// Beats Fit Pro
    case beatsFitPro

    /// Beats Flex
    case beatsFlex

    /// Beats Pill 3
    case beatsPill3

    /// Beats Pill+
    case beatsPillPlus

    /// Powerbeats 3
    case beatsPowerbeats3

    /// Powerbeats (4th gen)
    case beatsPowerbeatsGen4

    /// Powerbeats Pro
    case beatsPowerbeatsPro

    /// Beats Solo 4
    case beatsSolo4

    /// Beats Solo Buds
    case beatsSoloBuds

    /// Beats Solo Buds (Unreleased)
    case beatsSoloBudsUnreleased1

    /// Beats Solo Pro
    case beatsSoloPro

    /// Beats Solo Wireless
    case beatsSoloWireless

    /// Beats Studio Buds
    case beatsStudioBuds

    /// Beats Studio Buds +
    case beatsStudioBudsPlus

    /// Beats Studio Pro
    case beatsStudioPro

    /// Beats Studio Wireless
    case beatsStudioWireless

    /// BeatsX
    case beatsX
}

extension BluetoothAudioProduct: Equatable { }

extension BluetoothAudioProduct: Hashable { }

extension BluetoothAudioProduct: Sendable { }

extension BluetoothAudioProduct: CaseIterable { }

// MARK: - Vendor & Product ID

extension BluetoothAudioProduct {
    /// Device hardware vendor ID.
    ///
    /// Bluetooth Classic devices have a Vendor ID and Product ID to identify themselves to other devices.
    /// The Bluetooth Vendor ID for Apple is `0x004C`.
    ///
    /// Bluetooth Low Energy doesn't use a Product ID, but the vendor ID `0x004C` is still used in
    /// advertisement data and other places.
    ///
    /// For some accessories supporting both USB and Bluetooth (such as Magic Keyboards), it seems the product
    /// ID is the same for both USB and Bluetooth, but it's not yet clear if this happens with headphones too.
    public var vendorID: UInt16 {
        0x004C
    }

    /// Device hardware product ID.
    public var productID: UInt16 {
        switch self {
        case .airPodsGen1: 0x2002
        case .airPodsGen2: 0x200F
        case .airPodsGen3: 0x2013
        case .airPodsGen4: 0x201B
        case .airPodsProGen1: 0x200E
        case .airPodsProGen2: 0x2014
        case .airPodsProGen2USBC: 0x2024
        case .airPodsProGen3: 0x2027
        case .airPodsProUnreleased1: 0x202B
        case .airPodsProUnreleased2: 0x202C
        case .airPodsMaxGen1: 0x200A
        case .airPodsMaxGen1USBC: 0x201F
        case .airPodsMaxGen2: 0x202D
        case .beats360: 0x2038
        case .beatsFitPro: 0x2012
        case .beatsFlex: 0x2010
        case .beatsPill3: 0x201A
        case .beatsPillPlus: 0x2600
        case .beatsPowerbeats3: 0x2003
        case .beatsPowerbeatsGen4: 0x200D
        case .beatsPowerbeatsPro: 0x200B
        case .beatsSolo4: 0x2025
        case .beatsSoloBuds: 0x2026
        case .beatsSoloBudsUnreleased1: 0x2031
        case .beatsSoloPro: 0x200C
        case .beatsSoloWireless: 0x2006
        case .beatsStudioBuds: 0x2011
        case .beatsStudioBudsPlus: 0x2016
        case .beatsStudioPro: 0x2017
        case .beatsStudioWireless: 0x2009
        case .beatsX: 0x2005
        }
    }

    /// Initialize from hardware vendor ID & product ID.
    public init?(vendorID: UInt16 = 0x004C, productID: UInt16) {
        guard let match = Self.allCases.filter({ $0.vendorID == vendorID && $0.productID == productID }).first
        else { return nil }
        self = match
    }
}

// MARK: - Core Audio Device Model Name

extension BluetoothAudioProduct {
    /// The known *model name* property value string returned by Core Audio from the audio device.
    ///
    /// The convention Apple uses for model name string for most of their Bluetooth audio devices (ie:
    /// AirPods) is to return the Bluetooth hardware product ID & vendor ID in a shortened format.
    ///
    /// For example, for AirPods (gen 1), the value returned for the model name property of the Core Audio
    /// device would be `"200e 4c"` which represents the product ID followed by the vendor ID, both
    /// expressed as hexadecimal values without leading zeros. Technically the vendor ID is `0x004C` but
    /// the leading zero byte is omitted.
    ///
    /// This format is not strictly enforced for any reason. It is merely a convention Apple decided on
    /// but this convention could be broken at any time for any future audio products.
    public var coreAudioDeviceModelName: String {
        // TODO: these could be computed from the `productID` and `vendorID` properties, but for now string literals will suffice
        switch self {
        case .airPodsGen1: "2002 4c"
        case .airPodsGen2: "200f 4c"
        case .airPodsGen3: "2013 4c"
        case .airPodsGen4: "201b 4c"
        case .airPodsProGen1: "200e 4c"
        case .airPodsProGen2: "2014 4c"
        case .airPodsProGen2USBC: "2024 4c"
        case .airPodsProGen3: "2027 4c"
        case .airPodsProUnreleased1: "202b 4c"
        case .airPodsProUnreleased2: "202c 4c"
        case .airPodsMaxGen1: "200a 4c"
        case .airPodsMaxGen1USBC: "201f 4c"
        case .airPodsMaxGen2: "202d 4c"
        case .beats360: "2038 4c"
        case .beatsFitPro: "2012 4c"
        case .beatsFlex: "2010 4c"
        case .beatsPill3: "201a 4c"
        case .beatsPillPlus: "2600 4c"
        case .beatsPowerbeats3: "2003 4c"
        case .beatsPowerbeatsGen4: "200d 4c"
        case .beatsPowerbeatsPro: "200b 4c"
        case .beatsSolo4: "2025 4c"
        case .beatsSoloBuds: "2026 4c"
        case .beatsSoloBudsUnreleased1: "2031 4c"
        case .beatsSoloPro: "200c 4c"
        case .beatsSoloWireless: "2006 4c"
        case .beatsStudioBuds: "2011 4c"
        case .beatsStudioBudsPlus: "2016 4c"
        case .beatsStudioPro: "2017 4c"
        case .beatsStudioWireless: "2009 4c"
        case .beatsX: "2005 4c"
        }
    }

    /// Constructs by parsing an audio device's *model name* property string.
    ///
    /// The convention Apple uses for model name string for most of their Bluetooth audio devices (ie:
    /// AirPods) is to return the Bluetooth hardware product ID & vendor ID in a shortened format.
    ///
    /// For example, for AirPods (gen 1), the value returned for the model name property of the Core Audio
    /// device would be `"200e 4c"` which represents the product ID followed by the vendor ID, both
    /// expressed as hexadecimal values without leading zeros. Technically the vendor ID is `0x004C` but
    /// the leading zero byte is omitted.
    ///
    /// This format is not strictly enforced for any reason. It is merely a convention Apple decided on
    /// but this convention could be broken at any time for any future audio products.
    public init?(coreAudioDeviceModelName: String) {
        // TODO: instead of matching exact model UID string verbatim, a more lenient parser could be implemented that parses out the product ID and vendor ID and allows for one or two byte hex strings for either
        guard let match = Self.allCases
            .filter({ $0.coreAudioDeviceModelName.caseInsensitiveCompare(coreAudioDeviceModelName) == .orderedSame })
            .first
        else { return nil }
        self = match
    }
}

// MARK: - SF Symbol

extension BluetoothAudioProduct {
    /// Returns a SF Symbol image name appropriate for the audio product.
    @available(macOS 11, macCatalyst 13, iOS 13, tvOS 13, watchOS 6, visionOS 1, *) // SF Symbols 1.0
    public var systemImageName: String {
        switch self {
        case .airPodsGen1: AudioDeviceSFSymbol.airPodsGen1And2
        case .airPodsGen2: AudioDeviceSFSymbol.airPodsGen1And2
        case .airPodsGen3: AudioDeviceSFSymbol.airPodsGen3
        case .airPodsGen4: AudioDeviceSFSymbol.airPodsGen4
        case .airPodsProGen1: AudioDeviceSFSymbol.airPodsProGen1And2
        case .airPodsProGen2: AudioDeviceSFSymbol.airPodsProGen1And2
        case .airPodsProGen2USBC: AudioDeviceSFSymbol.airPodsProGen1And2
        case .airPodsProGen3: AudioDeviceSFSymbol.airPodsProGen3
        case .airPodsProUnreleased1: AudioDeviceSFSymbol.airPodsGen1And2
        case .airPodsProUnreleased2: AudioDeviceSFSymbol.airPodsGen1And2
        case .airPodsMaxGen1: AudioDeviceSFSymbol.airPodsMax
        case .airPodsMaxGen1USBC: AudioDeviceSFSymbol.airPodsMax
        case .airPodsMaxGen2: AudioDeviceSFSymbol.airPodsMax
        case .beats360: AudioDeviceSFSymbol.beatsHeadphones
        case .beatsFitPro: AudioDeviceSFSymbol.beatsFitPro
        case .beatsFlex: AudioDeviceSFSymbol.beatsEarbuds
        case .beatsPill3: AudioDeviceSFSymbol.beatsPill
        case .beatsPillPlus: AudioDeviceSFSymbol.beatsPill
        case .beatsPowerbeats3: AudioDeviceSFSymbol.beatsPowerbeats3
        case .beatsPowerbeatsGen4: AudioDeviceSFSymbol.beatsPowerbeats3
        case .beatsPowerbeatsPro: AudioDeviceSFSymbol.beatsPowerbeatsPro
        case .beatsSolo4: AudioDeviceSFSymbol.beatsSoloHeadphones
        case .beatsSoloBuds: AudioDeviceSFSymbol.beatsSoloEarbuds
        case .beatsSoloBudsUnreleased1: AudioDeviceSFSymbol.beatsSoloEarbuds
        case .beatsSoloPro: AudioDeviceSFSymbol.beatsSoloHeadphones
        case .beatsSoloWireless: AudioDeviceSFSymbol.beatsSoloHeadphones
        case .beatsStudioBuds: AudioDeviceSFSymbol.beatsStudioEarbuds
        case .beatsStudioBudsPlus: AudioDeviceSFSymbol.beatsStudioEarbuds
        case .beatsStudioPro: AudioDeviceSFSymbol.beatsStudioHeadphones
        case .beatsStudioWireless: AudioDeviceSFSymbol.beatsStudioHeadphones
        case .beatsX: AudioDeviceSFSymbol.beatsEarbuds
        }
    }
}
