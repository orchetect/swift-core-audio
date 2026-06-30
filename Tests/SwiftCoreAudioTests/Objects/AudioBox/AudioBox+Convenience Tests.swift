//
//  AudioBox+Convenience Tests.swift
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
    struct AudioBox_Convenience_Tests {
        init() {
            CoreAudioLogging.bootstrap()
        }
        
        // MARK: isPresent

        @Test
        func isPresent_invalidID() {
            let box = AudioBox(id: .randomUnused)
            #expect(!box.isPresent)
        }

        /// Note: This test only runs if BlackHole 2ch is installed.
        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func isPresent_valid() throws {
            let box = try #require(AudioBox.blackHole2Ch)
            #expect(box.isPresent)
        }
    }
}
