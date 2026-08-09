//
//  AudioAggregateDevice+Convenience Tests.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import Foundation
import SwiftCoreAudio
import Testing
import TestingExtensions

extension SerializedTests {
    @Suite
    struct AudioAggregateDevice_Convenience_Tests {
        init() {
            CoreAudioLogging.bootstrap()
        }
        
        // MARK: update()

        @Test
        func update_invalid() throws {
            let aggregate = AudioAggregateDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                try aggregate.update(subdevices: [], subtaps: [])
            }
        }

        @Test
        func update_valid() async throws {
            // find two devices to use as subdevices and main subdevice alternatively
            // the restrictive device filtering is needed to de-flake CI runners with unpredictable environments
            let devices = try AudioSystem.shared
                .devices
                .audioDevices
                .lazy
                .filter {
                    guard let uid = try? $0.uid else { return false }
                    return !uid.rawValue.isEmpty
                }
                .filter {
                    // use stable transport types, because transports like BlueTooth can cause problems and deadlocks
                    try [.builtIn, .displayPort, .hdmi, .pci, .thunderbolt, .usb, .virtual]
                        .contains($0.transportType)
                }
                .filter { try $0.isAlive }
                .filter { try $0.hasStreams(for: .output) } // devices with at least one output
                .sorted(by: { lhs, rhs in try rhs.transportType == .virtual }) // sort virtuals last
                .prefix(2)
            guard devices.count == 2 else {
                withKnownIssue {
                    Issue.record("No suitable audio device available. Skipping test.")
                }
                return
            }
            let deviceA = devices[devices.startIndex]
            let deviceB = devices[devices.startIndex.advanced(by: 1)]
            let deviceA_UID = try deviceA.uid
            let deviceB_UID = try deviceB.uid
            print("Found devices: \(deviceA_UID), \(deviceB_UID)")

            // find a clock to use as clock
            guard let clock = try AudioSystem.shared
                .clocks
                .first(where: {
                    guard let uid = try? $0.uid else { return false }
                    return !uid.rawValue.isEmpty
                })
            else {
                withKnownIssue {
                    Issue.record("No suitable audio clocks available. Skipping test.")
                }
                return
            }
            let clockUID = try clock.uid

            // create aggregate
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(withUID: aggregateUID, isPrivate: true)
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // update all composition properties at once
            try aggregate.update(
                name: "Test Aggregate",
                deviceUIDs: [deviceA_UID, AudioDevice.UID("Device2_UID")],
                tapUIDs: [AudioTap.UID("Tap1_UID"), AudioTap.UID("Tap2_UID")],
                clockUID: clockUID,
                mainSubdeviceUID: deviceA_UID,
                isPrivate: false,
                isStacked: true,
                isTapAutoStartEnabled: true
            )

            // verify all composition properties
            #expect(try aggregate.name == "Test Aggregate")
            #expect(try aggregate.subdeviceUIDs == [AudioSubDevice.UID(deviceA_UID.rawValue), AudioSubDevice.UID("Device2_UID")])
            #expect(try aggregate.tapUIDs == [AudioTap.UID("Tap1_UID"), AudioTap.UID("Tap2_UID")])
            #expect(try aggregate.clockUID == clockUID)
            #expect(try aggregate.clockDeviceUID == clockUID) // AudioDeviceProperties property, should return same as `clockUID`
            #expect(try aggregate.mainSubdeviceUID?.rawValue == deviceA_UID.rawValue)
            #expect(try aggregate.isPrivate == false)
            #expect(try aggregate.isStacked == true)
            #expect(try aggregate.isTapAutoStartEnabled == true)

            // change only name
            try aggregate.update(name: "New Aggregate Name")
            #expect(try aggregate.name == "New Aggregate Name")
            #expect(try aggregate.subdeviceUIDs == [AudioSubDevice.UID(deviceA_UID.rawValue), AudioSubDevice.UID("Device2_UID")])
            #expect(try aggregate.tapUIDs == [AudioTap.UID("Tap1_UID"), AudioTap.UID("Tap2_UID")])
            #expect(try aggregate.clockUID == clockUID)
            #expect(try aggregate.clockDeviceUID == clockUID) // AudioDeviceProperties property, should return same as `clockUID`
            #expect(try aggregate.mainSubdeviceUID?.rawValue == deviceA_UID.rawValue)
            #expect(try aggregate.isPrivate == false)
            #expect(try aggregate.isStacked == true)
            #expect(try aggregate.isTapAutoStartEnabled == true)

            // change only subdevices
            try aggregate.update(deviceUIDs: [deviceB_UID, deviceA_UID])
            #expect(try aggregate.name == "New Aggregate Name")
            #expect(try aggregate.subdeviceUIDs == [AudioSubDevice.UID(deviceB_UID.rawValue), AudioSubDevice.UID(deviceA_UID.rawValue)])
            #expect(try aggregate.tapUIDs == [AudioTap.UID("Tap1_UID"), AudioTap.UID("Tap2_UID")])
            #expect(try aggregate.clockUID == clockUID)
            #expect(try aggregate.clockDeviceUID == clockUID) // AudioDeviceProperties property, should return same as `clockUID`
            #expect(try aggregate.mainSubdeviceUID == AudioSubDevice.UID(deviceA_UID.rawValue)) // same, even though devices changed order
            #expect(try aggregate.isPrivate == false)
            #expect(try aggregate.isStacked == true)
            #expect(try aggregate.isTapAutoStartEnabled == true)

            // change only subtaps
            try aggregate.update(tapUIDs: [AudioTap.UID("Tap2_UID"), AudioTap.UID("Tap1_UID")])
            #expect(try aggregate.name == "New Aggregate Name")
            #expect(try aggregate.subdeviceUIDs == [AudioSubDevice.UID(deviceB_UID.rawValue), AudioSubDevice.UID(deviceA_UID.rawValue)])
            #expect(try aggregate.tapUIDs == [AudioTap.UID("Tap2_UID"), AudioTap.UID("Tap1_UID")])
            #expect(try aggregate.clockUID == clockUID)
            #expect(try aggregate.clockDeviceUID == clockUID) // AudioDeviceProperties property, should return same as `clockUID`
            #expect(try aggregate.mainSubdeviceUID == AudioSubDevice.UID(deviceA_UID.rawValue))
            #expect(try aggregate.isPrivate == false)
            #expect(try aggregate.isStacked == true)
            #expect(try aggregate.isTapAutoStartEnabled == true)

            // change only clock
            try aggregate.update(clockUID: AudioClock.UID("")) // we can remove the clock, but can't remove the main subdevice
            #expect(try aggregate.name == "New Aggregate Name")
            #expect(try aggregate.subdeviceUIDs == [AudioSubDevice.UID(deviceB_UID.rawValue), AudioSubDevice.UID(deviceA_UID.rawValue)])
            #expect(try aggregate.tapUIDs == [AudioTap.UID("Tap2_UID"), AudioTap.UID("Tap1_UID")])
            #expect(try aggregate.clockUID == nil)
            #expect(try aggregate.clockDeviceUID == nil) // AudioDeviceProperties property, should return same as `clockUID`
            #expect(try aggregate.mainSubdeviceUID == AudioSubDevice.UID(deviceA_UID.rawValue))
            #expect(try aggregate.isPrivate == false)
            #expect(try aggregate.isStacked == true)
            #expect(try aggregate.isTapAutoStartEnabled == true)

            // change only main subdevice
            try aggregate.update(mainSubdeviceUID: AudioSubDevice.UID(deviceB_UID.rawValue))
            try await Task.sleep(for: .milliseconds(500)) // allow a little time for the main subdevice to update
            #expect(try aggregate.name == "New Aggregate Name")
            #expect(try aggregate.subdeviceUIDs == [AudioSubDevice.UID(deviceB_UID.rawValue), AudioSubDevice.UID(deviceA_UID.rawValue)])
            #expect(try aggregate.tapUIDs == [AudioTap.UID("Tap2_UID"), AudioTap.UID("Tap1_UID")])
            #expect(try aggregate.clockUID == nil)
            #expect(try aggregate.clockDeviceUID == nil) // AudioDeviceProperties property, should return same as `clockUID`
            #expect(try aggregate.mainSubdeviceUID == AudioSubDevice.UID(deviceB_UID.rawValue))
            #expect(try aggregate.isPrivate == false)
            #expect(try aggregate.isStacked == true)
            #expect(try aggregate.isTapAutoStartEnabled == true)

            // change only isPrivate
            try aggregate.update(isPrivate: true)
            #expect(try aggregate.name == "New Aggregate Name")
            #expect(try aggregate.subdeviceUIDs == [AudioSubDevice.UID(deviceB_UID.rawValue), AudioSubDevice.UID(deviceA_UID.rawValue)])
            #expect(try aggregate.tapUIDs == [AudioTap.UID("Tap2_UID"), AudioTap.UID("Tap1_UID")])
            #expect(try aggregate.clockUID == nil)
            #expect(try aggregate.clockDeviceUID == nil) // AudioDeviceProperties property, should return same as `clockUID`
            #expect(try aggregate.mainSubdeviceUID == AudioSubDevice.UID(deviceB_UID.rawValue))
            #expect(try aggregate.isPrivate == true)
            #expect(try aggregate.isStacked == true)
            #expect(try aggregate.isTapAutoStartEnabled == true)

            // change only isStacked
            try aggregate.update(isStacked: false)
            #expect(try aggregate.name == "New Aggregate Name")
            #expect(try aggregate.subdeviceUIDs == [AudioSubDevice.UID(deviceB_UID.rawValue), AudioSubDevice.UID(deviceA_UID.rawValue)])
            #expect(try aggregate.tapUIDs == [AudioTap.UID("Tap2_UID"), AudioTap.UID("Tap1_UID")])
            #expect(try aggregate.clockUID == nil)
            #expect(try aggregate.clockDeviceUID == nil) // AudioDeviceProperties property, should return same as `clockUID`
            #expect(try aggregate.mainSubdeviceUID == AudioSubDevice.UID(deviceB_UID.rawValue))
            #expect(try aggregate.isPrivate == true)
            #expect(try aggregate.isStacked == false)
            #expect(try aggregate.isTapAutoStartEnabled == true)

            // change only isTapAutoStartEnabled
            try aggregate.update(isTapAutoStartEnabled: false)
            #expect(try aggregate.name == "New Aggregate Name")
            #expect(try aggregate.subdeviceUIDs == [AudioSubDevice.UID(deviceB_UID.rawValue), AudioSubDevice.UID(deviceA_UID.rawValue)])
            #expect(try aggregate.tapUIDs == [AudioTap.UID("Tap2_UID"), AudioTap.UID("Tap1_UID")])
            #expect(try aggregate.clockUID == nil)
            #expect(try aggregate.clockDeviceUID == nil) // AudioDeviceProperties property, should return same as `clockUID`
            #expect(try aggregate.mainSubdeviceUID == AudioSubDevice.UID(deviceB_UID.rawValue))
            #expect(try aggregate.isPrivate == true)
            #expect(try aggregate.isStacked == false)
            #expect(try aggregate.isTapAutoStartEnabled == false)
        }

        // MARK: destroy()

        @Test
        func destroy_invalid() throws {
            let aggregate = AudioAggregateDevice(id: .randomUnused)
            // no error is thrown by Core Audio when attempting to destroy an aggregate device that doesn't exist
            #expect(throws: Never.self) {
                try aggregate.destroy()
            }
        }

        @Test
        func destroy_valid_true() async throws {
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(withUID: aggregateUID, isPrivate: true)
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // destroy aggregate
            try aggregate.destroy()

            // verify
            #expect(try !AudioSystem.shared.aggregates.contains(aggregate))
            #expect(!aggregate.isPresent)
        }

        // MARK: isPrivate

        @Test
        func isPrivate_invalid() throws {
            let aggregate = AudioAggregateDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try aggregate.isPrivate
            }
        }

        @Test
        func isPrivate_valid_true() async throws {
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(withUID: aggregateUID, isPrivate: true)
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // verify
            #expect(try aggregate.isPrivate)
        }

        @Test
        func isPrivate_valid_false() async throws {
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(withUID: aggregateUID, isPrivate: false)
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // verify
            #expect(try !aggregate.isPrivate)
        }

        // MARK: isStacked

        @Test
        func isStacked_invalid() throws {
            let aggregate = AudioAggregateDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try aggregate.isStacked
            }
        }

        @Test
        func isStacked_valid_true() async throws {
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(withUID: aggregateUID, isPrivate: true, isStacked: true)
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // verify
            #expect(try aggregate.isStacked)
        }

        @Test
        func isStacked_valid_false() async throws {
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(withUID: aggregateUID, isPrivate: true, isStacked: false)
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // verify
            #expect(try !aggregate.isStacked)
        }

        // MARK: isTapAutoStartEnabled

        @Test
        func isTapAutoStartEnabled_invalid() throws {
            let aggregate = AudioAggregateDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try aggregate.isTapAutoStartEnabled
            }
        }

        @Test
        func isTapAutoStartEnabled_valid_true() async throws {
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(withUID: aggregateUID, isPrivate: true, isTapAutoStartEnabled: true)
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // verify
            #expect(try aggregate.isTapAutoStartEnabled)
        }

        @Test
        func isTapAutoStartEnabled_valid_false() async throws {
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(withUID: aggregateUID, isPrivate: true, isTapAutoStartEnabled: false)
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // verify
            #expect(try !aggregate.isTapAutoStartEnabled)
        }

        // MARK: subdevices(uidLookupErrorHandler:)

        @Test
        func subdevices_uidLookupErrorHandler_invalid() throws {
            let aggregate = AudioAggregateDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try aggregate.subdevices(uidLookupErrorHandler: nil)
            }
        }

        @Test
        func subdevices_uidLookupErrorHandler_valid_existentDevices() async throws {
            // find a device to use
            guard let device = try AudioSystem.shared
                .devices
                .audioDevices
                .lazy
                .filter({
                    guard let uid = try? $0.uid else { return false }
                    return !uid.rawValue.isEmpty
                })
                .filter({
                    // use stable transport types, because transports like BlueTooth can cause problems and deadlocks
                    try [.builtIn, .displayPort, .hdmi, .pci, .thunderbolt, .usb, .virtual]
                        .contains($0.transportType)
                })
                .first
            else {
                withKnownIssue {
                    Issue.record("No suitable audio device available. Skipping test.")
                }
                return
            }
            let deviceUID = try device.uid

            // create aggregate
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(
                withUID: aggregateUID,
                deviceUIDs: [deviceUID],
                tapUIDs: [AudioTap.UID("Tap1_UID"), AudioTap.UID("Tap2_UID")],
                isPrivate: true
            )
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            let subdevices = try await confirmation("Error handler should not get called.", expectedCount: 0) { confirmation in
                try aggregate.subdevices { uid, error in
                    confirmation()
                }
            }

            // check returned subdevices
            try #require(subdevices.count == 1)
            #expect(subdevices.first?.id.rawValue == device.id.rawValue)
        }

        @Test
        func subdevices_uidLookupErrorHandler_valid_nonExistentDevices() async throws {
            // create aggregate
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(
                withUID: aggregateUID,
                deviceUIDs: [AudioDevice.UID("Device1_UID"), AudioDevice.UID("Device2_UID")],
                tapUIDs: [AudioTap.UID("Tap1_UID"), AudioTap.UID("Tap2_UID")],
                isPrivate: true
            )
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // set up async receiver to store contents of error handler calls
            let receiver = Receiver<(uid: AudioSubDevice.UID, error: SwiftCoreAudioError)>()

            // we're using two fake devices that don't exist, so it call the error handler twice
            let subdevices = try await confirmation(expectedCount: 2) { confirmation in
                let subdevices = try aggregate.subdevices { uid, error in
                    confirmation()
                    Task { await receiver.add((uid, error)) }
                }

                try await wait(require: { await receiver.items.count == 2 }, timeout: 10.0)
                return subdevices
            }

            // check returned subdevices is empty, because both UID lookups fail
            #expect(subdevices.isEmpty)

            // check error handler calls
            // use Set to compare, as it's possible the error handler Task could execute out of order
            #expect(await Set(receiver.items.map(\.uid.rawValue)) == Set(["Device1_UID", "Device2_UID"]))
        }

        // MARK: setSubdevices(_:deviceLookupErrorHandler:)

        @Test
        func setSubdevices_deviceLookupErrorHandler_invalid() throws {
            let aggregate = AudioAggregateDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try aggregate.setSubdevices([], deviceLookupErrorHandler: nil)
            }
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try aggregate.setSubdevices([AudioDevice(id: .randomUnused)], deviceLookupErrorHandler: nil)
            }
        }

        @Test
        func setSubdevices_deviceLookupErrorHandler_valid_existentDevices() async throws {
            // find a device to use
            guard let device = try AudioSystem.shared
                .devices
                .audioDevices
                .lazy
                .filter({
                    guard let uid = try? $0.uid else { return false }
                    return !uid.rawValue.isEmpty
                })
                .filter({
                    // use stable transport types, because transports like BlueTooth can cause problems and deadlocks
                    try [.builtIn, .displayPort, .hdmi, .pci, .thunderbolt, .usb, .virtual]
                        .contains($0.transportType)
                })
                .first
            else {
                withKnownIssue {
                    Issue.record("No suitable audio device available. Skipping test.")
                }
                return
            }
            let deviceUID = try device.uid

            // create aggregate
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(
                withUID: aggregateUID,
                deviceUIDs: [deviceUID],
                tapUIDs: [AudioTap.UID("Tap1_UID"), AudioTap.UID("Tap2_UID")],
                isPrivate: true
            )
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            try await confirmation("Error handler should not get called.", expectedCount: 0) { confirmation in
                try aggregate.setSubdevices([device]) { device, error in
                    confirmation()
                }
            }

            // check aggregate's subdevices
            let subdeviceUIDs = try aggregate.subdeviceUIDs
            try #require(subdeviceUIDs.count == 1)
            #expect(subdeviceUIDs.first?.rawValue == deviceUID.rawValue)
        }

        @Test
        func setSubdevices_deviceLookupErrorHandler_valid_nonExistentDevices() async throws {
            // define two fake devices with IDs that don't exist
            let device1 = AudioDevice(id: .randomUnused)
            let device2 = AudioDevice(id: .randomUnused)
            assert(device1 != device2)

            // create aggregate
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(
                withUID: aggregateUID,
                deviceUIDs: [AudioDevice.UID("Device1_UID"), AudioDevice.UID("Device2_UID")],
                tapUIDs: [AudioTap.UID("Tap1_UID"), AudioTap.UID("Tap2_UID")],
                isPrivate: true
            )
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // set up async receiver to store contents of error handler calls
            let receiver = Receiver<(device: AudioDevice, error: SwiftCoreAudioError)>()

            // we're using two fake devices that don't exist, so it call the error handler twice
            try await confirmation(expectedCount: 2) { confirmation in
                try aggregate.setSubdevices([device1, device2]) { device, error in
                    confirmation()
                    Task { await receiver.add((device, error)) }
                }

                try await wait(require: { await receiver.items.count == 2 }, timeout: 10.0)
            }

            // check aggregate subdevices is empty, because both UID lookups fail
            #expect(try aggregate.subdeviceUIDs.isEmpty)

            // check error handler calls
            // use Set to compare, as it's possible the error handler Task could execute out of order
            #expect(await Set(receiver.items.map(\.device)) == Set([device1, device2]))
        }

        // MARK: addSubdevices(_:deviceLookupErrorHandler:)

        @Test
        func addSubdevices_deviceLookupErrorHandler_invalid() throws {
            let aggregate = AudioAggregateDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try aggregate.addSubdevices([AudioDevice(id: .randomUnused)], deviceLookupErrorHandler: nil)
            }
        }

        @Test
        func addSubdevices_deviceLookupErrorHandler_valid_existentDevices() async throws {
            // find a device to use
            guard let device = try AudioSystem.shared
                .devices
                .audioDevices
                .lazy
                .filter({
                    guard let uid = try? $0.uid else { return false }
                    return !uid.rawValue.isEmpty
                })
                .filter({
                    // use stable transport types, because transports like BlueTooth can cause problems and deadlocks
                    try [.builtIn, .displayPort, .hdmi, .pci, .thunderbolt, .usb, .virtual]
                        .contains($0.transportType)
                })
                .first
            else {
                withKnownIssue {
                    Issue.record("No suitable audio device available. Skipping test.")
                }
                return
            }
            let deviceUID = try device.uid

            // create aggregate
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(
                withUID: aggregateUID,
                deviceUIDs: [AudioDevice.UID("Dummy_UID")],
                tapUIDs: [AudioTap.UID("Tap1_UID"), AudioTap.UID("Tap2_UID")],
                isPrivate: true
            )
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            try await confirmation("Error handler should not get called.", expectedCount: 0) { confirmation in
                try aggregate.addSubdevices([device]) { device, error in
                    confirmation()
                }
            }

            // check aggregate's subdevices
            let subdeviceUIDs = try aggregate.subdeviceUIDs
            try #require(subdeviceUIDs.count == 2)
            #expect(subdeviceUIDs[0].rawValue == "Dummy_UID")
            #expect(subdeviceUIDs[1].rawValue == deviceUID.rawValue)
        }

        @Test
        func addSubdevices_deviceLookupErrorHandler_valid_nonExistentDevices() async throws {
            // define two fake devices with IDs that don't exist
            let device1 = AudioDevice(id: .randomUnused)
            let device2 = AudioDevice(id: .randomUnused)
            assert(device1 != device2)

            // create aggregate
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(
                withUID: aggregateUID,
                deviceUIDs: [AudioDevice.UID("Device1_UID"), AudioDevice.UID("Device2_UID")],
                tapUIDs: [AudioTap.UID("Tap1_UID"), AudioTap.UID("Tap2_UID")],
                isPrivate: true
            )
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // set up async receiver to store contents of error handler calls
            let receiver = Receiver<(device: AudioDevice, error: SwiftCoreAudioError)>()

            // we're using two fake devices that don't exist, so it call the error handler twice
            try await confirmation(expectedCount: 2) { confirmation in
                try aggregate.addSubdevices([device1, device2]) { device, error in
                    confirmation()
                    Task { await receiver.add((device, error)) }
                }

                try await wait(require: { await receiver.items.count == 2 }, timeout: 10.0)
            }

            // check aggregate subdevices have not changed, because both UID lookups fail
            #expect(try aggregate.subdeviceUIDs == [AudioSubDevice.UID("Device1_UID"), AudioSubDevice.UID("Device2_UID")])

            // check error handler calls
            // use Set to compare, as it's possible the error handler Task could execute out of order
            #expect(await Set(receiver.items.map(\.device)) == Set([device1, device2]))
        }

        // MARK: taps(uidLookupErrorHandler:)

        @Test
        func taps_uidLookupErrorHandler_invalid() throws {
            let aggregate = AudioAggregateDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try aggregate.taps(uidLookupErrorHandler: nil)
            }
        }

        #if !targetEnvironment(macCatalyst)
        @available(macOS 14.2, *)
        @available(macCatalyst, unavailable) // doesn't prevent Swift Testing from running this on Mac Catalyst
        @Test
        func taps_uidLookupErrorHandler_valid_existentTaps() async throws {
            // find a device to tap
            guard let device = try AudioSystem.shared
                .devices
                .audioDevices
                .lazy
                .filter({
                    guard let uid = try? $0.uid else { return false }
                    return !uid.rawValue.isEmpty
                })
                .filter({
                    // use stable transport types, because transports like BlueTooth can cause problems and deadlocks
                    try [.builtIn, .displayPort, .hdmi, .pci, .thunderbolt, .usb, .virtual]
                        .contains($0.transportType)
                })
                .first
            else {
                withKnownIssue {
                    Issue.record("No suitable audio device available. Skipping test.")
                }
                return
            }
            let deviceUID = try device.uid
            print("Found device \((try? device.name) ?? "with no name") with UID \(deviceUID) to tap.")

            // create a tap
            let tapDescription = CATapDescription()
            tapDescription.name = "Tap1 - \(UUID().uuidString)"
            tapDescription.isPrivate = true
            tapDescription.muteBehavior = .unmuted
            tapDescription.isMixdown = true
            tapDescription.isMono = false
            tapDescription.isExclusive = false
            tapDescription.deviceUID = nil
            tapDescription.stream = 0
            tapDescription.processes = []
            let tap = try AudioSystem.shared.makeTap(using: tapDescription)
            defer { try? AudioSystem.shared.destroyTap(tap) } // cleanup when out of scope

            // get tap ID
            let tapID = tap.id
            print("Created tap with audio object ID \(tapID)")

            // get tap UID
            let tapUID = try tap.uid
            print("Tap UID:", tapUID)

            // create aggregate
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(
                withUID: aggregateUID,
                deviceUIDs: [AudioDevice.UID("Device1_UID"), AudioDevice.UID("Device2_UID")],
                tapUIDs: [tapUID],
                isPrivate: true
            )
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            let taps = try await confirmation("Error handler should not get called.", expectedCount: 0) { confirmation in
                try aggregate.taps { uid, error in
                    confirmation()
                }
            }

            // check returned taps
            try #require(taps.count == 1)
            #expect(taps.first?.id.rawValue == tap.id.rawValue)
        }
        #endif

        @Test
        func taps_uidLookupErrorHandler_valid_nonExistentTaps() async throws {
            // create aggregate
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(
                withUID: aggregateUID,
                deviceUIDs: [AudioDevice.UID("Device1_UID"), AudioDevice.UID("Device2_UID")],
                tapUIDs: [AudioTap.UID("Tap1_UID"), AudioTap.UID("Tap2_UID")],
                isPrivate: true
            )
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // set up async receiver to store contents of error handler calls
            let receiver = Receiver<(uid: AudioTap.UID, error: SwiftCoreAudioError)>()

            // we're using two fake devices that don't exist, so it call the error handler twice
            let taps = try await confirmation(expectedCount: 2) { confirmation in
                let taps = try aggregate.taps { uid, error in
                    confirmation()
                    Task { await receiver.add((uid, error)) }
                }

                try await wait(require: { await receiver.items.count == 2 }, timeout: 10.0)
                return taps
            }

            // check returned taps is empty, because both UID lookups fail
            #expect(taps.isEmpty)

            // check error handler calls
            // use Set to compare, as it's possible the error handler Task could execute out of order
            #expect(await Set(receiver.items.map(\.uid.rawValue)) == Set(["Tap1_UID", "Tap2_UID"]))
        }

        // MARK: setTaps(_:tapLookupErrorHandler:)

        @Test
        func setTaps_tapLookupErrorHandler_invalid() throws {
            let aggregate = AudioAggregateDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try aggregate.setTaps([], tapLookupErrorHandler: nil)
            }
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try aggregate.setTaps([AudioTap(id: .randomUnused)], tapLookupErrorHandler: nil)
            }
        }

        #if !targetEnvironment(macCatalyst)
        @available(macOS 14.2, *)
        @available(macCatalyst, unavailable) // doesn't prevent Swift Testing from running this on Mac Catalyst
        @Test
        func setTaps_tapLookupErrorHandler_valid_existentTaps() async throws {
            // find a device to tap
            guard let device = try AudioSystem.shared
                .devices
                .audioDevices
                .lazy
                .filter({
                    guard let uid = try? $0.uid else { return false }
                    return !uid.rawValue.isEmpty
                })
                .filter({
                    // use stable transport types, because transports like BlueTooth can cause problems and deadlocks
                    try [.builtIn, .displayPort, .hdmi, .pci, .thunderbolt, .usb, .virtual]
                        .contains($0.transportType)
                })
                .first
            else {
                withKnownIssue {
                    Issue.record("No suitable audio device available. Skipping test.")
                }
                return
            }
            let deviceUID = try device.uid
            print("Found device \((try? device.name) ?? "with no name") with UID \(deviceUID) to tap.")

            // create a tap
            let tapDescription = CATapDescription()
            tapDescription.name = "Tap1 - \(UUID().uuidString)"
            tapDescription.isPrivate = true
            tapDescription.muteBehavior = .unmuted
            tapDescription.isMixdown = true
            tapDescription.isMono = false
            tapDescription.isExclusive = false
            tapDescription.deviceUID = nil
            tapDescription.stream = 0
            tapDescription.processes = []
            let tap = try AudioSystem.shared.makeTap(using: tapDescription)
            defer { try? AudioSystem.shared.destroyTap(tap) } // cleanup when out of scope

            // get tap ID
            let tapID = tap.id
            print("Created tap with audio object ID \(tapID)")

            // get tap UID
            let tapUID = try tap.uid
            print("Tap UID:", tapUID)

            // create aggregate
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(
                withUID: aggregateUID,
                deviceUIDs: [AudioDevice.UID("Device1_UID"), AudioDevice.UID("Device2_UID")],
                tapUIDs: [AudioTap.UID("Tap1_UID"), AudioTap.UID("Tap2_UID")],
                isPrivate: true
            )
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            try await confirmation("Error handler should not get called.", expectedCount: 0) { confirmation in
                try aggregate.setTaps([tap]) { tap, error in
                    confirmation()
                }
            }

            // check aggregate's taps
            let tapUIDs = try aggregate.tapUIDs
            try #require(tapUIDs.count == 1)
            #expect(tapUIDs.first?.rawValue == tapUID.rawValue)
        }
        #endif

        @Test
        func setTaps_tapLookupErrorHandler_valid_nonExistentTaps() async throws {
            // define two fake taps with IDs that don't exist
            let tap1 = AudioTap(id: .randomUnused)
            let tap2 = AudioTap(id: .randomUnused)
            assert(tap1 != tap2)

            // create aggregate
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(
                withUID: aggregateUID,
                deviceUIDs: [AudioDevice.UID("Device1_UID"), AudioDevice.UID("Device2_UID")],
                tapUIDs: [AudioTap.UID("Tap1_UID"), AudioTap.UID("Tap2_UID")],
                isPrivate: true
            )
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // set up async receiver to store contents of error handler calls
            let receiver = Receiver<(tap: AudioTap, error: SwiftCoreAudioError)>()

            // we're using two fake taps that don't exist, so it call the error handler twice
            try await confirmation(expectedCount: 2) { confirmation in
                try aggregate.setTaps([tap1, tap2]) { tap, error in
                    confirmation()
                    Task { await receiver.add((tap, error)) }
                }

                try await wait(require: { await receiver.items.count == 2 }, timeout: 10.0)
            }

            // check aggregate taps is empty, because both UID lookups fail
            #expect(try aggregate.tapUIDs.isEmpty)

            // check error handler calls
            // use Set to compare, as it's possible the error handler Task could execute out of order
            #expect(await Set(receiver.items.map(\.tap)) == Set([tap1, tap2]))
        }

        // MARK: addTaps(_:tapLookupErrorHandler:)

        @Test
        func addTaps_tapLookupErrorHandler_invalid() async throws {
            let aggregate = AudioAggregateDevice(id: .randomUnused)

            let randomTap = AudioTap(id: .randomUnused)

            // `addTaps` itself does not throw an error, but the error handler is called.
            try await confirmation(expectedCount: 1) { confirmation in
                try aggregate.addTaps([randomTap]) { tap, error in
                    confirmation()
                    #expect(tap == randomTap)
                }
            }
        }

        #if !targetEnvironment(macCatalyst)
        @available(macOS 14.2, *)
        @available(macCatalyst, unavailable) // doesn't prevent Swift Testing from running this on Mac Catalyst
        @Test
        func addTaps_tapLookupErrorHandler_valid_existentTaps() async throws {
            // find a device to tap
            guard let device = try AudioSystem.shared
                .devices
                .audioDevices
                .lazy
                .filter({
                    guard let uid = try? $0.uid else { return false }
                    return !uid.rawValue.isEmpty
                })
                .filter({
                    // use stable transport types, because transports like BlueTooth can cause problems and deadlocks
                    try [.builtIn, .displayPort, .hdmi, .pci, .thunderbolt, .usb, .virtual]
                        .contains($0.transportType)
                })
                .first
            else {
                withKnownIssue {
                    Issue.record("No suitable audio device available. Skipping test.")
                }
                return
            }
            let deviceUID = try device.uid
            print("Found device \((try? device.name) ?? "with no name") with UID \(deviceUID) to tap.")

            // create a tap
            let tapDescription = CATapDescription()
            tapDescription.name = "Tap1 - \(UUID().uuidString)"
            tapDescription.isPrivate = true
            tapDescription.muteBehavior = .unmuted
            tapDescription.isMixdown = true
            tapDescription.isMono = false
            tapDescription.isExclusive = false
            tapDescription.deviceUID = nil
            tapDescription.stream = 0
            tapDescription.processes = []
            let tap = try AudioSystem.shared.makeTap(using: tapDescription)
            defer { try? AudioSystem.shared.destroyTap(tap) } // cleanup when out of scope

            // get tap ID
            let tapID = tap.id
            print("Created tap with audio object ID \(tapID)")

            // get tap UID
            let tapUID = try tap.uid
            print("Tap UID:", tapUID)

            // create aggregate
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(
                withUID: aggregateUID,
                deviceUIDs: [AudioDevice.UID("Device1_UID"), AudioDevice.UID("Device2_UID")],
                tapUIDs: [AudioTap.UID("Dummy_UID")],
                isPrivate: true
            )
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            try await confirmation("Error handler should not get called.", expectedCount: 0) { confirmation in
                try aggregate.addTaps([tap]) { tap, error in
                    confirmation()
                }
            }

            // check aggregate's taps
            let tapUIDs = try aggregate.tapUIDs
            try #require(tapUIDs.count == 2)
            #expect(tapUIDs[0] == AudioTap.UID("Dummy_UID"))
            #expect(tapUIDs[1] == tapUID)
        }
        #endif

        @Test
        func addTaps_tapLookupErrorHandler_valid_nonExistentTaps() async throws {
            // define two fake taps with IDs that don't exist
            let tap1 = AudioTap(id: .randomUnused)
            let tap2 = AudioTap(id: .randomUnused)
            assert(tap1 != tap2)

            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(
                withUID: aggregateUID,
                deviceUIDs: [AudioDevice.UID("Device1_UID"), AudioDevice.UID("Device2_UID")],
                tapUIDs: [AudioTap.UID("Tap1_UID"), AudioTap.UID("Tap2_UID")],
                isPrivate: true
            )
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // set up async receiver to store contents of error handler calls
            let receiver = Receiver<(tap: AudioTap, error: SwiftCoreAudioError)>()

            // we're using two fake taps that don't exist, so it call the error handler twice
            try await confirmation(expectedCount: 2) { confirmation in
                try aggregate.addTaps([tap1, tap2]) { tap, error in
                    confirmation()
                    Task { await receiver.add((tap, error)) }
                }

                try await wait(require: { await receiver.items.count == 2 }, timeout: 10.0)
            }

            // check aggregate taps have not changed, because both UID lookups fail
            #expect(try aggregate.tapUIDs == [AudioTap.UID("Tap1_UID"), AudioTap.UID("Tap2_UID")])

            // check error handler calls
            // use Set to compare, as it's possible the error handler Task could execute out of order
            #expect(await Set(receiver.items.map(\.tap)) == Set([tap1, tap2]))
        }
    }
}

#endif
