//
//  AudioBox+UIDIdentifiableAudioObject Tests.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import Foundation
import SwiftCoreAudio
import Testing

extension SerializedTests {
    @Suite
    struct AudioBox_UIDIdentifiableAudioObject_Tests {
        // MARK: uid
        
        @Test
        func uid_invalid() throws {
            let aggregate = AudioBox(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try aggregate.uid
            }
        }
        
        @Test
        func uid_valid() throws {
            guard let box = try AudioSystem.shared.boxes.first(where: { (try? $0.uid) != nil })
            else {
                withKnownIssue {
                    Issue.record("No available audio boxes in the system to test. Skipping test.")
                }
                return
            }
            let uid = try box.uid
            
            // verify
            #expect(try box.uid == uid)
        }
    }
}

#endif
