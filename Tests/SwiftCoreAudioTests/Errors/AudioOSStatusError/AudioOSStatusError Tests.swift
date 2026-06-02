//
//  AudioOSStatusError Tests.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import CoreAudio
import SwiftCoreAudio
import Testing

/// These are logic-only tests and do not need to be nested under ``SerializedTests``.
@Suite
struct AudioOSStatusError_Tests {
    /// Ensure that `noErr` (value `0`) does not construct an error.
    @Test
    func init_RawValue_noError() {
        #expect(AudioOSStatusError(rawValue: 0) == nil)
    }
    
    /// Spot-check rawValue init using a typical case.
    @Test
    func init_RawValue_typical() throws {
        let error = try #require(AudioOSStatusError(rawValue: kAudioHardwareBadObjectError))
        #expect(error.status == .badObject)
    }
    
    /// Spot-check a typical case to ensure the expected strings are being produced.
    @Test
    func stringProperties() throws {
        let error = try #require(AudioOSStatusError(status: .badObject))
        
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
}
