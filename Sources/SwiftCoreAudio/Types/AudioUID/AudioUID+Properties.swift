//
//  AudioUID+Properties.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import Foundation

extension AudioUID where Object: AudioDeviceProperties {
    /// Returns `true` if the device is a BlackHole virtual loopback driver.
    ///
    /// See: https://github.com/ExistentialAudio/BlackHole
    public var isBlackHole: Bool {
        rawValue.isBlackHoleDeviceUID
    }
}

// MARK: - Internal Helpers

extension StringProtocol {
    /// Returns `true` if the string is a device UID used by a BlackHole virtual loopback driver.
    ///
    /// See: https://github.com/ExistentialAudio/BlackHole
    var isBlackHoleDeviceUID: Bool {
        let pattern = #"^BlackHole[\d]{1,4}ch_UID$"#
        let string = String(self)
        let range = NSRange(location: 0, length: string.count)
        let matches = try? NSRegularExpression(pattern: pattern)
            .matches(in: string, range: range)
        guard let matches else { return false }
        return !matches.isEmpty
    }

    /// Returns `true` if the string is a device model UID used by a BlackHole virtual loopback driver.
    ///
    /// See: https://github.com/ExistentialAudio/BlackHole
    var isBlackHoleModelUID: Bool {
        let pattern = #"^BlackHole[\d]{1,4}ch_ModelUID$"#
        let string = String(self)
        let range = NSRange(location: 0, length: string.count)
        let matches = try? NSRegularExpression(pattern: pattern)
            .matches(in: string, range: range)
        guard let matches else { return false }
        return !matches.isEmpty
    }
}

#endif
