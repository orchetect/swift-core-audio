//
//  AudioDevice+AudioObjectProperties Tests.swift
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
    struct AudioDevice_AudioObjectProperties_Tests {
        // MARK: baseClassID

        @Test
        func baseClassID_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.baseClassID
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func baseClassID_valid() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            #expect(try device.baseClassID == .object) // device always has object base class
        }

        // MARK: classID

        @Test
        func classID_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.classID
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func classID_valid() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            #expect(try device.classID == .device)
        }

        // MARK: owner

        @Test
        func owner_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.owner
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func owner_valid() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            let owner = try device.owner
            // devices are owned by the system
            #expect(owner as? AudioSystem != nil)
        }

        // MARK: name

        @Test
        func name_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.name
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func name_valid() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            #expect(try device.name == "BlackHole 2ch")
        }

        // MARK: modelName

        @Test
        func modelName_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.modelName
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func modelName_valid() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            // BlackHole does not set a model name
            #expect(try device.modelName == nil)
        }

        // MARK: manufacturer

        @Test
        func manufacturer_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.manufacturer
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func manufacturer_valid() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            #expect(try device.manufacturer == "Existential Audio Inc.")
        }

        // MARK: ownedObjects

        @Test
        func ownedObjects_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.ownedObjects
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func ownedObjects_valid() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            #expect(try device.ownedObjects.isEmpty)
        }

        // MARK: isIdentifying

        @Test
        func isIdentifying_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.isIdentifying
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func isIdentifying_valid() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            #expect(try !device.isIdentifying)
        }

        // MARK: serialNumber

        @Test
        func serialNumber_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.serialNumber
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func serialNumber_valid() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            // BlackHole does not set a serial number
            #expect(try device.serialNumber == nil)
        }

        // MARK: firmwareVersion

        @Test
        func firmwareVersion_invalidID() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.firmwareVersion
            }
        }

        /// Note: This test only runs if BlackHole 2ch is installed.
        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func firmwareVersion_valid() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            // BlackHole does not set firmware version for its device object, however
            // it does set a firmware version for its AudioBox (tested in another file)
            #expect(try device.firmwareVersion == nil)
        }

        // MARK: creator

        @Test
        func creator_invalidID() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.creator
            }
        }

        /// Note: This test only runs if BlackHole 2ch is installed.
        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func creator_valid() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            #expect(try device.creator == BundleID("com.apple.audio.CoreAudio"))
        }
    }
}

#endif
