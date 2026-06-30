//
//  AudioSystem+Objects Tests.swift
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
    struct AudioSystem_Objects_Tests {
        init() {
            CoreAudioLogging.bootstrap()
        }
        
        // MARK: - object_forID

        #if compiler(>=6.2)
        @Test
        func object_forID_unknown() async throws {
            await #expect(processExitsWith: .failure) {
                // in debug builds, this method asserts when 0 is passed
                _ = try AudioSystem.shared.object(forID: 0) // 0 is always unknown
            }
        }
        #endif
        
        @Test
        func object_forID_system() throws {
            let object = try AudioSystem.shared.object(forID: 1) // 1 is always System
            #expect(object as? AudioSystem != nil)
        }

        // MARK: - object_forID_ofType

        #if compiler(>=6.2)
        @Test
        func object_forID_ofType_unknown() async throws {
            await #expect(processExitsWith: .failure) {
                // in debug builds, this method asserts when 0 is passed
                _ = try AudioSystem.shared.object(forID: 0, ofType: .device) // 0 is always unknown
            }
        }
        #endif

        @Test
        func object_forID_ofType_valid() throws {
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try AudioSystem.shared.makeAggregateDevice(withUID: aggregateUID, isPrivate: true)
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            let object = try AudioSystem.shared.object(forID: aggregate.id.rawValue, ofType: .aggregate)
            #expect(object == aggregate)

            // requesting wrong object type
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try AudioSystem.shared.object(forID: aggregate.id.rawValue, ofType: .box)
            }
        }

        // MARK: - object_forUID

        @Test
        func object_forUID_invalid() throws {
            let randomUID: AudioDevice.UID = .random
            let object = try AudioSystem.shared.object(forUID: randomUID)
            #expect(object == nil)
        }

        @Test
        func object_forUID_valid() throws {
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try AudioSystem.shared.makeAggregateDevice(withUID: aggregateUID, isPrivate: true)
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // verify
            #expect(try AudioSystem.shared.object(forUID: aggregateUID)?.id.rawValue == aggregate.id.rawValue)
        }
    }
}
