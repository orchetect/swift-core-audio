//
//  AudioAggregateDevice+UIDIdentifiableAudioObject Tests.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import Foundation
import SwiftCoreAudio
import Testing

extension SerializedTests {
    @Suite
    struct AudioAggregateDevice_UIDIdentifiableAudioObject_Tests {
        init() {
            CoreAudioLogging.bootstrap()
        }
        
        // MARK: uid

        @Test
        func uid_invalid() throws {
            let aggregate = AudioAggregateDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try aggregate.uid
            }
        }

        @Test
        func uid_valid() throws {
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try AudioSystem.shared.makeAggregateDevice(withUID: aggregateUID, isPrivate: true)
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // verify
            #expect(try aggregate.uid == aggregateUID)
        }
    }
}

#endif
