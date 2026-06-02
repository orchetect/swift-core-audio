//
//  AudioStream RangedDescription.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import Foundation

extension AudioStream {
    /// Ranged audio stream description.
    ///
    /// Analogous to Core Audio's `AudioStreamRangedDescription`.
    ///
    /// Note that this structure is only used to describe the the available formats for a stream.
    /// It is not used for the current format.
    public struct RangedDescription {
        /// The ``BasicDescription`` that describes the format of the stream.
        ///
        /// Note that the `sampleRate` field of the basic description will be the same as the the
        /// values in ``sampleRateRange`` when only a single sample rate is supported. It will be
        /// `kAudioStreamAnyRate` when there is a range with more elements.
        nonisolated
        public var basicDescription: AvailableBasicDescription

        /// The minimum and maximum sample rate range for the stream. If the `sampleRate` field of
        /// ``basicDescription`` is `kAudioStreamAnyRate` the format supports the range of sample rates
        /// described by this structure. Otherwise, the minimum will be the same as the maximum
        ///  which will be the same as the `sampleRate` field of ``basicDescription``.
        nonisolated
        public var sampleRateRange: ClosedRange<Double>

        nonisolated
        public init(basicDescription: AvailableBasicDescription, sampleRateRange: ClosedRange<Double>) {
            self.basicDescription = basicDescription
            self.sampleRateRange = sampleRateRange
        }
    }
}

extension AudioStream.RangedDescription: Equatable { }

extension AudioStream.RangedDescription: Hashable { }

extension AudioStream.RangedDescription: Sendable { }

// MARK: - CustomStringConvertible

extension AudioStream.RangedDescription: CustomStringConvertible {
    nonisolated
    public var description: String {
        "\(basicDescription.format.description) @ \(sampleRateRange) \(basicDescription.bitsPerChannel)-bit"
    }
}

#endif
