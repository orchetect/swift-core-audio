//
//  AudioSystem+Objects Tests.swift
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
    struct AudioSystem_Objects_Tests {
        // MARK: - object_forID
        
        @Test
        func object_forID_unknown() throws {
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try AudioSystem.shared.object(forID: 0) // 0 is always unknown
            }
        }
        
        @Test
        func object_forID_system() throws {
            let object = try AudioSystem.shared.object(forID: 1) // 1 is always System
            #expect(object as? AudioSystem != nil)
        }
        
        // MARK: - object_forID_ofType
        
        @Test
        func object_forID_ofType_unknown() throws {
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try AudioSystem.shared.object(forID: 0, ofType: .device) // 0 is always unknown
            }
        }
        
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
