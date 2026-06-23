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
        // MARK: configurationApplication

        @Test
        func configurationApplication_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.configurationApplication
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func configurationApplication_valid() throws {
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
        func deviceUID_valid() throws {
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
        func modelUID_valid() throws {
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
        func transportType_valid() throws {
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
        func relatedDevices_valid() throws {
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
        func isDeviceAlive_valid() throws {
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
        func isDeviceRunning_valid() throws {
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
        func isSettableAsDefaultDevice_valid() throws {
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
        func latency_valid() throws {
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
        func streams_valid() throws {
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
        func controls_valid() throws {
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
        func safetyOffset_valid() throws {
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
        func nominalSampleRate_valid() throws {
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
        func availableNominalSampleRates_valid() throws {
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
        func icon_valid() throws {
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
        func isHidden_valid() throws {
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
        func preferredStereoChannels_valid() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            // BlackHole has zero safety offset
            let maybeInputChannels = try device.preferredStereoChannels(for: .input)
            let maybeOutputChannels = try device.preferredStereoChannels(for: .output)
            let inputChannels = try #require(maybeInputChannels)
            let outputChannels = try #require(maybeOutputChannels)
            // it is possible that the user may have changed these channel assignments
            // in Audio MIDI Setup from their default (1 & 2), but it's extremely unlikely
            #expect(inputChannels == (1, 2))
            #expect(outputChannels == (1, 2))
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
        func preferredChannelLayout_valid() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            // BlackHole does not seem to have a preferred channel layout value
            #expect(try device.preferredChannelLayout == nil)
        }

        // MARK: plugInLoadStatus

        @Test
        func plugInLoadStatus_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.plugInLoadStatus
            }
        }

        @Test(.enabledIfAudioDeviceIsPresent(.blackHole2Ch))
        func plugInLoadStatus_valid() throws {
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
        func isDeviceRunningSomewhere_valid() throws {
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
        func hogModePID_valid() throws {
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
        func bufferFrameSize_valid() throws {
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
        func bufferFrameSizeRange_valid() throws {
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
        func ioCycleUsage_valid() throws {
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
        func actualSampleRate_valid() throws {
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
        func clockDeviceUID_valid() throws {
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
        func isCurrentProcessMuted_valid() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            // BlackHole contains both inputs and outputs
            #expect(try device.isCurrentProcessMuted(for: .input) == false)
            #expect(try device.isCurrentProcessMuted(for: .output) == false)
        }
    }
}

#endif
