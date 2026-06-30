//
//  AudioBox+Properties Tests.swift
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
    struct AudioBox_Properties_Tests {
        init() {
            CoreAudioLogging.bootstrap()
        }
        
        // MARK: boxUID

        @Test
        func boxUID_invalidID() throws {
            let box = AudioBox(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try box.boxUID
            }
        }

        /// Note: This test only runs if BlackHole 2ch is installed.
        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func boxUID_valid() throws {
            let box = try #require(AudioBox.blackHole2Ch)
            #expect(try box.boxUID == .blackHole2Ch)
        }

        // MARK: transportType

        @Test
        func transportType_invalidID() throws {
            let box = AudioBox(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try box.transportType
            }
        }

        /// Note: This test only runs if BlackHole 2ch is installed.
        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func transportType_valid() throws {
            let box = try #require(AudioBox.blackHole2Ch)
            #expect(try box.transportType == .virtual)
        }

        // MARK: hasAudio

        @Test
        func hasAudio_invalidID() throws {
            let box = AudioBox(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try box.hasAudio
            }
        }

        /// Note: This test only runs if BlackHole 2ch is installed.
        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func hasAudio_valid() throws {
            let box = try #require(AudioBox.blackHole2Ch)
            #expect(try box.hasAudio == true)
        }

        // MARK: hasVideo

        @Test
        func hasVideo_invalidID() throws {
            let box = AudioBox(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try box.hasVideo
            }
        }

        /// Note: This test only runs if BlackHole 2ch is installed.
        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func hasVideo_valid() throws {
            let box = try #require(AudioBox.blackHole2Ch)
            #expect(try box.hasVideo == false)
        }

        // MARK: hasMIDI

        @Test
        func hasMIDI_invalidID() throws {
            let box = AudioBox(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try box.hasMIDI
            }
        }

        /// Note: This test only runs if BlackHole 2ch is installed.
        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func hasMIDI_valid() throws {
            let box = try #require(AudioBox.blackHole2Ch)
            #expect(try box.hasMIDI == false)
        }

        // MARK: isProtected

        @Test
        func isProtected_invalidID() throws {
            let box = AudioBox(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try box.isProtected
            }
        }

        /// Note: This test only runs if BlackHole 2ch is installed.
        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func isProtected_valid() throws {
            let box = try #require(AudioBox.blackHole2Ch)
            #expect(try box.isProtected == false)
        }

        // MARK: isEnabled ("acquired")

        @Test
        func isEnabled_invalidID() throws {
            let box = AudioBox(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try box.isEnabled
            }
        }

        /// Note: This test only runs if BlackHole 2ch is installed.
        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func isEnabled_valid() throws {
            let box = try #require(AudioBox.blackHole2Ch)
            #expect(try box.isEnabled == true)
        }

        // MARK: setIsEnabled()

        @Test
        func setEnabled_invalidID() throws {
            let box = AudioBox(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                try box.setIsEnabled(true)
            }
            #expect(throws: SwiftCoreAudioError.self) {
                try box.setIsEnabled(false)
            }
        }

        /// Note: This test only runs if BlackHole 2ch is installed.
        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func setEnabled_valid() throws {
            let box = try #require(AudioBox.blackHole2Ch)
            try box.setIsEnabled(true)
        }

        // MARK: devices

        @Test
        func devices_invalidID() throws {
            let box = AudioBox(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try box.devices
            }
        }

        /// Note: This test only runs if BlackHole 2ch is installed.
        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func devices_valid() throws {
            let box = try #require(AudioBox.blackHole2Ch)
            let devices = try box.devices
            // won't test properties of devices, just ensure no error is thrown and the array is non-empty
            #expect(!devices.isEmpty)
        }

        // MARK: clocks

        @Test
        func clocks_invalidID() throws {
            let box = AudioBox(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try box.clocks
            }
        }

        /// Note: This test only runs if BlackHole 2ch is installed.
        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func clocks_valid() throws {
            let box = try #require(AudioBox.blackHole2Ch)
            let clocks = try box.clocks
            // won't test properties of clocks, just ensure no error is thrown and the array is empty,
            // as BlackHole does not contain any clocks and is internally clocked
            #expect(clocks.isEmpty)
        }
    }
}
