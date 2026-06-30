//
//  AudioStream Direction Tests.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import Foundation
@testable import SwiftCoreAudio
import SwiftProcess
import Testing

/// These are logic-only tests and do not need to be nested under ``SerializedTests``.
@Suite
struct AudioStream_Direction_Tests {
    init() {
        CoreAudioLogging.bootstrap()
    }
    
    @Test
    func codable() throws {
        for direction in AudioStream.Direction.allCases {
            // encode
            let encoder = JSONEncoder()
            let encoded = try encoder.encode(direction)

            // analyze encoded data to ensure it encodes as a single value
            let decodedString = try #require(String(data: encoded, encoding: .utf8))
            #expect(decodedString == "\"\(direction.encodedValue)\"")

            // decode
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(AudioStream.Direction.self, from: encoded)
            #expect(decoded == direction, "\(direction.description) failed.")
        }
    }
}

#endif
