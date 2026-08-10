//
//  AudioSystem+AggregateDevices Tests.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import CoreAudio
import Foundation
import SwiftCoreAudio
import SwiftProcess
import Testing

extension SerializedTests {
    @Suite
    struct AudioSystem_AggregateDevices_Tests {
        init() {
            CoreAudioLogging.bootstrap()
        }

        @Test
        func makeAndDestroyAggregateDevice_nonAsync() /* NOT ASYNC */ throws {
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try /* NOT AWAIT */ AudioSystem.shared.makeAggregateDevice(withUID: aggregateUID, isPrivate: true)
            try /* NOT AWAIT */ AudioSystem.shared.destroyAggregateDevice(aggregate)
        }

        @Test
        func makeAndDestroyAggregateDevice_async() async throws {
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(withUID: aggregateUID, isPrivate: true)
            try await AudioSystem.shared.destroyAggregateDevice(aggregate)
        }

        /// Test Core Audio's behavior when you attempt to create two aggregates without a UID.
        @Test
        func missingUID() async throws {
            let composition = AudioAggregateDevice.Composition(uid: nil)
            // Core Audio throws an error if you do not supply a UID; it's mandatory
            await #expect(throws: SwiftCoreAudioError.self) {
                _ = try await AudioSystem.shared.makeAggregateDevice(composition: composition)
            }
        }

        /// Test Core Audio's behavior when you attempt to create two aggregates with the same UID.
        @Test
        func recreateSameAggregate_nonAsync() /* NOT ASYNC */ throws {
            // create an aggregate
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try /* NOT AWAIT */ AudioSystem.shared.makeAggregateDevice(withUID: aggregateUID, isPrivate: true)
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // attempt to create another aggregate with the same UID; Core Audio should throw an error
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try /* NOT AWAIT */ AudioSystem.shared.makeAggregateDevice(withUID: aggregateUID, isPrivate: true)
            }
        }

        /// Test Core Audio's behavior when you attempt to create two aggregates with the same UID.
        @Test
        func recreateSameAggregate_async() async throws {
            // create an aggregate
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(withUID: aggregateUID, isPrivate: true)
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // attempt to create another aggregate with the same UID; Core Audio should throw an error
            await #expect(throws: SwiftCoreAudioError.self) {
                _ = try await AudioSystem.shared.makeAggregateDevice(withUID: aggregateUID, isPrivate: true)
            }
        }
    }
}
