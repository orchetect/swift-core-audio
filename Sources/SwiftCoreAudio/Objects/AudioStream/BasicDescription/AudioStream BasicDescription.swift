//
//  AudioStream BasicDescription.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import Foundation

extension AudioStream {
    /// Basic audio stream description.
    ///
    /// Analogous to Core Audio's `AudioStreamBasicDescription`.
    ///
    /// > Important:
    /// >
    /// > When referring to this type or constructing a new instance, do not use this type directly.
    /// > Use one of the concrete typealiases that define their sample rate types:
    /// > ``CurrentBasicDescription`` or ``AvailableBasicDescription``.
    public struct BasicDescription<SampleRate: BasicDescriptionSampleRate> {
        /// An identifier specifying the general audio data format in the stream.
        nonisolated
        public var format: AudioFormat

        /// Format-specific flags to specify details of the format.
        nonisolated
        public var formatFlags: AudioFormatFlags // TODO: Create a new enum for these flags

        /// The number of frames per second of the data in the stream, when playing the stream at normal speed.
        nonisolated
        public var sampleRate: SampleRate

        /// The number of bits for one audio sample.
        nonisolated
        public var bitsPerChannel: UInt32

        /// The number of bytes from the start of one frame to the start of the next frame in an audio buffer.
        nonisolated
        public var bytesPerFrame: UInt32

        /// The number of channels in each frame of audio data.
        nonisolated
        public var channelsPerFrame: UInt32

        /// The number of bytes in a packet of audio data.
        nonisolated
        public var bytesPerPacket: UInt32

        /// The number of frames in a packet of audio data.
        nonisolated
        public var framesPerPacket: UInt32

        /// The amount to pad the structure to force an even 8-byte alignment.
        nonisolated
        public var reserved: UInt32

        nonisolated
        public init(
            format: AudioFormat,
            formatFlags: AudioFormatFlags,
            sampleRate: SampleRate,
            bitsPerChannel: UInt32,
            bytesPerFrame: UInt32,
            channelsPerFrame: UInt32,
            bytesPerPacket: UInt32,
            framesPerPacket: UInt32,
            reserved: UInt32
        ) {
            self.format = format
            self.formatFlags = formatFlags
            self.sampleRate = sampleRate
            self.bitsPerChannel = bitsPerChannel
            self.bytesPerFrame = bytesPerFrame
            self.channelsPerFrame = channelsPerFrame
            self.bytesPerPacket = bytesPerPacket
            self.framesPerPacket = framesPerPacket
            self.reserved = reserved
        }
    }
}

extension AudioStream.BasicDescription: Equatable { }

extension AudioStream.BasicDescription: Hashable { }

extension AudioStream.BasicDescription: Sendable { }

// MARK: - CustomStringConvertible

extension AudioStream.BasicDescription: CustomStringConvertible {
    nonisolated
    public var description: String {
        "\(format.description) @ \(sampleRate) \(bitsPerChannel)-bit"
    }
}

#endif
