//
//  AudioDeviceSFSymbol.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

/// A small catalog of SF Symbol names for audio devices with corresponding minimum platform requirements.
///
/// The most recent image is returned where possible, with fallback images supplied for older platforms
/// where necessary. All static properties must eventually fallback to an image that is compatible with
/// SF Symbols 1.0 so a fallback image is always guaranteed for every static property.
@available(macOS 11, macCatalyst 13, iOS 13, tvOS 13, watchOS 6, visionOS 1, *) // SF Symbols 1.0
enum AudioDeviceSFSymbol: SendableMetatype {
    // MARK: - Generic (Fallback Images)

    static var _genericHeadphones: String {
        "headphones" // SF 1.0
    }

    static var _genericDesktopComputer: String {
        "desktopcomputer" // SF 1.0
    }

    // MARK: - AirPods

    static var airPodsGen1And2: String {
        if SFSymbolsVersion.v2_0.isAvailable {
            "airpods" // SF 2.0
        } else {
            _genericHeadphones
        }
    }

    static var airPodsGen3: String {
        if SFSymbolsVersion.v3_2.isAvailable {
            "airpods.gen3" // SF 3.2
        } else {
            airPodsGen1And2
        }
    }

    static var airPodsGen4: String {
        if SFSymbolsVersion.v6_2.isAvailable {
            "airpods.gen4" // SF 6.2
        } else {
            airPodsGen3
        }
    }

    // MARK: - AirPods Pro

    static var airPodsProGen1And2: String {
        if SFSymbolsVersion.v6_0.isAvailable {
            "airpods.pro" // SF 6.0
        } else if SFSymbolsVersion.v2_0.isAvailable {
            "airpodspro" // SF 2.0
        } else {
            _genericHeadphones
        }
    }

    static var airPodsProGen3: String {
        if SFSymbolsVersion.v27_0.isAvailable {
            "airpods.pro.gen3"
        } else {
            airPodsGen1And2
        }
    }

    // MARK: - AirPods Max

    static var airPodsMax: String {
        if SFSymbolsVersion.v6_0.isAvailable {
            "airpods.max" // SF 6.0
        } else if SFSymbolsVersion.v2_2.isAvailable {
            "airpodsmax" // SF 2.2; deprecated
        } else {
            _genericHeadphones
        }
    }

    // MARK: - Beats

    static var beatsHeadphones: String {
        if SFSymbolsVersion.v3_0.isAvailable {
            "beats.headphones" // SF 3.0
        } else {
            _genericHeadphones
        }
    }

    static var beatsEarbuds: String {
        if SFSymbolsVersion.v3_0.isAvailable {
            "beats.earphones" // SF 3.0
        } else {
            _genericHeadphones
        }
    }

    static var beatsFitPro: String {
        if SFSymbolsVersion.v5_0.isAvailable {
            "beats.fitpro" // SF 5.0
        } else if SFSymbolsVersion.v3_2.isAvailable {
            "beats.fit.pro" // SF 3.2
        } else {
            _genericHeadphones
        }
    }

    static var beatsPill: String {
        if SFSymbolsVersion.v5_4.isAvailable {
            "beats.pill.fill" // SF 5.4
        } else {
            _genericHeadphones
        }
    }

    static var beatsSoloHeadphones: String {
        beatsHeadphones
    }

    static var beatsSoloEarbuds: String {
        if SFSymbolsVersion.v5_4.isAvailable {
            "beats.solobuds" // SF 5.4
        } else {
            beatsEarbuds
        }
    }

    static var beatsStudioHeadphones: String {
        beatsHeadphones
    }

    static var beatsStudioEarbuds: String {
        if SFSymbolsVersion.v3_0.isAvailable {
            "beats.studiobuds" // SF 3.0
        } else {
            beatsEarbuds
        }
    }

    static var beatsPowerbeats: String {
        if SFSymbolsVersion.v3_0.isAvailable {
            "beats.powerbeats" // SF 3.0
        } else {
            beatsEarbuds
        }
    }

    static var beatsPowerbeats3: String {
        if SFSymbolsVersion.v3_0.isAvailable {
            "beats.powerbeats3" // SF 3.0
        } else {
            beatsEarbuds
        }
    }

    static var beatsPowerbeatsPro: String {
        if SFSymbolsVersion.v6_0.isAvailable {
            "beats.powerbeats.pro" // SF 6.0
        } else if SFSymbolsVersion.v3_0.isAvailable {
            "beats.powerbeatspro" // SF 3.0
        } else {
            beatsEarbuds
        }
    }

    // MARK: - Mac

    static var macBook: String {
        if SFSymbolsVersion.v2_0.isAvailable {
            "laptopcomputer" // SF 2.0
        } else {
            _genericDesktopComputer
        }
    }

    static var macMini: String {
        if SFSymbolsVersion.v2_0.isAvailable {
            "macmini.fill" // SF 2.0
        } else {
            _genericDesktopComputer
        }
    }

    static var macStudio: String {
        if SFSymbolsVersion.v4_0.isAvailable {
            "macstudio.fill" // SF 4.0
        } else {
            _genericDesktopComputer
        }
    }

    static var iMac: String {
        _genericDesktopComputer
    }

    static var macProGen1: String {
        if SFSymbolsVersion.v2_0.isAvailable {
            "macpro.gen1" // SF 2.0
        } else {
            _genericDesktopComputer
        }
    }

    static var macProGen2: String {
        if SFSymbolsVersion.v2_0.isAvailable {
            "macpro.gen2" // SF 2.0
        } else {
            _genericDesktopComputer
        }
    }

    static var macProGen3: String {
        if SFSymbolsVersion.v2_0.isAvailable {
            "macpro.gen3" // SF 2.0
        } else {
            _genericDesktopComputer
        }
    }
}
