//
//  AudioDevice+AudioDeviceProperties+Convenience Tests.swift
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
    struct AudioDevice_AudioDeviceProperties_Convenience_Tests {
        // MARK: channelCount(for:)

        @Test
        func channelCount_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.channelCount(for: .input)
            }
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.channelCount(for: .output)
            }
        }

        @Test(.enabledIfAudioDevicePresent(.blackHole2Ch))
        func channelCount_valid() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            // BlackHole contains 2 input channels (stereo) and 2 output channels (stereo)
            #expect(try device.channelCount(for: .input) == 2)
            #expect(try device.channelCount(for: .output) == 2)
        }

        // MARK: channelCounts

        @Test
        func channelCounts_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.channelCounts
            }
        }

        @Test(.enabledIfAudioDevicePresent(.blackHole2Ch))
        func channelCounts_valid() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            #expect(try device.channelCounts == (inputs: 2, outputs: 2))
        }

        // MARK: channelName

        @Test
        func channelName_invalid() throws {
            let device = AudioDevice(id: .randomUnused)

            // 0 is invalid chan # - channels are 1-based, not 0-based
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.channelName(forChannelNumber: 0, of: .input)
            }
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.channelName(forChannelNumber: 0, of: .output)
            }

            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.channelName(forChannelNumber: 1, of: .input)
            }
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.channelName(forChannelNumber: 1, of: .output)
            }
        }

        @Test(.enabledIfAudioDevicePresent(.blackHole2Ch))
        func channelName_valid() throws {
            let device = try #require(AudioDevice.blackHole2Ch)

            // 0 is invalid chan # - channels are 1-based, not 0-based, but we get `nil` instead of an error
            #expect(try device.channelName(forChannelNumber: 0, of: .input) == nil)
            #expect(try device.channelName(forChannelNumber: 0, of: .output) == nil)

            // since channel names are user-editable in Audio MIDI Setup, we can't really
            // test the string content, but we can test to ensure errors aren't thrown
            #expect(try device.channelName(forChannelNumber: 1, of: .input) == nil) // left
            #expect(try device.channelName(forChannelNumber: 2, of: .input) == nil) // right
            #expect(try device.channelName(forChannelNumber: 1, of: .output) == nil) // left
            #expect(try device.channelName(forChannelNumber: 2, of: .output) == nil) // right

            // channel 3 does not exist for either input or output, but we get `nil` instead of an error
            #expect(try device.channelName(forChannelNumber: 3, of: .input) == nil)
            #expect(try device.channelName(forChannelNumber: 3, of: .output) == nil)
        }

        // MARK: streams(for:)

        @Test
        func streams_for_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.streams(for: .input)
            }
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.streams(for: .output)
            }
        }

        @Test(.enabledIfAudioDevicePresent(.blackHole2Ch))
        func streams_for_valid() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            // BlackHole contains 1 input stream and 1 output stream
            #expect(try device.streams(for: .input).count == 1)
            #expect(try device.streams(for: .output).count == 1)
        }

        // MARK: hasStreams(for:)

        @Test
        func hasStreams_for_invalid() throws {
            let device = AudioDevice(id: .randomUnused)
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.hasStreams(for: .input)
            }
            #expect(throws: SwiftCoreAudioError.self) {
                _ = try device.hasStreams(for: .output)
            }
        }

        @Test(.enabledIfAudioDevicePresent(.blackHole2Ch))
        func hasStreams_for_valid() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            // BlackHole contains 1 input stream and 1 output stream
            #expect(try device.hasStreams(for: .input) == true)
            #expect(try device.hasStreams(for: .output) == true)
        }

        // MARK: isPresent

        @Test
        func isPresent_invalid() {
            let device = AudioDevice(id: .randomUnused)
            #expect(device.isPresent == false)
        }

        @Test(.enabledIfAudioDevicePresent(.blackHole2Ch))
        func isPresent_valid() throws {
            let device = try #require(AudioDevice.blackHole2Ch)
            #expect(device.isPresent == true)
        }
    }
}

#endif
