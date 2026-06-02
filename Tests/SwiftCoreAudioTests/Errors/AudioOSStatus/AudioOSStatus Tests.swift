//
//  AudioOSStatus Tests.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import CoreAudio
import SwiftCoreAudio
import Testing

/// These are logic-only tests and do not need to be nested under ``SerializedTests``.
@Suite
struct AudioOSStatus_Tests {
    /// Ensure that `noErr` (value `0`) is allowed.
    @Test
    func init_RawValue_noErr() {
        #expect(AudioOSStatus(rawValue: 0) == .noError)
    }
    
    /// Spot-check rawValue init using a typical case.
    @Test
    func init_RawValue_typical() throws {
        let error = try #require(AudioOSStatus(rawValue: kAudioHardwareBadObjectError))
        #expect(error == .badObject)
    }
    
    /// Check that all cases can re-construct themself from their `rawValue`.
    /// This can reveal the presence of unintentional duplicate constants.
    @Test
    func init_RawValue_allCases() throws {
        for status in AudioOSStatus.allCases {
            let rawValue = status.rawValue
            let reconstructedStatus = AudioOSStatus(rawValue: rawValue)
            #expect(reconstructedStatus == status)
        }
    }
    
    /// Spot-check a typical case to ensure the expected strings are being produced.
    @Test
    func stringProperties() {
        #expect(AudioOSStatus.badObject.constantName == "kAudioHardwareBadObjectError")
        #expect(AudioOSStatus.badObject.constantDescription == "The audio object does not exist.")
        
        #expect(AudioOSStatus.badObject.description == "The audio object does not exist. (kAudioHardwareBadObjectError)")
        
        #expect("\(AudioOSStatus.badObject)" == "The audio object does not exist. (kAudioHardwareBadObjectError)")
    }
}
