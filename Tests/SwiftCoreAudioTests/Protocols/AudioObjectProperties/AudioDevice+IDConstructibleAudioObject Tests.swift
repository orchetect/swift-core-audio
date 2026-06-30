//
//  AudioDevice+IDConstructibleAudioObject Tests.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import Foundation
import SwiftCoreAudio
import Testing

extension SerializedTests {
    @Suite
    struct AudioDevice_IDConstructibleAudioObject_Tests {
        init() {
            CoreAudioLogging.bootstrap()
        }
        
        @Test
        func codable() throws {
            let device = AudioDevice(id: AudioDevice.ID(123))

            // encode
            let encoder = JSONEncoder()
            let encoded = try encoder.encode(device)

            // analyze encoded data to ensure it encodes as a single value
            let decodedString = try #require(String(data: encoded, encoding: .utf8))
            #expect(decodedString == "123")

            // decode
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(AudioDevice.self, from: encoded)
            #expect(decoded == device)
        }
    }
}

#endif
