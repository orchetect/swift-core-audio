//
//  AudioID Tests.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import Testing
import SwiftCoreAudio

/// These are logic-only tests and do not need to be nested under ``SerializedTests``.
@Suite
struct AudioID_Tests {
    init() {
        CoreAudioLogging.bootstrap()
    }
    
    @Test
    func codable() throws {
        let id = AudioID<AnyAudioObject>(123)

        // encode
        let encoder = JSONEncoder()
        let encoded = try encoder.encode(id)

        // analyze encoded data to ensure it encodes as a single value
        let decodedString = try #require(String(data: encoded, encoding: .utf8))
        #expect(decodedString == "123")

        // decode
        let decoder = JSONDecoder()

        // decode as same concrete type
        do {
            let decoded = try decoder.decode(AudioID<AnyAudioObject>.self, from: encoded)
            #expect(decoded == id)
        }

        // decode as different concrete type
        do {
            let decoded = try decoder.decode(AudioID<AudioDevice>.self, from: encoded)
            #expect(decoded.rawValue == id.rawValue)
        }
    }
}
