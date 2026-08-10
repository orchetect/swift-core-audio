//
//  StereoAudioChannelIndexes.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

/// Left and right stereo channel indexes.
///
/// > Note:
/// >
/// > Core Audio channel numbers are presented to the end-user as a 1-based number series (not 0-based indexes).
/// > SwiftCoreAudio provides a `StereoAudioChannelIndexes` type which offers both a channel index
/// > a channel number property for each channel to avoid ambiguity.
public struct StereoAudioChannelIndexes {
    /// The channel index (0-based) for the left channel.
    public var left: AudioChannelIndex

    /// The channel index (0-based) for the right channel.
    public var right: AudioChannelIndex

    public init(left: AudioChannelIndex, right: AudioChannelIndex) {
        self.left = left
        self.right = right
    }
}

extension StereoAudioChannelIndexes: Equatable { }

extension StereoAudioChannelIndexes: Hashable { }

extension StereoAudioChannelIndexes: Sendable { }

extension StereoAudioChannelIndexes: Codable { }

extension StereoAudioChannelIndexes: CustomStringConvertible {
    public var description: String {
        "\(right.index), \(left.index)"
    }
}

extension StereoAudioChannelIndexes: CustomDebugStringConvertible {
    public var debugDescription: String {
        "StereoAudioChannelIndexes(right: \(right.index), left: \(left.index))"
    }
}

// MARK: - Convenience Inits

extension StereoAudioChannelIndexes {
    /// Construct a new instance from raw channel indexes (0-based).
    nonisolated
    public init(leftIndex: some BinaryInteger, rightIndex: some BinaryInteger) {
        self.init(
            left: AudioChannelIndex(index: leftIndex),
            right: AudioChannelIndex(index: rightIndex)
        )
    }

    /// Construct a new instance from raw channel numbers (1-based).
    nonisolated
    public init(leftNumber: some BinaryInteger, rightNumber: some BinaryInteger) {
        self.init(
            left: AudioChannelIndex(number: leftNumber),
            right: AudioChannelIndex(number: rightNumber)
        )
    }
}
