//
//  AudioStream TerminalType Tests.swift
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
struct AudioStream_TerminalType_Tests {
    @Test
    func codable() throws {
        for terminalType in AudioStream.TerminalType.allCases {
            // encode
            let encoder = JSONEncoder()
            let encoded = try encoder.encode(terminalType)

            // analyze encoded data to ensure it encodes as a single value
            let decodedString = try #require(String(data: encoded, encoding: .utf8))
            #expect(decodedString == "\(terminalType.rawValue)")

            // decode
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(AudioStream.TerminalType.self, from: encoded)
            #expect(decoded == terminalType, "\(terminalType.description) failed.")
        }
    }
}

#endif
