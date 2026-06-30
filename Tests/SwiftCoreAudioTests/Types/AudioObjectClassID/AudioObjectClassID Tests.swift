//
//  AudioObjectClassID Tests.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import Testing
import SwiftCoreAudio

/// These are logic-only tests and do not need to be nested under ``SerializedTests``.
@Suite
struct AudioObjectClassID_Tests {
    init() {
        CoreAudioLogging.bootstrap()
    }
    
    @Test
    func codable() throws {
        for classID in AudioObjectClassID.allCases {
            // encode
            let encoder = JSONEncoder()
            let encoded = try encoder.encode(classID)

            // analyze encoded data to ensure it encodes as a single value
            let decodedString = try #require(String(data: encoded, encoding: .utf8))
            #expect(decodedString == "\(classID.rawValue)")

            // decode
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(AudioObjectClassID.self, from: encoded)
            #expect(decoded == classID, "\(classID.description) failed.")
        }
    }
}
