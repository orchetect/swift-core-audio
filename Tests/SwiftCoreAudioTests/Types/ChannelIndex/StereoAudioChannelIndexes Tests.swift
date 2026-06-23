//
//  StereoAudioChannelIndexes Tests.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import Testing
import SwiftCoreAudio

@Suite struct StereoAudioChannelIndexes_Tests {
    @Test
    func codable() throws {
        let channelIndex = StereoAudioChannelIndexes(leftIndex: 1, rightIndex: 2)

        // encode
        let encoder = JSONEncoder()
        let encoded = try encoder.encode(channelIndex)
        
        // analyze encoded data to ensure it encodes as a dictionary
        let decodedString = try #require(String(data: encoded, encoding: .utf8))
        #expect(decodedString == #"{"left":1,"right":2}"#)

        // decode
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(StereoAudioChannelIndexes.self, from: encoded)
        #expect(decoded == channelIndex)

        #expect(decoded.left.index == 1)
        #expect(decoded.right.index == 2)
    }
}
