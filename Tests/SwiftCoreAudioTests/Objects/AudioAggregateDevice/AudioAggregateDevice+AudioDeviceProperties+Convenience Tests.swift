//
//  AudioAggregateDevice+AudioDeviceProperties+Convenience Tests.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import Foundation
import SwiftCoreAudio
import Testing

extension SerializedTests {
    /// Test select convenience properties inherited from ``AudioDeviceProperties`` conformance.
    /// This does not have to be exhaustive.
    @Suite
    struct AudioAggregateDevice_AudioDeviceProperties_Convenience_Tests {
        init() {
            CoreAudioLogging.bootstrap()
        }
        
        // MARK: isPresent

        @Test
        func isPresent_invalid() {
            let aggregate = AudioAggregateDevice(id: .randomUnused)
            #expect(aggregate.isPresent == false)
        }

        @Test
        func isPresent_valid() throws {
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try AudioSystem.shared.makeAggregateDevice(withUID: aggregateUID, isPrivate: true)
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // verify
            #expect(aggregate.isPresent == true)

            // destroy the aggregate
            try AudioSystem.shared.destroyAggregateDevice(aggregate)

            // verify
            #expect(aggregate.isPresent == false)
        }
    }
}

#endif
