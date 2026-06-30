//
//  StereoAudioChannelIndexes Tests.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import Testing
import SwiftCoreAudio

/// These are logic-only tests and do not need to be nested under ``SerializedTests``.
@Suite
struct StereoAudioChannelIndexes_Tests {
    init() {
        CoreAudioLogging.bootstrap()
    }

    @Test
    func codable() throws {
        let channelIndex = StereoAudioChannelIndexes(leftIndex: 1, rightIndex: 2)

        // encode
        let encoder = JSONEncoder()
        let encoded = try encoder.encode(channelIndex)
        
        // analyze encoded data to ensure it encodes as a dictionary
        let decodedString = try #require(String(data: encoded, encoding: .utf8))
        #expect(
            decodedString == #"{"left":1,"right":2}"#
                || decodedString == #"{"right":2,"left":1}"#
        )

        // decode
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(StereoAudioChannelIndexes.self, from: encoded)
        #expect(decoded == channelIndex)

        #expect(decoded.left.index == 1)
        #expect(decoded.right.index == 2)
    }
}
