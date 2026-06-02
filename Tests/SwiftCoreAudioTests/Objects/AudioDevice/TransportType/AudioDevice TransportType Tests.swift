//
//  AudioDevice TransportType Tests.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
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
}

#endif
