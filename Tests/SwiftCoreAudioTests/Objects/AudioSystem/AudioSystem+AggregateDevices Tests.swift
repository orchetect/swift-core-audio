//
//  AudioSystem+AggregateDevices Tests.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
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
        /// Test Core Audio's behavior when you attempt to create two aggregates without a UID.
        @Test
        func missingUID() throws {
            let composition = AudioAggregateDevice.Composition(uid: nil)
            // Core Audio throws an error if you do not supply a UID; it's mandatory
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try AudioSystem.shared.makeAggregateDevice(composition: composition)
            }
        }
        
        /// Test Core Audio's behavior when you attempt to create two aggregates with the same UID.
        @Test
        func recreateSameAggregate() throws {
            // create an aggregate
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try AudioSystem.shared.makeAggregateDevice(withUID: aggregateUID, isPrivate: true)
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope
            
            // attempt to create another aggregate with the same UID; Core Audio should throw an error
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try AudioSystem.shared.makeAggregateDevice(withUID: aggregateUID, isPrivate: true)
            }
        }
    }
}
