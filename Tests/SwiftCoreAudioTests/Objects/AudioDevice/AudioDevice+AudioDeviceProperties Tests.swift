//
//  AudioDevice+AudioDeviceProperties Tests.swift
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
    struct AudioDevice_AudioDeviceProperties_Tests {
        init() {
            CoreAudioLogging.bootstrap()
        }

        // MARK: - CoreAudio/AudioHardwareBase.h

        // MARK: configurationApplication

        @Test
        func configurationApplication_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.configurationApplication
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func configurationApplication_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            // at the time of writing this test, BlackHole did not contain a config app,
            // in which case Core Audio defaults to Audio MIDI Setup.
            #expect(try device.configurationApplication == BundleID("com.apple.audio.AudioMIDISetup"))
        }

        // MARK: deviceUID

        @Test
        func deviceUID_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.deviceUID
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func deviceUID_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            #expect(try device.deviceUID == .blackHole2Ch)
        }

        // MARK: modelUID

        @Test
        func modelUID_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.modelUID
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func modelUID_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            #expect(try device.modelUID == "BlackHole2ch_ModelUID")
        }

        // MARK: transportType

        @Test
        func transportType_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.transportType
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func transportType_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            #expect(try device.transportType == .virtual)
        }

        // MARK: relatedDevices

        @Test
        func relatedDevices_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.relatedDevices
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func relatedDevices_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            #expect(try device.relatedDevices == [device])
        }

        // MARK: clockDomain

        // TODO: add test after implementing the property

        // MARK: isDeviceAlive

        @Test
        func isDeviceAlive_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.isDeviceAlive
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func isDeviceAlive_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            #expect(try device.isDeviceAlive == true)
        }

        // MARK: isDeviceRunning

        @Test
        func isDeviceRunning_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.isDeviceRunning
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func isDeviceRunning_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            // it is hard to know if BlackHole is in use, so just test that the call doesn't throw
            _ = try device.isDeviceRunning
        }

        // MARK: isSettableAsDefaultDevice(for:)

        @Test
        func isSettableAsDefaultDevice_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.isSettableAsDefaultDevice(for: .input)
            }
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.isSettableAsDefaultDevice(for: .output)
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func isSettableAsDefaultDevice_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            // BlackHole contains both inputs and outputs
            #expect(try device.isSettableAsDefaultDevice(for: .input) == true)
            #expect(try device.isSettableAsDefaultDevice(for: .output) == true)
        }

        // MARK: latency(for:)

        @Test
        func latency_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.latency(for: .input)
            }
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.latency(for: .output)
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func latency_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            // BlackHole has zero latency
            #expect(try device.latency(for: .input) == 0)
            #expect(try device.latency(for: .output) == 0)
        }

        // MARK: streams

        @Test
        func streams_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.streams
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func streams_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            #expect(try device.streams.count == 2)
        }

        // MARK: controls

        @Test
        func controls_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.controls
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func controls_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            // we can't know what controls BlackHole has, as it could change in future versions
            // so just ensure it's non-empty, as we know it does contain some controls at least
            #expect(try !device.controls.isEmpty)
        }

        // MARK: safetyOffset(for:)

        @Test
        func safetyOffset_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.safetyOffset(for: .input)
            }
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.safetyOffset(for: .output)
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func safetyOffset_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            // BlackHole has zero safety offset
            #expect(try device.safetyOffset(for: .input) == 0)
            #expect(try device.safetyOffset(for: .output) == 0)
        }

        // MARK: nominalSampleRate

        @Test
        func nominalSampleRate_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.nominalSampleRate
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func nominalSampleRate_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            let sampleRate = try device.nominalSampleRate
            // we can't know what sample rate BlackHole is running at, since sample rate is
            // user-settable, so just ensure this returns a valid value
            #expect(sampleRate > 0)
            #expect(sampleRate <= 768_000) // 768KHz which is the max BlackHole supports
        }

        // MARK: availableNominalSampleRates

        @Test
        func availableNominalSampleRates_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.availableNominalSampleRates
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func availableNominalSampleRates_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            let sampleRates = try device.availableNominalSampleRates
            // we can't know what sample rates BlackHole offers since it may change in future versions,
            // so just ensure at least one sample rate is present and they are all valid values
            #expect(!sampleRates.isEmpty)
            for sampleRate in sampleRates {
                #expect(sampleRate.lowerBound > 0)
                #expect(sampleRate.upperBound <= 768_000) // 768KHz which is the max BlackHole supports
            }
        }

        // MARK: icon

        @Test
        func icon_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.icon
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func icon_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            // BlackHole has an icon, but we can't assume what its file path may be, so
            // just check that the return is non-empty
            #expect(try device.icon != nil)
        }

        // MARK: isHidden

        @Test
        func isHidden_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.isHidden
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func isHidden_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            #expect(try !device.isHidden)
        }

        // MARK: preferredStereoChannels(for:)

        @Test
        func preferredStereoChannels_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.preferredStereoChannels(for: .input)
            }
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.preferredStereoChannels(for: .output)
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func preferredStereoChannels_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            // BlackHole has zero safety offset
            let maybeInputChannels = try device.preferredStereoChannels(for: .input)
            let maybeOutputChannels = try device.preferredStereoChannels(for: .output)
            let inputChannels = try #require(maybeInputChannels)
            let outputChannels = try #require(maybeOutputChannels)

            // it is possible that the user may have changed these channel assignments
            // in Audio MIDI Setup from their default (numbers 1 & 2), but it's extremely unlikely

            // input channel numbers
            #expect(inputChannels.left.number == 1) // 1-based channel number
            #expect(inputChannels.right.number == 2) // 1-based channel number
            // input channel indexes
            #expect(inputChannels.left.index == 1 - 1) // 0-based channel number
            #expect(inputChannels.right.index == 2 - 1) // 0-based channel number

            // output channel numbers
            #expect(outputChannels.left.number == 1) // 1-based channel number
            #expect(outputChannels.right.number == 2) // 1-based channel number
            // output channel indexes
            #expect(outputChannels.left.index == 1 - 1) // 0-based channel number
            #expect(outputChannels.right.index == 2 - 1) // 0-based channel number
        }

        // MARK: preferredChannelLayout

        @Test
        func preferredChannelLayout_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.preferredChannelLayout
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func preferredChannelLayout_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            // BlackHole does not seem to have a preferred channel layout value
            #expect(try device.preferredChannelLayout == nil)
        }

        // MARK: - CoreAudio/AudioHardware.h

        // MARK: plugInLoadStatus

        @Test
        func plugInLoadStatus_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.plugInLoadStatus
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func plugInLoadStatus_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            #expect(try device.plugInLoadStatus == nil)
        }

        // MARK: isDeviceRunningSomewhere

        @Test
        func isDeviceRunningSomewhere_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.isDeviceRunningSomewhere
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func isDeviceRunningSomewhere_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            // it is hard to know if BlackHole is in use, so just test that the call doesn't throw
            _ = try device.isDeviceRunningSomewhere
        }

        // MARK: hogModePID

        @Test
        func hogModePID_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.hogModePID
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func hogModePID_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            // it is hard to know if BlackHole is being hogged, so just test that the call doesn't throw
            _ = try device.hogModePID
        }

        // MARK: bufferFrameSize

        @Test
        func bufferFrameSize_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.bufferFrameSize
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func bufferFrameSize_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            // it is hard to know BlackHole's buffer size, so just test that the call doesn't throw
            let bufferSize = try device.bufferFrameSize
            // check if it's a valid value
            #expect(bufferSize > 0)
            #expect(bufferSize <= 8192) // it's possible for buffer sizes to be > 8192 but unlikely
        }

        // MARK: bufferFrameSizeRange

        @Test
        func bufferFrameSizeRange_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.bufferFrameSizeRange
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func bufferFrameSizeRange_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            // it is hard to know BlackHole's buffer size range, so just test that the call doesn't throw
            let bufferSizeRange = try device.bufferFrameSizeRange
            // check if it's a valid value
            #expect(bufferSizeRange.lowerBound >= 0) // ideally it's not 0 but it could happen
            #expect(bufferSizeRange.upperBound <= 8192) // it's possible for buffer sizes to be > 8192 but unlikely
        }

        // MARK: ioCycleUsage

        @Test
        func ioCycleUsage_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.ioCycleUsage
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func ioCycleUsage_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            // this value varies between 0.0 ... 1.0 at runtime
            let ioCycleUsage = try device.ioCycleUsage
            // check if it's a valid value
            #expect(ioCycleUsage >= 0.0)
            #expect(ioCycleUsage <= 1.0)
        }

        // MARK: streamConfiguration(for:)

        // TODO: add test after implementing the property

        // MARK: ioProcStreamUsage

        // TODO: add test after implementing the property

        // MARK: actualSampleRate

        @Test
        func actualSampleRate_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.actualSampleRate
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func actualSampleRate_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            let sampleRate = try device.actualSampleRate
            // we can't know what sample rate BlackHole is running at, since sample rate is
            // user-settable, so just ensure this returns a valid value
            #expect(sampleRate > 0)
            #expect(sampleRate <= 768_000) // 768KHz which is the max BlackHole supports
        }

        // MARK: clockDeviceUID

        @Test
        func clockDeviceUID_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.clockDeviceUID
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func clockDeviceUID_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            // BlackHole uses an internal clock, so this will return `nil`
            #expect(try device.clockDeviceUID == nil)
        }

        // MARK: isCurrentProcessMuted(for:)

        @Test
        func isCurrentProcessMuted_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.isCurrentProcessMuted(for: .input)
            }
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.isCurrentProcessMuted(for: .output)
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func isCurrentProcessMuted_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            // BlackHole contains both inputs and outputs
            #expect(try device.isCurrentProcessMuted(for: .input) == false)
            #expect(try device.isCurrentProcessMuted(for: .output) == false)
        }

        // MARK: - CoreAudio/AudioHardware.h - Device properties implemented via AudioControl objects

        // MARK: isJackConnected(for:channel:)

        @Test
        func isJackConnected_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.isJackConnected(for: .input, channel: .number(1))
            }
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.isJackConnected(for: .output, channel: .number(1))
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func isJackConnected_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            #expect(try device.isJackConnected(for: .input, channel: nil) == false)
            #expect(try device.isJackConnected(for: .input, channel: .number(1)) == false)
            #expect(try device.isJackConnected(for: .input, channel: .number(2)) == false)
        }

        // MARK: volumeUnitInterval(for:channel:)

        @Test
        func volumeUnitInterval_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.volumeUnitInterval(for: .input, channel: nil)
            }
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.volumeUnitInterval(for: .output, channel: nil)
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func volumeUnitInterval_valid_blackhole_input() throws {
            let device = try #require(AudioDevice.blackHole2Ch)

            // `nil` and `0` are both considered the entire "device" and not a particular channel.
            // this value will be dependent on what volume level the user has the device set to,
            // so we can only check that the call doesn't throw, and returns a value in range (0.0 ... 1.0)
            #expect((0.0 ... 1.0).contains(try device.volumeUnitInterval(for: .input, channel: nil)))

            // individual channels on BlackHole do not have volume controls implemented
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.volumeUnitInterval(for: .input, channel: .number(1))
            }
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.volumeUnitInterval(for: .input, channel: .number(2))
            }

            // channel 3 doesn't exist
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.volumeUnitInterval(for: .input, channel: .number(3))
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func volumeUnitInterval_valid_blackhole_output() throws {
            let device = try #require(AudioDevice.blackHole2Ch)

            // `nil` and `0` are both considered the entire "device" and not a particular channel.
            // this value will be dependent on what volume level the user has the device set to,
            // so we can only check that the call doesn't throw, and returns a value in range (0.0 ... 1.0)
            #expect((0.0 ... 1.0).contains(try device.volumeUnitInterval(for: .output, channel: nil)))

            // individual channels on BlackHole do not have volume controls implemented
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.volumeUnitInterval(for: .output, channel: .number(1))
            }
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.volumeUnitInterval(for: .output, channel: .number(2))
            }

            // channel 3 doesn't exist
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.volumeUnitInterval(for: .output, channel: .number(3))
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.airPodsPro3(.output)))
        func volumeUnitInterval_valid_airPodsPro3_output() throws {
            let device = try #require(AudioDevice.airPodsPro3(.output))

            // AirPods Pro 3 does not have a device output volume control, only per-channel volume controls
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.volumeUnitInterval(for: .output, channel: nil)
            }

            // AirPods Pro 3 is one of the few audio devices that has per-channel output volume controls.
            // these values will be dependent on what volume level the user has the device set to,
            // so we can only check that the call doesn't throw, and returns a value in range (0.0 ... 1.0)
            #expect((0.0 ... 1.0).contains(try device.volumeUnitInterval(for: .output, channel: .number(1))))
            #expect((0.0 ... 1.0).contains(try device.volumeUnitInterval(for: .output, channel: .number(2))))

            // channel 3 doesn't exist
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.volumeUnitInterval(for: .output, channel: .number(3))
            }
        }

        // MARK: setVolumeUnitInterval(for:channel:)

        @Test
        func setVolumeUnitInterval_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                try device.setVolumeUnitInterval(for: .input, channel: nil, to: 1.0)
            }
            #expect(throws: SwiftCoreAudioError.self) {
                try device.setVolumeUnitInterval(for: .output, channel: nil, to: 1.0)
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func setVolumeUnitInterval_valid_blackhole_input() throws {
            let device = try #require(AudioDevice.blackHole2Ch)

            // fetch current value so we can reset them when done
            let initialValue = try device.volumeUnitInterval(for: .input, channel: nil)
            defer { try? device.setVolumeUnitInterval(for: .input, channel: nil, to: initialValue) }

            // set new value
            try device.setVolumeUnitInterval(for: .input, channel: nil, to: 0.5)

            // check new value
            #expect(try device.volumeUnitInterval(for: .input, channel: nil) == 0.5)
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func setVolumeUnitInterval_valid_blackhole_output() throws {
            let device = try #require(AudioDevice.blackHole2Ch)

            // fetch current value so we can reset them when done
            let initialValue = try device.volumeUnitInterval(for: .output, channel: nil)
            defer { try? device.setVolumeUnitInterval(for: .output, channel: nil, to: initialValue) }

            // set new value
            try device.setVolumeUnitInterval(for: .output, channel: nil, to: 0.5)

            // check new value
            #expect(try device.volumeUnitInterval(for: .output, channel: nil) == 0.5)
        }

        @Test(.enabledIfAudioDeviceIsPresent(.airPodsPro3(.output)))
        func setVolumeUnitInterval_valid_airPodsPro3_output() throws {
            let device = try #require(AudioDevice.airPodsPro3(.output))

            // AirPods Pro 3 does not have a device output volume control, only per-channel volume controls
            // AirPods Pro 3 is one of the few audio devices that has per-channel output volume controls.

            // fetch current value so we can reset them when done
            let initialLValue = try device.volumeUnitInterval(for: .output, channel: .number(1))
            let initialRValue = try device.volumeUnitInterval(for: .output, channel: .number(2))
            defer {
                try? device.setVolumeUnitInterval(for: .output, channel: .number(1), to: initialLValue)
                try? device.setVolumeUnitInterval(for: .output, channel: .number(2), to: initialRValue)
            }

            // set new values
            try device.setVolumeUnitInterval(for: .output, channel: .number(1), to: 0.25)
            try device.setVolumeUnitInterval(for: .output, channel: .number(2), to: 0.75)

            // check new value
            #expect(try device.volumeUnitInterval(for: .output, channel: .number(1)) == 0.25)
            #expect(try device.volumeUnitInterval(for: .output, channel: .number(2)) == 0.75)
        }

        // MARK: volumeDBFS(for:channel:)

        @Test
        func volumeDecibels_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.volumeDBFS(for: .input, channel: nil)
            }
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.volumeDBFS(for: .output, channel: nil)
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func volumeDBFS_valid_blackhole_input() throws {
            let device = try #require(AudioDevice.blackHole2Ch)

            // `nil` and `0` are both considered the entire "device" and not a particular channel.
            // this value will be dependent on what volume level the user has the device set to,
            // so we can only check that the call doesn't throw, and returns a value in range.
            // BlackHole uses a dbFS range of `-64.0 ... 0.0`
            #expect((-64.0 ... 0.0).contains(try device.volumeDBFS(for: .input, channel: nil)))

            // individual channels on BlackHole do not have volume controls implemented
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.volumeDBFS(for: .input, channel: .number(1))
            }
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.volumeDBFS(for: .input, channel: .number(2))
            }

            // channel 3 doesn't exist
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.volumeDBFS(for: .input, channel: .number(3))
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func volumeDBFS_valid_blackhole_output() throws {
            let device = try #require(AudioDevice.blackHole2Ch)

            // `nil` and `0` are both considered the entire "device" and not a particular channel.
            // this value will be dependent on what volume level the user has the device set to,
            // so we can only check that the call doesn't throw, and returns a value in range.
            // BlackHole uses a dbFS range of `-64.0 ... 0.0`
            #expect((-64.0 ... 0.0).contains(try device.volumeDBFS(for: .output, channel: nil)))

            // individual channels on BlackHole do not have volume controls implemented
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.volumeDBFS(for: .output, channel: .number(1))
            }
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.volumeDBFS(for: .output, channel: .number(2))
            }

            // channel 3 doesn't exist
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.volumeDBFS(for: .output, channel: .number(3))
            }
        }

        // MARK: setVolumeDBFS(for:channel:)

        @Test
        func setVolumeDBFS_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                try device.setVolumeDBFS(for: .input, channel: nil, to: 1.0)
            }
            #expect(throws: SwiftCoreAudioError.self) {
                try device.setVolumeDBFS(for: .output, channel: nil, to: 1.0)
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func setVolumeDBFS_valid_blackhole_input() throws {
            let device = try #require(AudioDevice.blackHole2Ch)

            // fetch current value so we can reset them when done
            let initialValue = try device.volumeDBFS(for: .input, channel: nil)
            defer { try? device.setVolumeDBFS(for: .input, channel: nil, to: initialValue) }

            // set new value
            try device.setVolumeDBFS(for: .input, channel: nil, to: -20.0)

            // check new value
            #expect(try device.volumeDBFS(for: .input, channel: nil) == -20.0)
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func setVolumeDBFS_valid_blackhole_output() throws {
            let device = try #require(AudioDevice.blackHole2Ch)

            // fetch current value so we can reset them when done
            let initialValue = try device.volumeDBFS(for: .output, channel: nil)
            defer { try? device.setVolumeDBFS(for: .output, channel: nil, to: initialValue) }

            // set new value
            try device.setVolumeDBFS(for: .output, channel: nil, to: -20.0)

            // check new value
            #expect(try device.volumeDBFS(for: .output, channel: nil) == -20.0)
        }

        @Test(.enabledIfAudioDeviceIsPresent(.airPodsPro3(.output)))
        func setVolumeDBFS_valid_airPodsPro3_output() throws {
            let device = try #require(AudioDevice.airPodsPro3(.output))

            // AirPods Pro 3 does not have a device output volume control, only per-channel volume controls
            // AirPods Pro 3 is one of the few audio devices that has per-channel output volume controls.
            // However, Apple is doing something wacky with dBFS values for this device.
            // We can read the values, but setting the values has unpredictable results so we can't test setting.

            // The values seem pinned at -0.15025711 but we'll just test that the methods don't throw
            // an error and the values are within valid dBFS range.
            let lValue = try device.volumeDBFS(for: .output, channel: .number(1))
            let rValue = try device.volumeDBFS(for: .output, channel: .number(2))
            #expect((...0.0).contains(lValue))
            #expect((...0.0).contains(rValue))
        }

        // MARK: volumeRangeDBFS(for:channel:)

        @Test
        func volumeRangeDBFS_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.volumeRangeDBFS(for: .input, channel: nil)
            }
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.volumeRangeDBFS(for: .output, channel: nil)
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func volumeRangeDBFS_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)

            // `nil` and `0` are both considered the entire "device" and not a particular channel.
            // BlackHole uses a dbFS range of `-64.0 ... 0.0`
            #expect(try device.volumeRangeDBFS(for: .input, channel: nil) == -64.0 ... 0.0)

            // individual channels on BlackHole do not have volume controls implemented
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.volumeRangeDBFS(for: .input, channel: .number(1))
            }
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.volumeRangeDBFS(for: .input, channel: .number(2))
            }

            // channel 3 doesn't exist
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.volumeRangeDBFS(for: .input, channel: .number(3))
            }
        }

        // MARK: convertVolumeToDBFS(unitInterval:for:channel:)

        @Test
        func convertVolumeToDBFS_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.convertVolumeToDBFS(unitInterval: 1.0, for: .input, channel: nil)
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.builtInSpeakerDevice))
        func convertVolumeToDBFS_valid_builtInSpeakers() throws {
            let device = try #require(AudioDevice.builtInSpeakerDevice)

            // MacBook Pro Speakers (M1 Max / macOS 26.6) uses a dBFS range of `-63.5 ... 0.0`
            #expect(try device.convertVolumeToDBFS(unitInterval: 0.0, for: .output, channel: nil) == -63.5)
            #expect(try device.convertVolumeToDBFS(unitInterval: 1.0, for: .output, channel: nil) == 0.0)

            // individual channels for this device do not have volume controls
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.convertVolumeToDBFS(unitInterval: 0.0, for: .output, channel: .number(1))
            }

            // device does not have inputs
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.convertVolumeToDBFS(unitInterval: 0.0, for: .input, channel: nil)
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.builtInMicrophoneDevice))
        func convertVolumeToDBFS_valid_builtInMic() throws {
            let device = try #require(AudioDevice.builtInMicrophoneDevice)

            // MacBook Pro Mic (M1 Max / macOS 26.6) uses a dBFS range of `-12.0 ... 12.0`
            #expect(try device.convertVolumeToDBFS(unitInterval: 0.0, for: .input, channel: nil) == -12.0)
            #expect(try device.convertVolumeToDBFS(unitInterval: 1.0, for: .input, channel: nil) == 12.0)

            // individual channels for this device do not have volume controls
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.convertVolumeToDBFS(unitInterval: 0.0, for: .input, channel: .number(1))
            }

            // device does not have outputs
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.convertVolumeToDBFS(unitInterval: 0.0, for: .output, channel: nil)
            }
        }

        // MARK: convertVolumeToUnitInterval(dBFS:for:channel:)

        @Test
        func convertVolumeToUnitInterval_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.convertVolumeToUnitInterval(dBFS: 0.0, for: .input, channel: nil)
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.builtInSpeakerDevice))
        func convertVolumeToUnitInterval_valid_builtInSpeakers() throws {
            let device = try #require(AudioDevice.builtInSpeakerDevice)

            // MacBook Pro Speakers (M1 Max / macOS 26.6) uses a dBFS range of `-63.5 ... 0.0`
            #expect(try device.convertVolumeToUnitInterval(dBFS: -63.5, for: .output, channel: nil) == 0.0)
            #expect(try device.convertVolumeToUnitInterval(dBFS: 0.0, for: .output, channel: nil) == 1.0)

            // individual channels for this device do not have volume controls
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.convertVolumeToUnitInterval(dBFS: 0.0, for: .output, channel: .number(1))
            }

            // device does not have inputs
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.convertVolumeToUnitInterval(dBFS: 0.0, for: .input, channel: nil)
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.builtInMicrophoneDevice))
        func convertVolumeToUnitInterval_valid_builtInMic() throws {
            let device = try #require(AudioDevice.builtInMicrophoneDevice)

            // MacBook Pro Mic (M1 Max / macOS 26.6) uses a dBFS range of `-12.0 ... 12.0`
            #expect(try device.convertVolumeToUnitInterval(dBFS: -12.0, for: .input, channel: nil) == 0.0)
            #expect(try device.convertVolumeToUnitInterval(dBFS: 12.0, for: .input, channel: nil) == 1.0)

            // individual channels for this device do not have volume controls
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.convertVolumeToUnitInterval(dBFS: 0.0, for: .input, channel: .number(1))
            }

            // device does not have outputs
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.convertVolumeToUnitInterval(dBFS: 0.0, for: .output, channel: nil)
            }
        }

        // MARK: stereoPan(for:channel:)

        @Test
        func stereoPan_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.stereoPan(for: .input, channel: nil)
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.builtInSpeakerDevice))
        func stereoPan_valid_builtInSpeakers() throws {
            let device = try #require(AudioDevice.builtInSpeakerDevice)

            // MacBook Pro Speakers (M1 Max / macOS 26.6) have a device-level "Balance" control.
            // Note that this value defaults to 0.5 ("center") but the user may have modified it.
            #expect(try device.stereoPan(for: .output, channel: nil) == 0.5)

            // individual channels for this device do not have pan controls
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.stereoPan(for: .output, channel: .number(1))
            }

            // device does not have inputs
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.stereoPan(for: .input, channel: nil)
            }
        }

        // MARK: setStereoPan(for:channel:)

        @Test
        func setStereoPan_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                try device.setStereoPan(for: .input, channel: nil, to: 0.5)
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.builtInSpeakerDevice))
        func setStereoPan_valid_builtInSpeakers() throws {
            let device = try #require(AudioDevice.builtInSpeakerDevice)

            // fetch current value so we can reset them when done
            let initialValue = try device.stereoPan(for: .output, channel: nil)
            defer { try? device.setStereoPan(for: .output, channel: nil, to: initialValue) }

            // set new value
            try device.setStereoPan(for: .output, channel: nil, to: 0.25)

            // check new value
            #expect(try device.stereoPan(for: .output, channel: nil) == 0.25)
        }

        // MARK: stereoPanChannels(for:)

        @Test
        func stereoPanChannels_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.stereoPanChannels(for: .input)
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.builtInSpeakerDevice))
        func stereoPanChannels_valid_builtInSpeakers() throws {
            let device = try #require(AudioDevice.builtInSpeakerDevice)

            #expect(try device.stereoPanChannels(for: .output) == .init(leftNumber: 1, rightNumber: 2))

            // device does not have inputs
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.stereoPanChannels(for: .input)
            }
        }

        // MARK: isMuted(for:channel:)

        @Test
        func isMuted_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.isMuted(for: .input, channel: nil)
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func isMuted_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)

            // Note that the user may have muted the device. We are assuming the default state of unmuted here.
            #expect(try device.isMuted(for: .input, channel: nil) == false)
            #expect(try device.isMuted(for: .output, channel: nil) == false)

            // individual channels for this device do not have mute controls
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.isMuted(for: .input, channel: .number(1))
            }
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.isMuted(for: .output, channel: .number(1))
            }
        }

        // MARK: setIsMuted(for:channel:)

        @Test
        func setIsMuted_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                try device.setIsMuted(for: .input, channel: nil, to: true)
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.builtInSpeakerDevice))
        func setIsMuted_valid_builtInSpeakers() throws {
            let device = try #require(AudioDevice.builtInSpeakerDevice)

            // fetch current value so we can reset them when done
            let initialValue = try device.isMuted(for: .output, channel: nil)
            defer { try? device.setIsMuted(for: .output, channel: nil, to: initialValue) }

            // set new value
            let newValue = !initialValue
            try device.setIsMuted(for: .output, channel: nil, to: newValue)

            // check new value
            #expect(try device.isMuted(for: .output, channel: nil) == newValue)
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func setIsMuted_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)

            // fetch current value so we can reset them when done
            let initialValue = try device.isMuted(for: .output, channel: nil)
            defer { try? device.setIsMuted(for: .output, channel: nil, to: initialValue) }

            // set new value
            let newValue = !initialValue
            try device.setIsMuted(for: .output, channel: nil, to: newValue)

            // check new value
            #expect(try device.isMuted(for: .output, channel: nil) == newValue)
        }

        // MARK: isSoloed(for:channel:)

        @Test
        func isSoloed_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.isSoloed(for: .input, channel: nil)
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.builtInSpeakerDevice))
        func isSoloed_valid_builtInSpeakers() throws {
            let device = try #require(AudioDevice.builtInSpeakerDevice)

            // MacBook Pro Speakers (M1 Max / macOS 26.6) does not have any solo controls
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.isSoloed(for: .output, channel: nil)
            }
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.isSoloed(for: .output, channel: .number(1))
            }

            // device does not have inputs
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.isSoloed(for: .input, channel: nil)
            }
        }

        // MARK: setIsSoloed(for:channel:)

        @Test
        func setIsSoloed_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                try device.setIsSoloed(for: .input, channel: nil, to: true)
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.builtInSpeakerDevice))
        func setIsSoloed_valid_builtInSpeakers() throws {
            let device = try #require(AudioDevice.builtInSpeakerDevice)

            // MacBook Pro Speakers (M1 Max / macOS 26.6) does not have any solo controls
            #expect(throws: SwiftCoreAudioError.self) {
                try device.setIsSoloed(for: .output, channel: nil, to: true)
            }
        }

        // MARK: isPhantomPowerEnabled(forInputChannel:)

        @Test
        func isPhantomPowerEnabled_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.isPhantomPowerEnabled(forInputChannel: .number(1))
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.builtInSpeakerDevice))
        func isPhantomPowerEnabled_valid_builtInSpeakers() throws {
            let device = try #require(AudioDevice.builtInSpeakerDevice)

            // MacBook Pro Speakers (M1 Max / macOS 26.6) does not have any solo controls
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.isPhantomPowerEnabled(forInputChannel: nil)
            }
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.isPhantomPowerEnabled(forInputChannel: .number(1))
            }
        }

        // MARK: setIsPhantomPowerEnabled(forInputChannel:)

        @Test
        func setIsPhantomPowerEnabled_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                try device.setIsPhantomPowerEnabled(forInputChannel: .number(1), to: true)
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.builtInSpeakerDevice))
        func setIsPhantomPowerEnabled_valid_builtInSpeakers() throws {
            let device = try #require(AudioDevice.builtInSpeakerDevice)

            // MacBook Pro Speakers (M1 Max / macOS 26.6) does not have any solo controls
            #expect(throws: SwiftCoreAudioError.self) {
                try device.setIsPhantomPowerEnabled(forInputChannel: nil, to: true)
            }
            #expect(throws: SwiftCoreAudioError.self) {
                try device.setIsPhantomPowerEnabled(forInputChannel: .number(1), to: true)
            }

            // device does not have inputs
            #expect(throws: SwiftCoreAudioError.self) {
                try device.setIsPhantomPowerEnabled(forInputChannel: nil, to: true)
            }
        }

        // MARK: isPhaseInverted(forInputChannel:)

        @Test
        func isPhaseInverted_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.isPhaseInverted(for: .input, channel: .number(1))
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.builtInSpeakerDevice))
        func isPhaseInverted_valid_builtInSpeakers() throws {
            let device = try #require(AudioDevice.builtInSpeakerDevice)

            // MacBook Pro Speakers (M1 Max / macOS 26.6) does not have any phase invert controls
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.isPhaseInverted(for: .output, channel: nil)
            }
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.isPhaseInverted(for: .output, channel: .number(1))
            }

            // device does not have inputs
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.isPhaseInverted(for: .input, channel: .number(1))
            }
        }

        // MARK: setIsPhaseInverted(forInputChannel:)

        @Test
        func setIsPhaseInverted_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                try device.setIsPhaseInverted(for: .input, channel: .number(1), to: true)
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.builtInSpeakerDevice))
        func setIsPhaseInverted_valid_builtInSpeakers() throws {
            let device = try #require(AudioDevice.builtInSpeakerDevice)

            // MacBook Pro Speakers (M1 Max / macOS 26.6) does not have any phase invert controls
            #expect(throws: SwiftCoreAudioError.self) {
                try device.setIsPhaseInverted(for: .output, channel: nil, to: true)
            }
            #expect(throws: SwiftCoreAudioError.self) {
                try device.setIsPhaseInverted(for: .output, channel: .number(1), to: true)
            }

            // device does not have inputs
            #expect(throws: SwiftCoreAudioError.self) {
                try device.setIsPhaseInverted(for: .input, channel: nil, to: true)
            }
        }

        // MARK: isClipLightOn(for:channel:)

        @Test
        func isClipLightOn_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.isClipLightOn(for: .input, channel: .number(1))
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.builtInSpeakerDevice))
        func isClipLightOn_valid_builtInSpeakers() throws {
            let device = try #require(AudioDevice.builtInSpeakerDevice)

            // MacBook Pro Speakers (M1 Max / macOS 26.6) does not have any clip light controls
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.isClipLightOn(for: .output, channel: nil)
            }
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.isClipLightOn(for: .output, channel: .number(1))
            }

            // device does not have inputs
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.isClipLightOn(for: .input, channel: .number(1))
            }
        }

        // MARK: setIsClipLightOn(forInputChannel:)

        @Test
        func setIsClipLightOn_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                try device.setIsClipLightOn(for: .input, channel: .number(1), to: true)
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.builtInSpeakerDevice))
        func setIsClipLightOn_valid_builtInSpeakers() throws {
            let device = try #require(AudioDevice.builtInSpeakerDevice)

            // MacBook Pro Speakers (M1 Max / macOS 26.6) does not have any clip light controls
            #expect(throws: SwiftCoreAudioError.self) {
                try device.setIsClipLightOn(for: .output, channel: nil, to: true)
            }
            #expect(throws: SwiftCoreAudioError.self) {
                try device.setIsClipLightOn(for: .output, channel: .number(1), to: true)
            }

            // device does not have inputs
            #expect(throws: SwiftCoreAudioError.self) {
                try device.setIsClipLightOn(for: .input, channel: nil, to: true)
            }
        }

        // MARK: isTalkbackEnabled

        @Test
        func isTalkbackEnabled_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.isTalkbackEnabled
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.builtInSpeakerDevice))
        func isTalkbackEnabled_valid_builtInSpeakers() throws {
            let device = try #require(AudioDevice.builtInSpeakerDevice)

            // MacBook Pro Speakers (M1 Max / macOS 26.6) does not have any talkback controls
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.isTalkbackEnabled
            }
        }

        // MARK: setIsTalkbackEnabled

        @Test
        func setIsTalkbackEnabled_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                try device.setIsTalkbackEnabled(to: true)
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.builtInSpeakerDevice))
        func setIsTalkbackEnabled_valid_builtInSpeakers() throws {
            let device = try #require(AudioDevice.builtInSpeakerDevice)

            // MacBook Pro Speakers (M1 Max / macOS 26.6) does not have any talkback controls
            #expect(throws: SwiftCoreAudioError.self) {
                try device.setIsTalkbackEnabled(to: false)
            }
        }

        // MARK: isListenbackEnabled

        @Test
        func isListenbackEnabled_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.isListenbackEnabled
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.builtInSpeakerDevice))
        func isListenbackEnabled_valid_builtInSpeakers() throws {
            let device = try #require(AudioDevice.builtInSpeakerDevice)

            // MacBook Pro Speakers (M1 Max / macOS 26.6) does not have any listenback controls
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.isListenbackEnabled
            }
        }

        // MARK: setIsListenbackEnabled

        @Test
        func setIsListenbackEnabled_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                try device.setIsListenbackEnabled(to: true)
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.builtInSpeakerDevice))
        func setIsListenbackEnabled_valid_builtInSpeakers() throws {
            let device = try #require(AudioDevice.builtInSpeakerDevice)

            // MacBook Pro Speakers (M1 Max / macOS 26.6) does not have any listenback controls
            #expect(throws: SwiftCoreAudioError.self) {
                try device.setIsListenbackEnabled(to: false)
            }
        }

        // MARK: dataSourceIDs(for:)

        @Test
        func dataSourceIDs_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.dataSourceIDs(for: .input)
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func dataSourceIDs_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)

            // BlackHole does not have data source IDs
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.dataSourceIDs(for: .input)
            }
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.dataSourceIDs(for: .output)
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.builtInSpeakerDevice))
        func dataSourceIDs_valid_builtInSpeakers() throws {
            let device = try #require(AudioDevice.builtInSpeakerDevice)

            // MacBook Pro Speakers (M1 Max / macOS 26.6) has one device-level data source ID
            #expect(try device.dataSourceIDs(for: .output).count == 1)

            // device does not have inputs
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.dataSourceIDs(for: .input)
            }
        }

        // MARK: dataSourcesIDs(for:)

        @Test
        func dataSourcesIDs_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.dataSourcesIDs(for: .input)
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func dataSourcesIDs_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)

            // BlackHole does not have data source IDs
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.dataSourcesIDs(for: .input)
            }
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.dataSourcesIDs(for: .output)
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.builtInSpeakerDevice))
        func dataSourcesIDs_valid_builtInSpeakers() throws {
            let device = try #require(AudioDevice.builtInSpeakerDevice)

            // MacBook Pro Speakers (M1 Max / macOS 26.6) has one device-level data source ID
            #expect(try device.dataSourcesIDs(for: .output).count == 1)

            // device does not have inputs
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.dataSourcesIDs(for: .input)
            }
        }

        // MARK: dataSourceName(for:ofID:)

        @Test
        func dataSourceNameForID_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.dataSourceName(for: .input, ofID: 123)
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.builtInSpeakerDevice))
        func dataSourceNameForID_valid_builtInSpeakers() throws {
            let device = try #require(AudioDevice.builtInSpeakerDevice)

            // MacBook Pro Speakers (M1 Max / macOS 26.6) has one device-level data source ID
            let ids = try device.dataSourceIDs(for: .output)
            #expect(ids.count == 1)
            let id = try #require(ids.first)
            let name = try device.dataSourceName(for: .output, ofID: id)
            #expect(BuiltInSpeakers.names.contains(name))
        }

        // MARK: dataSourceKind(for:ofID:)

        @Test
        func dataSourceKindForID_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.dataSourceKind(for: .input, ofID: 123)
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.builtInSpeakerDevice))
        func dataSourceKindForID_valid_builtInSpeakers() throws {
            let device = try #require(AudioDevice.builtInSpeakerDevice)

            // MacBook Pro Speakers (M1 Max / macOS 26.6) has one device-level data source ID
            let ids = try device.dataSourceIDs(for: .output)
            #expect(ids.count == 1)
            let id = try #require(ids.first)

            // no data source kind is reported (property not implemented)
            #expect(throws: SwiftCoreAudioError.self) {
                try device.dataSourceKind(for: .output, ofID: id)
            }
        }

        // MARK: clockSourceIDs

        @Test
        func clockSourceIDs_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.clockSourceIDs
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func clockSourceIDs_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)

            // BlackHole has one clock source ID
            #expect(try device.clockSourceIDs == [0])
        }

        @Test(.enabledIfAudioDeviceIsPresent(.builtInSpeakerDevice))
        func clockSourceIDs_valid_builtInSpeakers() throws {
            let device = try #require(AudioDevice.builtInSpeakerDevice)

            // MacBook Pro Speakers (M1 Max / macOS 26.6) does not report any clock source IDs
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.clockSourceIDs
            }
        }

        // MARK: clockSourcesIDs

        @Test
        func clockSourcesIDs_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.clockSourcesIDs
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func clockSourcesIDs_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)

            // BlackHole has two clock sources IDs
            #expect(try device.clockSourcesIDs == [0, 1])
        }

        @Test(.enabledIfAudioDeviceIsPresent(.builtInSpeakerDevice))
        func clockSourcesIDs_valid_builtInSpeakers() throws {
            let device = try #require(AudioDevice.builtInSpeakerDevice)

            // MacBook Pro Speakers (M1 Max / macOS 26.6) does not report any clock source IDs
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.clockSourcesIDs
            }
        }

        // MARK: clockSourceName(ofID:)

        @Test
        func clockSourceName_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.clockSourceName(ofID: 123)
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func clockSourceName_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)

            // BlackHole has two clock sources IDs
            let ids = try device.clockSourcesIDs
            try #require(ids.count == 2)
            let id0 = ids[0]
            let id1 = ids[1]
            #expect(try device.clockSourceName(ofID: id0) == "Internal Fixed")
            #expect(try device.clockSourceName(ofID: id1) == "Internal Adjustable")
        }

        // MARK: clockSourceKind(ofID:)

        @Test
        func clockSourceKind_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.clockSourceKind(ofID: 123)
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func clockSourceKind_valid_blackhole() throws {
            let device = try #require(AudioDevice.blackHole2Ch)

            // BlackHole has two clock sources IDs
            let ids = try device.clockSourcesIDs
            try #require(ids.count == 2)
            let id0 = ids[0]
            let id1 = ids[1]

            // no data source kind is reported (property not implemented)
            #expect(throws: SwiftCoreAudioError.self) {
                try device.clockSourceKind(ofID: id0)
            }
            #expect(throws: SwiftCoreAudioError.self) {
                try device.clockSourceKind(ofID: id1)
            }
        }

        // MARK: isPlayThruEnabled(for:channel:)

        

        // TODO: finish unit tests
    }
}

#endif
