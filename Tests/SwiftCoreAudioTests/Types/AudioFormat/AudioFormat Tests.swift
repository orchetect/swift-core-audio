//
//  AudioFormat Tests.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import Testing
import SwiftCoreAudio

/// These are logic-only tests and do not need to be nested under ``SerializedTests``.
@Suite
struct AudioFormat_Tests {
    init() {
        CoreAudioLogging.bootstrap()
    }

    @Test
    func codable() throws {
        for format in AudioFormat.allCases {
            // encode
            let encoder = JSONEncoder()
            let encoded = try encoder.encode(format)

            // analyze encoded data to ensure it encodes as a single value
            let decodedString = try #require(String(data: encoded, encoding: .utf8))
            #expect(decodedString == "\(format.rawValue)")

            // decode
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(AudioFormat.self, from: encoded)
            #expect(decoded == format, "\(format.description) failed.")
        }
    }
}
