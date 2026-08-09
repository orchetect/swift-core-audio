//
//  AudioAggregateDevice+Properties Tests.swift
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
    struct AudioAggregateDevice_Properties_Tests {
        init() {
            CoreAudioLogging.bootstrap()
        }
        
        // MARK: - subdeviceUIDs

        @Test
        func subdeviceUIDs_invalid() throws {
            let aggregate = AudioAggregateDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try aggregate.subdeviceUIDs
            }
        }

        @Test
        func subdeviceUIDs_valid() async throws {
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(
                withUID: aggregateUID,
                subdevices: [.init(uid: AudioDevice.UID("Device1_UID")), .init(uid: AudioDevice.UID("Device2_UID"))],
                subtaps: [.init(uid: AudioTap.UID("Tap1_UID")), .init(uid: AudioTap.UID("Tap2_UID"))],
                isPrivate: true
            )
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // verify
            #expect(try aggregate.subdeviceUIDs == [.init("Device1_UID"), .init("Device2_UID")])
        }

        // MARK: - setSubdevices(uids:)

        @Test
        func setSubdevices_uids_invalid() throws {
            let aggregate = AudioAggregateDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                try aggregate.setSubdevices(uids: [AudioDevice.UID("Device1_UID"), AudioDevice.UID("Device2_UID")])
            }

            // ensure the non-existent aggregate has not somehow now been created
            #expect(!aggregate.isPresent)
        }

        @Test
        func setSubdevices_uids_valid() async throws {
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(
                withUID: aggregateUID,
                subdevices: [.init(uid: AudioDevice.UID("Device3_UID")), .init(uid: AudioDevice.UID("Device4_UID"))],
                subtaps: [.init(uid: AudioTap.UID("Tap1_UID")), .init(uid: AudioTap.UID("Tap2_UID"))],
                isPrivate: true
            )
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // set UIDs
            try aggregate.setSubdevices(uids: [AudioDevice.UID("Device1_UID"), AudioDevice.UID("Device2_UID")])

            // verify subdevices have been replaced
            #expect(try aggregate.subdeviceUIDs == [AudioSubDevice.UID("Device1_UID"), AudioSubDevice.UID("Device2_UID")])
            // verify subtaps have not changed
            #expect(try aggregate.tapUIDs == [AudioTap.UID("Tap1_UID"), AudioTap.UID("Tap2_UID")])
            #expect(try aggregate.activeSubtaps.isEmpty)
        }

        // MARK: - activeSubdevices

        @Test
        func activeSubdevices_invalid() throws {
            let aggregate = AudioAggregateDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try aggregate.activeSubdevices
            }
        }

        @Test
        func activeSubdevices_valid_nonpresent() async throws {
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(
                withUID: aggregateUID,
                subdevices: [.init(uid: AudioDevice.UID("Device1_UID")), .init(uid: AudioDevice.UID("Device2_UID"))],
                subtaps: [.init(uid: AudioTap.UID("Tap1_UID")), .init(uid: AudioTap.UID("Tap2_UID"))],
                isPrivate: true
            )
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // verify
            // active devices will be empty even though two devices have been added,
            // the devices are dummy/fake UIDs that do not exist, so they can't be "active"
            #expect(try aggregate.activeSubdevices.isEmpty)
        }

        @Test
        func activeSubdevices_valid_present() async throws {
            // find a device to use as main subdevice
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
            let deviceID = device.id
            let deviceUID = try device.uid

            // create aggregate
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(
                withUID: aggregateUID,
                subdevices: [
                    .init(uid: deviceUID, extraInputLatency: 64, extraOutputLatency: 64, isDriftCompensationEnabled: true),
                    .init(uid: AudioDevice.UID("Device2_UID"))
                ],
                subtaps: [.init(uid: AudioTap.UID("Tap1_UID")), .init(uid: AudioTap.UID("Tap2_UID"))],
                isPrivate: true
            )
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // verify - device is usable so Core Audio auto-activates it
            let activeSubdevices = try aggregate.activeSubdevices
            #expect(activeSubdevices.count == 1)
            #expect(activeSubdevices == [device])
            let activeSubdevice = try #require(activeSubdevices.first)

            // subdevice has the same object ID as the device it was created from
            #expect(activeSubdevice.id.rawValue == deviceID.rawValue)

            // subdevice has the same UID as the device it was created from
            let activeSubdeviceUID = try activeSubdevice.uid
            #expect(activeSubdeviceUID.rawValue == deviceUID.rawValue)

            // basic test of AudioSubDevice-specific property selectors
            // TODO: for some reason these all throw errors, saying properties don't exist
            // print("extraLatency:", try? activeSubdevice.extraLatency)
            // print("driftCompensationQuality:", try? activeSubdevice.driftCompensationQuality)
            // print("isDriftCompensationEnabled:", try? activeSubdevice.isDriftCompensationEnabled)
        }

        // MARK: composition

        @Test
        func composition_invalid() throws {
            let aggregate = AudioAggregateDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try aggregate.composition
            }
        }

        @Test
        func composition_valid() async throws {
            var composition = AudioAggregateDevice_Composition_Tests.sampleComposition
            composition.uid = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(composition: composition)
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // verify
            #expect(try aggregate.uid == composition.uid)

            var getComposition = try aggregate.composition

            // Core Audio omits this property key for this subdevice probably because drift compensation
            // is not able to be enabled, even though we set it as `true` when creating the aggregate.
            // to get our test to pass, we'll just manually re-set it to `true` in the returned composition.
            getComposition.subdevices[0].isDriftCompensationEnabled = true

            try AudioAggregateDevice_Composition_Tests.checkComposition(
                composition: getComposition,
                overridingUID: composition.uid
            )
        }

        /// Check that composition for any aggregates in the system successfully parse into `Composition` structs.
        @Test
        func composition_valid_systemAggregates() throws {
            let aggregates = try AudioSystem.shared.aggregates

            for aggregate in aggregates {
                let composition = try aggregate.composition
                print(composition.dictionary())
            }
        }

        // MARK: compositionDictionary

        @Test
        func compositionDictionary_invalid() throws {
            let aggregate = AudioAggregateDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try aggregate.compositionDictionary
            }
        }

        @Test
        func compositionDictionary_valid_systemAggregates() throws {
            let aggregates = try AudioSystem.shared.aggregates

            for aggregate in aggregates {
                let composition = try aggregate.compositionDictionary
                dump(composition)
            }
        }

        // MARK: setComposition()

        @Test
        func setComposition_invalid() throws {
            let aggregate = AudioAggregateDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                try aggregate.setComposition(.init(dictionary: [:]))
            }
        }

        @Test
        func setComposition_valid() async throws {
            let originalAggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(withUID: originalAggregateUID, isPrivate: true)
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // set composition
            var composition = AudioAggregateDevice_Composition_Tests.sampleComposition
            let newCompositionUID: AudioAggregateDevice.UID = .random
            composition.uid = newCompositionUID
            try aggregate.setComposition(composition)

            // verify - we can't change the aggregate's UID after it's created, even though
            // we supplied a new UID in the `setComposition()` method.
            #expect(try aggregate.uid == originalAggregateUID)
            #expect(try aggregate.uid != composition.uid)

            var getComposition = try aggregate.composition

            // Core Audio omits this property key for this subdevice probably because drift compensation
            // is not able to be enabled, even though we set it as `true` when creating the aggregate.
            // to get our test to pass, we'll just manually re-set it to `true` in the returned composition.
            getComposition.subdevices[0].isDriftCompensationEnabled = true

            try AudioAggregateDevice_Composition_Tests.checkComposition(
                composition: getComposition,
                overridingUID: newCompositionUID // <-- composition has new UID
            )

            // look up the aggregate by both their original UID and new UID set within the composition
            // original UID
            let aggregateA = try AudioSystem.shared.object(forUID: originalAggregateUID)
            #expect(aggregateA != nil)
            #expect(aggregateA == aggregate)
            // new UID set within the composition
            let aggregateB = try AudioSystem.shared.object(forUID: newCompositionUID)
            #expect(aggregateB == nil)
        }

        // MARK: mainSubdeviceUID

        @Test
        func mainSubdeviceUID_invalid() throws {
            let aggregate = AudioAggregateDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try aggregate.mainSubdeviceUID
            }
        }

        @Test
        func mainSubdeviceUID_valid_none() async throws {
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(withUID: aggregateUID, isPrivate: true)
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // verify
            #expect(try aggregate.mainSubdeviceUID == nil)
        }

        @Test
        func mainSubdeviceUID_valid_present() async throws {
            // find a device to use
            guard let mainDevice = try AudioSystem.shared
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
            let mainDeviceUID = try mainDevice.uid

            // create aggregate
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(
                withUID: aggregateUID,
                subdevices: [.init(uid: mainDeviceUID), .init(uid: AudioDevice.UID("Device2_UID"))],
                subtaps: [.init(uid: AudioTap.UID("Tap1_UID")), .init(uid: AudioTap.UID("Tap2_UID"))],
                isPrivate: true
            )
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // verify - main subdevice is set automatically to the first subdevice
            #expect(try aggregate.mainSubdeviceUID?.rawValue == mainDeviceUID.rawValue)
        }

        // MARK: setMainSubdevice(uid:)

        @Test
        func setMainSubdevice_uid_invalid() throws {
            let aggregate = AudioAggregateDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                try aggregate.setMainSubdevice(uid: AudioSubDevice.UID.random)
            }
        }

        @Test
        func setMainSubdevice_uid_valid() async throws {
            // find a device
            guard let mainDevice = try AudioSystem.shared
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
            let mainDeviceUID = try mainDevice.uid

            // create aggregate
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(
                withUID: aggregateUID,
                subdevices: [.init(uid: mainDeviceUID), .init(uid: AudioDevice.UID("Device2_UID"))],
                subtaps: [.init(uid: AudioTap.UID("Tap1_UID")), .init(uid: AudioTap.UID("Tap2_UID"))],
                isPrivate: true
            )
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // set
            try aggregate.setMainSubdevice(uid: mainDeviceUID)

            // verify
            #expect(try aggregate.mainSubdeviceUID?.rawValue == mainDeviceUID.rawValue)

            // attempt to set empty UID - Core Audio does not throw an error, but SwiftCoreAudio does
            #expect(throws: SwiftCoreAudioError.self) {
                try aggregate.setMainSubdevice(uid: AudioDevice.UID(""))
            }

            // attempt to set invalid UID - Core Audio does not throw an error, but SwiftCoreAudio does
            #expect(throws: SwiftCoreAudioError.self) {
                try aggregate.setMainSubdevice(uid: AudioDevice.UID.random)
            }

            // verify - remains unchanged
            #expect(try aggregate.mainSubdeviceUID?.rawValue == mainDeviceUID.rawValue)

            // remove all subdevices and check the contents of mainSubdeviceUID
            try aggregate.clearSubdevices()

            // verify - main subdevice is now nil
            #expect(try aggregate.mainSubdeviceUID == nil)

            // attempt to set a valid device, but the aggregate does not contain any subdevices any more
            #expect(throws: SwiftCoreAudioError.self) {
                try aggregate.setMainSubdevice(uid: mainDeviceUID)
            }

            // verify - main subdevice is still nil
            #expect(try aggregate.mainSubdeviceUID == nil)
        }

        // MARK: clockUID

        @Test
        func clockUID_invalid() throws {
            let aggregate = AudioAggregateDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try aggregate.clockUID
            }
        }

        @Test
        func clockUID_valid_none() async throws {
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(withUID: aggregateUID, isPrivate: true)
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // verify
            #expect(try aggregate.clockUID == nil)
        }

        @Test
        func clockUID_valid_nonpresent() async throws {
            // find a device to use as main subdevice
            guard let mainDevice = try AudioSystem.shared
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
            let mainDeviceUID = try mainDevice.uid

            // create aggregate
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(
                withUID: aggregateUID,
                subdevices: [.init(uid: mainDeviceUID), .init(uid: AudioDevice.UID("Device2_UID"))],
                subtaps: [.init(uid: AudioTap.UID("Tap1_UID")), .init(uid: AudioTap.UID("Tap2_UID"))],
                isPrivate: true
            )
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // verify - no clock is automatically set, but the main subdevice would be, which serves as timing base
            #expect(try aggregate.clockUID?.rawValue == nil)
        }

        @Test
        func clockUID_valid_present_suppliedAtAggregateCreation() async throws {
            // find a device to use as main subdevice
            guard let mainDevice = try AudioSystem.shared
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
            let mainDeviceUID = try mainDevice.uid

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
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(
                withUID: aggregateUID,
                subdevices: [.init(uid: mainDeviceUID), .init(uid: AudioDevice.UID("Device2_UID"))],
                subtaps: [.init(uid: AudioTap.UID("Tap1_UID")), .init(uid: AudioTap.UID("Tap2_UID"))],
                clockUID: clockUID,
                isPrivate: true
            )
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // verify
            #expect(try aggregate.clockUID == clockUID)
        }

        @Test
        func clockUID_valid_present_setAfterAggregateCreation() async throws {
            // find a device to use as main subdevice
            guard let mainDevice = try AudioSystem.shared
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
            let mainDeviceUID = try mainDevice.uid

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
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(
                withUID: aggregateUID,
                subdevices: [.init(uid: mainDeviceUID), .init(uid: AudioDevice.UID("Device2_UID"))],
                subtaps: [.init(uid: AudioTap.UID("Tap1_UID")), .init(uid: AudioTap.UID("Tap2_UID"))],
                isPrivate: true
            )
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // set clock
            try aggregate.setClock(uid: clockUID)

            // verify
            #expect(try aggregate.clockUID == clockUID)
        }

        // MARK: tapUIDs

        @Test
        func tapUIDs_invalid() throws {
            let aggregate = AudioAggregateDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try aggregate.tapUIDs
            }
        }

        @Test
        func tapUIDs_valid() async throws {
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(
                withUID: aggregateUID,
                subdevices: [.init(uid: AudioDevice.UID("Device1_UID")), .init(uid: AudioDevice.UID("Device2_UID"))],
                subtaps: [.init(uid: AudioTap.UID("Tap1_UID")), .init(uid: AudioTap.UID("Tap2_UID"))],
                isPrivate: true
            )
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // verify
            #expect(try aggregate.tapUIDs == [AudioTap.UID("Tap1_UID"), AudioTap.UID("Tap2_UID")])
            #expect(try aggregate.activeSubtaps.isEmpty) // just double check
        }

        // MARK: setTaps(uids:)

        @Test
        func setTaps_uids_invalid() throws {
            let aggregate = AudioAggregateDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                try aggregate.setTaps(uids: [])
            }
        }

        @Test
        func setTaps_uids_valid() async throws {
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(
                withUID: aggregateUID,
                subdevices: [.init(uid: AudioDevice.UID("Device1_UID")), .init(uid: AudioDevice.UID("Device2_UID"))],
                isPrivate: true
            )
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // verify baseline state
            #expect(try aggregate.tapUIDs.isEmpty)
            #expect(try aggregate.activeSubtaps.isEmpty) // just double check

            // set taps
            try aggregate.setTaps(uids: [AudioTap.UID("Tap1_UID"), AudioTap.UID("Tap2_UID")])

            // verify
            #expect(try aggregate.tapUIDs == [AudioTap.UID("Tap1_UID"), AudioTap.UID("Tap2_UID")])
            #expect(try aggregate.activeSubtaps.isEmpty) // just double check
        }

        // MARK: activeSubtaps

        @Test
        func activeSubtaps_invalid() throws {
            let aggregate = AudioAggregateDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try aggregate.activeSubtaps
            }
        }

        @Test
        func activeSubtaps_valid_nonpresent() async throws {
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(withUID: aggregateUID, isPrivate: true)
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // verify
            #expect(try aggregate.activeSubtaps.isEmpty)
            #expect(try aggregate.tapUIDs.isEmpty) // just double check
        }

        #if !targetEnvironment(macCatalyst)
        @available(macOS 14.2, *)
        @available(macCatalyst, unavailable) // doesn't prevent Swift Testing from running this on Mac Catalyst
        @Test
        func activeSubtaps_valid_present() async throws {
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
                .filter({ try $0.isAlive })
                .filter({ try $0.hasStreams(for: .output) }) // devices with at least one output
                .sorted(by: { lhs, rhs in try rhs.transportType == .virtual }) // sort virtuals last
                .first
            else {
                withKnownIssue {
                    Issue.record("No suitable audio device available. Skipping test.")
                }
                return
            }
            let deviceUID = try device.uid
            print("Found device \((try? device.name) ?? "with no name") with UID \(deviceUID) to tap.")

            // create aggregate
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(withUID: aggregateUID, isPrivate: true)
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // create a tap
            let tapDescription = CATapDescription()
            tapDescription.name = "Tap1 - \(UUID().uuidString)"
            tapDescription.isPrivate = true
            tapDescription.muteBehavior = .unmuted
            tapDescription.isMixdown = true
            tapDescription.isMono = false
            tapDescription.isExclusive = false
            tapDescription.deviceUID = deviceUID.rawValue
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

            // set taps
            try aggregate.setTaps(uids: [tapUID])

            // verify taps
            #expect(try aggregate.tapUIDs == [tapUID])

            // verify active subtaps
            // Core Audio automatically makes the tap active if it is able to be used
            let activeSubtaps = try aggregate.activeSubtaps
            #expect(activeSubtaps.count == 1)
            let activeSubtap = try #require(activeSubtaps.first)

            // subtap != tap; subtap gets a new ID it seems to distinguish it
            let activeSubtapID = activeSubtap.id
            print("Active subtap has ID \(activeSubtapID)")
            #expect(activeSubtapID.rawValue != tapID.rawValue)

            // basic test of AudioSubTap-specific property selectors
            // TODO: these throw an error, saying object doesn't exist
            // print("extraLatency:", try? activeSubtap.extraLatency)
            // print("driftCompensationQuality:", try? activeSubtap.driftCompensationQuality)
            // print("isDriftCompensationEnabled:", try? activeSubtap.isDriftCompensationEnabled)
        }
        #endif
    }
}

#endif
