//
//  AudioStream AvailableSampleRate.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import Foundation

extension AudioStream {
    /// Sample rate values for ``AvailableBasicDescription``.
    public enum AvailableSampleRate {
        /// Sample rate.
        case rate(Double)

        /// Any sample rate.
        case any
    }
}

extension AudioStream.AvailableSampleRate: AudioStream.BasicDescriptionSampleRate {
    nonisolated
    public init?(audioStreamSampleRate: Double) {
        switch audioStreamSampleRate {
        case kAudioStreamAnyRate:
            self = .any
            return
        case 0.000001...: // positive values
            self = .rate(audioStreamSampleRate)
        default: // negative values
            return nil
        }
    }
    
    nonisolated
    public var audioStreamSampleRate: Double {
        switch self {
        case let .rate(sampleRate): sampleRate
        case .any: kAudioStreamAnyRate
        }
    }
}

extension AudioStream.AvailableSampleRate: Equatable { }

extension AudioStream.AvailableSampleRate: Hashable { }

extension AudioStream.AvailableSampleRate: Sendable { }

// MARK: - CustomStringConvertible

extension AudioStream.AvailableSampleRate: CustomStringConvertible {
    nonisolated
    public var description: String {
        switch self {
        case let .rate(sampleRate):
            "\(sampleRate)Hz"
        case .any:
            "any sample rate"
        }
    }
}

#endif
