//
//  SwiftCoreAudioError Tests.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import CoreAudio
import SwiftCoreAudio
import Testing

/// These are logic-only tests and do not need to be nested under ``SerializedTests``.
@Suite
struct SwiftCoreAudioError_Tests {
    /// Spot-check equatable.
    @Test
    func equatable_typical() throws {
        let osStatus = try #require(AudioOSStatusError(rawValue: kAudioHardwareBadObjectError))
        let error = SwiftCoreAudioError.osStatus(osStatus)
        #expect(error == .osStatus(osStatus, message: nil))
    }

    /// Spot-check a typical case to ensure the expected strings are being produced.
    @Test
    func stringProperties_noMessage() throws {
        let osStatus = try #require(AudioOSStatusError(rawValue: kAudioHardwareBadObjectError))
        let error = SwiftCoreAudioError.osStatus(osStatus)

        // string interpolation
        #expect(
            "\(error)"
                == "The audio object does not exist. (kAudioHardwareBadObjectError)"
        )

        // localizedDescription
        #expect(
            error.localizedDescription
                == "The audio object does not exist. (kAudioHardwareBadObjectError)"
        )
    }

    /// Spot-check a typical case to ensure the expected strings are being produced.
    @Test
    func stringProperties_withMessage() throws {
        let osStatus = try #require(AudioOSStatusError(rawValue: kAudioHardwareBadObjectError))
        let error = SwiftCoreAudioError.osStatus(osStatus, message: "A message.")

        // string interpolation
        #expect(
            "\(error)"
                == "The audio object does not exist. (kAudioHardwareBadObjectError) (A message.)"
        )

        // localizedDescription
        #expect(
            error.localizedDescription
                == "The audio object does not exist. (kAudioHardwareBadObjectError) (A message.)"
        )
    }
}
