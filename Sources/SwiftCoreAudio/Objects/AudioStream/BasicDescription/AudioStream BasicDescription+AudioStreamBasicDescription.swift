//
//  AudioStream BasicDescription+AudioStreamBasicDescription.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import Foundation

extension AudioStream.BasicDescription {
    /// Creates a new instance by converting from a Core Audio `AudioStreamBasicDescription`.
    nonisolated
    public init(from description: AudioStreamBasicDescription) throws(SwiftCoreAudioError) {
        let audioFormat = try AudioFormat(tryingRawValue: description.mFormatID)
        let sampleRate = try SampleRate(tryingAudioStreamSampleRate: description.mSampleRate)

        self.init(
            format: audioFormat,
            formatFlags: description.mFormatFlags,
            sampleRate: sampleRate,
            bitsPerChannel: description.mBitsPerChannel,
            bytesPerFrame: description.mBytesPerFrame,
            channelsPerFrame: description.mChannelsPerFrame,
            bytesPerPacket: description.mBytesPerPacket,
            framesPerPacket: description.mFramesPerPacket,
            reserved: description.mReserved
        )
    }

    /// Returns a new Core Audio `AudioStreamBasicDescription` instance by converting
    /// from this instance.
    nonisolated
    public var audioStreamBasicDescription: AudioStreamBasicDescription {
        AudioStreamBasicDescription(
            mSampleRate: sampleRate.audioStreamSampleRate,
            mFormatID: format.rawValue,
            mFormatFlags: formatFlags,
            mBytesPerPacket: bytesPerPacket,
            mFramesPerPacket: framesPerPacket,
            mBytesPerFrame: bytesPerFrame,
            mChannelsPerFrame: channelsPerFrame,
            mBitsPerChannel: bitsPerChannel,
            mReserved: reserved
        )
    }
}

#endif
