//
//  AudioSystem+Properties Tests.swift
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
    struct AudioSystem_Properties_Tests {
        // MARK: devices
        
        @Test
        func devices() throws {
            // get current system state
            let initialDevices = try AudioSystem.shared.devices
            
            // create an aggregate
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try AudioSystem.shared.makeAggregateDevice(withUID: aggregateUID, isPrivate: true)
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope
            
            // get system state again
            let updatedDevices = try AudioSystem.shared.devices
            
            // verify
            #expect(updatedDevices.count == initialDevices.count + 1)
            #expect(updatedDevices.contains(where: { $0.id.rawValue == aggregate.id.rawValue }))
        }
        
        // MARK: box(forUID:)
        
        @Test
        func audioBoxID_invalidUID() throws {
            let randomUID: AudioBox.UID = .random
            let box = try AudioSystem.shared.box(forUID: randomUID)
            #expect(box == nil)
        }
        
        /// Note: This test only runs if BlackHole 2ch is installed.
        @Test(.enabledIfAudioDevicePresent(.blackHole2Ch))
        func audioBoxID_valid() throws {
            let maybeBox = try AudioSystem.shared.box(forUID: .blackHole2Ch)
            let box = try #require(maybeBox)
            #expect(try box.boxUID == .blackHole2Ch)
        }
        
        // MARK: defaultInputDevice
        
        /// This test assumes there is at least one audio device in the system, such that it would
        /// be made default.
        @Test
        func defaultInputDevice() throws {
            #expect(try AudioSystem.shared.defaultInputDevice.id.rawValue != kAudioObjectUnknown)
        }
        
        // MARK: defaultOutputDevice
        
        /// This test assumes there is at least one audio device in the system, such that it would
        /// be made default.
        @Test
        func defaultOutputDevice() throws {
            #expect(try AudioSystem.shared.defaultOutputDevice.id.rawValue != kAudioObjectUnknown)
        }
        
        // MARK: defaultOutputDeviceForSystemSounds
        
        /// This test assumes there is at least one audio device in the system, such that it would
        /// be made default.
        @Test
        func defaultOutputDeviceForSystemSounds() throws {
            #expect(try AudioSystem.shared.defaultOutputDeviceForSystemSounds.id.rawValue != kAudioObjectUnknown)
        }
        
        // MARK: device(forUID: AnyAudioDevice.ID)
        
        @Test
        func device_forUID_anyAudioDevice_invalidUID() throws {
            let randomUID: AnyAudioDevice.UID = .random
            let device = try AudioSystem.shared.device(forUID: randomUID)
            #expect(device == nil)
        }
        
        /// Note: This test only runs if BlackHole 2ch is installed.
        @Test(.enabledIfAudioDevicePresent(.blackHole2Ch))
        func device_forUID_anyAudioDevice_valid() throws {
            let maybeDevice: AnyAudioDevice? = try AudioSystem.shared.device(forUID: AnyAudioDevice.UID.blackHole2Ch)
            let device = try #require(maybeDevice)
            #expect(device == .blackHole2Ch)
        }
        
        // MARK: device(forUID: AudioDevice.ID)
        
        @Test
        func device_forUID_audioDevice_invalidUID() throws {
            let randomUID: AudioDevice.UID = .random
            let device = try AudioSystem.shared.device(forUID: randomUID)
            #expect(device == nil)
        }
        
        /// Note: This test only runs if BlackHole 2ch is installed.
        @Test(.enabledIfAudioDevicePresent(.blackHole2Ch))
        func device_forUID_audioDevice_valid() throws {
            let maybeDevice: AudioDevice? = try AudioSystem.shared.device(forUID: AudioDevice.UID.blackHole2Ch)
            let device = try #require(maybeDevice)
            #expect(device == .blackHole2Ch)
        }
        
        // MARK: device(forUID: AudioAggregateDevice.ID)
        
        @Test
        func device_forUID_audioAggregateDevice_invalidUID() throws {
            let randomUID: AudioAggregateDevice.UID = .random
            let device = try AudioSystem.shared.device(forUID: randomUID)
            #expect(device == nil)
        }
        
        @Test
        func device_forUID_audioAggregateDevice_valid() throws {
            // create an aggregate
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try AudioSystem.shared.makeAggregateDevice(withUID: aggregateUID, isPrivate: true)
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope
            
            // lookup device
            let maybeDevice: AudioAggregateDevice? = try AudioSystem.shared.device(forUID: aggregateUID)
            let device = try #require(maybeDevice)
            #expect(device == aggregate)
        }
        
        // MARK: isStereoMixedDownToMono
        
        @Test
        func isStereoMixedDownToMono() throws {
            // we can't know what the value of this property is since it is user-settable, so just
            // ensure the call does not throw
            _ = try AudioSystem.shared.isStereoMixedDownToMono
        }
        
        // MARK: plugIns
        
        @Test
        func plugIns() throws {
            let plugIns = try AudioSystem.shared.plugIns
            // we can't know what plug-ins may be present, so just ensure an error isn't thrown and
            // that the array isn't empty
            #expect(!plugIns.isEmpty)
        }
        
        // MARK: plugIn(forBundleID:)
        
        @Test
        func plugIn_forBundleID_invalid() throws {
            let randomBundleID: BundleID = .random
            #expect(try AudioSystem.shared.plugIn(forBundleID: randomBundleID) == nil)
        }
        
        @Test
        func plugIn_forBundleID_valid() throws {
            // we can't know what plug-ins may be present, but we can grab a bundle ID from one of the
            // plug-ins found in the system and use that to test this function
            let plugIns = try AudioSystem.shared.plugIns
            
            // find a plug-in to use
            guard let plugIn = try plugIns.first(where: { try $0.bundleID != nil })
            else {
                withKnownIssue {
                    Issue.record("No plug-ins available in the system to test. Skipping test.")
                }
                return
            }
            let maybeBundleID = try plugIn.bundleID
            let bundleID = try #require(maybeBundleID)
            
            // get plugin by bundle ID
            let foundPlugIn = try AudioSystem.shared.plugIn(forBundleID: bundleID)
            #expect(foundPlugIn == plugIn)
        }
        
        // MARK: transportManagers
        
        @Test
        func transportManagers() throws {
            // we can't know what transport managers may be present, so just ensure an error isn't thrown.
            // it's possible there may be none present, so we can't really test the contents of the array.
            _ = try AudioSystem.shared.transportManagers
        }
        
        // MARK: transportManager(forBundleID:)
        
        @Test
        func transportManager_forBundleID_invalid() throws {
            // we can't know what transport managers may be present, and there is no way to ask a
            // transport manager what its bundle ID is, so it is not trivial to test looking up a
            // transport manager by its bundle ID
            
            let randomBundleID: BundleID = .random
            #expect(try AudioSystem.shared.transportManager(forBundleID: randomBundleID) == nil)
        }
        
        @Test
        func transportManager_forBundleID_valid() throws {
            // we can't know what transport managers may be present, but if any are present, we can grab a
            // bundle ID from one of them and use that to test this function
            let transportManagers = try AudioSystem.shared.transportManagers
            
            // find a transport manager to use
            guard let manager = try transportManagers.first(where: { try $0.bundleID != nil })
            else {
                withKnownIssue {
                    Issue.record("No transport managers available in the system to test. Skipping test.")
                }
                return
            }
            let maybeBundleID = try manager.bundleID // bundleID property is provided by AudioPlugIn properties
            let bundleID = try #require(maybeBundleID)
            
            // get transport manager by bundle ID
            let foundManager = try AudioSystem.shared.transportManager(forBundleID: bundleID)
            #expect(foundManager == manager)
        }
        
        // MARK: boxes
        
        @Test
        func boxes() throws {
            let boxes = try AudioSystem.shared.boxes
            // we can't know what boxes may be present, so just ensure an error isn't thrown and
            // that the array isn't empty
            #expect(!boxes.isEmpty)
        }
        
        // MARK: box(forUID:)
        
        @Test
        func box_forUID_invalid() throws {
            let randomUID: AudioBox.UID = .random
            let box = try AudioSystem.shared.box(forUID: randomUID)
            #expect(box == nil)
        }
        
        /// Note: This test only runs if BlackHole 2ch is installed.
        @Test(.enabledIfAudioDevicePresent(.blackHole2Ch))
        func box_forUID_audioDevice_valid() throws {
            let maybeBox = try AudioSystem.shared.box(forUID: .blackHole2Ch)
            let box = try #require(maybeBox)
            #expect(box == .blackHole2Ch)
        }
        
        // MARK: clocks
        
        @Test
        func clocks() throws {
            let clocks = try AudioSystem.shared.clocks
            // we can't know what clocks may be present, so just ensure an error isn't thrown and
            // that the array isn't empty
            #expect(!clocks.isEmpty)
        }
        
        // MARK: clock(forUID:)
        
        @Test
        func clock_forUID_invalid() throws {
            let randomUID: AudioClock.UID = .random
            let clock = try AudioSystem.shared.clock(forUID: randomUID)
            #expect(clock == nil)
        }
        
        @Test
        func clock_forUID_valid() throws {
            // we can't know what clocks may be present, but we can grab a UID from one of the
            // clocks found in the system and use that to test this function
            let clocks = try AudioSystem.shared.clocks
            
            // find a clock to use
            guard let clock = clocks.first(where: { (try? $0.uid ) != nil })
            else {
                withKnownIssue {
                    Issue.record("No clocks available in the system to test. Skipping test.")
                }
                return
            }
            let uid = try clock.uid
            
            // get clock by UID
            let foundClock = try AudioSystem.shared.clock(forUID: uid)
            #expect(foundClock == clock)
        }
        
        // MARK: isProcessMain
        
        @Test
        func isProcessMain() throws {
            // we won't test the returned value itself, just test that this does not throw an error
            _ = try AudioSystem.shared.isProcessMain
        }
        
        // MARK: isInitingOrExiting
        
        @Test
        func isInitingOrExiting() throws {
            // we can reasonably expect this is always false during our tests
            #expect(try !AudioSystem.shared.isInitingOrExiting)
        }
        
        // MARK: isProcessMuted(for:)
        
        @Test
        func isProcessMuted_for() throws {
            // we won't test the returned value itself, just test that these do not throw an error
            _ = try AudioSystem.shared.isProcessMuted(for: .input)
            _ = try AudioSystem.shared.isProcessMuted(for: .output)
        }
        
        // MARK: isSleepingAllowed
        
        @Test
        func isSleepingAllowed() throws {
            // we can reasonably expect this is always false during our tests
            #expect(try !AudioSystem.shared.isSleepingAllowed)
        }
        
        // MARK: isUnloadingAllowed
        
        @Test
        func isUnloadingAllowed() throws {
            // we can reasonably expect this is always false during our tests
            #expect(try !AudioSystem.shared.isUnloadingAllowed)
        }
        
        // MARK: isUnloadingAllowed
        
        @Test
        func isHogModeAllowed() throws {
            // we can reasonably expect this is always true during our tests
            #expect(try AudioSystem.shared.isHogModeAllowed)
        }
        
        // MARK: isUserSessionForProcessActiveOrHeadless
        
        @Test
        func isUserSessionForProcessActiveOrHeadless() throws {
            // we can reasonably expect this is always true during our tests
            #expect(try AudioSystem.shared.isUserSessionForProcessActiveOrHeadless)
        }
        
        // MARK: powerHint
        
        @Test
        func powerHint() throws {
            // we can't know what this value will be, so just test that it doesn't throw an error
            _ = try AudioSystem.shared.powerHint
        }
        
        // MARK: processes
        
        @Test func processes() throws {
            let processes = try AudioSystem.shared.processes
            // we can't know what processes may be present, so just ensure an error isn't thrown and
            // that the array isn't empty
            #expect(!processes.isEmpty)
        }
        
        // MARK: process(forPID:)
        
        @Test
        func process_forPID_invalid() throws {
            let pid: PID = .randomUnused
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try AudioSystem.shared.process(forPID: pid)
            }
        }
        
        @Test
        func process_forPID_valid() throws {
            // we can't know what audio processes may be present, but we can grab a process from one of the
            // processes found in the system and use that to test this function
            let processes = try AudioSystem.shared.processes
            
            // find a process to use
            guard let process = processes.first(where: { (try? $0.pid ) != nil })
            else {
                withKnownIssue {
                    Issue.record("No audio processes available in the system to test. Skipping test.")
                }
                return
            }
            let pid = try process.pid
            
            // get process by PID
            let foundProcess = try AudioSystem.shared.process(forPID: pid)
            #expect(foundProcess == process)
        }
        
        // MARK: taps
        
        @Test func taps() throws {
            // we can't know what taps may be present, and often there may be none, so just ensure an
            // error isn't thrown
            _ = try AudioSystem.shared.taps
        }
        
        // MARK: tap(forUID:)
        
        @Test
        func tap_forUID_invalid() throws {
            let randomUID: AudioClock.UID = .random
            let clock = try AudioSystem.shared.clock(forUID: randomUID)
            #expect(clock == nil)
        }
        
        @Test
        func tap_forUID_valid_nonpresent() throws {
            // we can't know what taps may be present, but we can grab a UID from one of the
            // taps found in the system and use that to test this function
            let taps = try AudioSystem.shared.taps
            
            // find a tap to use
            guard let tap = taps.first(where: { (try? $0.uid ) != nil })
            else {
                withKnownIssue {
                    Issue.record("No taps available in the system to test. Skipping test.")
                }
                return
            }
            let uid = try tap.uid
            
            // get tap by UID
            let foundTap = try AudioSystem.shared.tap(forUID: uid)
            #expect(foundTap == tap)
        }
        
        #if !targetEnvironment(macCatalyst)
        @available(macOS 14.2, *)
        @available(macCatalyst, unavailable) // doesn't prevent Swift Testing from running this on Mac Catalyst
        @Test
        func tap_forUID_and_taps_valid_present() throws {
            // find a device to tap
            guard let device = try AudioSystem.shared.devices.audioDevices
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
            print("Found device \(try device.name ?? "with no name") with UID \(deviceUID) to tap.")
            
            // create a tap
            let tapDescription = CATapDescription()
            tapDescription.name = UUID().uuidString
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
            
            // check tap in system taps
            #expect(try AudioSystem.shared.taps.contains(tap))
            
            // look up tap by UID
            #expect(try AudioSystem.shared.tap(forUID: tapUID) == tap)
        }
        #endif
    }
}
