//
//  AudioStream RangedDescription+AudioStreamBasicDescription.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import Foundation

extension AudioStream.RangedDescription {
    /// Creates a new instance by converting from a Core Audio `AudioStreamRangedDescription`.
    nonisolated
    public init(from description: AudioStreamRangedDescription) throws(SwiftCoreAudioError) {
        let basicDescription = try AudioStream.AvailableBasicDescription(from: description.mFormat)
        let sampleRateRange = description.mSampleRateRange.mMinimum ... description.mSampleRateRange.mMaximum
        self.init(basicDescription: basicDescription, sampleRateRange: sampleRateRange)
    }

    /// Returns a new Core Audio `AudioStreamRangedDescription` instance by converting
    /// from this instance.
    nonisolated
    public var audioStreamRangedDescription: AudioStreamRangedDescription {
        AudioStreamRangedDescription(
            mFormat: basicDescription.audioStreamBasicDescription,
            mSampleRateRange: AudioValueRange(mMinimum: sampleRateRange.lowerBound, mMaximum: sampleRateRange.upperBound)
        )
    }
}

#endif
