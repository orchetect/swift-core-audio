//
//  AudioBox+AudioObjectProperties Tests.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import CoreAudio
import Foundation
import SwiftCoreAudio
import SwiftProcess
import Testing

extension SerializedTests {
    /// Test select properties inherited from ``AudioObjectProperties`` conformance.
    /// This does not have to be exhaustive.
    @Suite
    struct AudioBox_AudioObjectProperties_Tests {
        // MARK: firmwareVersion
        
        @Test
        func firmwareVersion_invalidID() throws {
            let box = AudioBox(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try box.firmwareVersion
            }
        }
        
        /// Note: This test only runs if BlackHole 2ch is installed.
        @Test(.enabledIfAudioDevicePresent(.blackHole2Ch))
        func audioBoxFirmwareVersion_valid() throws {
            let box = try #require(AudioBox.blackHole2Ch)
            let maybeFirmware = try box.firmwareVersion
            let firmware = try #require(maybeFirmware)
            
            // test that it's a non-empty string, as we can't easily know its
            // exact contents with which to test against
            #expect(!firmware.trimmingCharacters(in: .whitespaces).isEmpty)
        }
    }
}
