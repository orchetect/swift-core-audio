//
//  AudioUID Tests.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import Testing
import SwiftCoreAudio

/// These are logic-only tests and do not need to be nested under ``SerializedTests``.
@Suite
struct AudioUID_Tests {
    init() {
        CoreAudioLogging.bootstrap()
    }
    
    @Test
    func codable() throws {
        let uid = AudioUID<AnyAudioDevice>("Dummy_UID")

        // encode
        let encoder = JSONEncoder()
        let encoded = try encoder.encode(uid)

        // analyze encoded data to ensure it encodes as a single value
        let decodedString = try #require(String(data: encoded, encoding: .utf8))
        #expect(decodedString == #""Dummy_UID""#)

        // decode
        let decoder = JSONDecoder()

        // decode as same concrete type
        do {
            let decoded = try decoder.decode(AudioUID<AnyAudioDevice>.self, from: encoded)
            #expect(decoded == uid)
        }

        // decode as different concrete type
        do {
            let decoded = try decoder.decode(AudioUID<AudioDevice>.self, from: encoded)
            #expect(decoded.rawValue == uid.rawValue)
        }
    }
}
