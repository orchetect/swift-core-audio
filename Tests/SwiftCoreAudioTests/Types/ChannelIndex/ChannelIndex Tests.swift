//
//  ChannelIndex Tests.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import Testing
import SwiftCoreAudio

@Suite struct ChannelIndex_Tests {
    @Test
    func codable() throws {
        let channelIndex = AudioChannelIndex(index: 1)
        
        // encode
        let encoder = JSONEncoder()
        let encoded = try encoder.encode(channelIndex)
        
        // analyze encoded data to ensure it encodes as a single value
        let decodedString = try #require(String(data: encoded, encoding: .utf8))
        #expect(decodedString == "1")
        
        // decode
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(AudioChannelIndex.self, from: encoded)
        #expect(decoded == channelIndex)
    }
}
