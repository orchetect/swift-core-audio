//
//  AudioDevice TransportType Tests.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import Foundation
import SwiftCoreAudio
import SwiftProcess
import Testing

/// These are logic-only tests and do not need to be nested under ``SerializedTests``.
@Suite
struct AudioDevice_TransportType_Tests {
    @Test
    func initKnownValue() {
        #expect(AudioDevice.TransportType(rawValue: kAudioDeviceTransportTypeAggregate) == .aggregate)
    }

    @Test
    func returnKnownValue() {
        #expect(AudioDevice.TransportType.aggregate.rawValue == kAudioDeviceTransportTypeAggregate)
    }

    @Test
    func initInvalidValue() {
        #expect(AudioDevice.TransportType(rawValue: 123_456) == nil) // bogus number
    }

    @Test
    func codable() throws {
        for transportType in AudioDevice.TransportType.allCases {
            // encode
            let encoder = JSONEncoder()
            let encoded = try encoder.encode(transportType)

            // analyze encoded data to ensure it encodes as a single value
            let decodedString = try #require(String(data: encoded, encoding: .utf8))
            #expect(decodedString == "\(transportType.rawValue)")

            // decode
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(AudioDevice.TransportType.self, from: encoded)
            #expect(decoded == transportType, "\(transportType.description) failed.")
        }
    }
}

#endif
