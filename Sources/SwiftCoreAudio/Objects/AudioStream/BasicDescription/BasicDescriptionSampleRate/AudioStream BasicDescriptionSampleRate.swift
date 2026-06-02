//
//  AudioStream BasicDescriptionSampleRate.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import Foundation

extension AudioStream {
    /// Protocol that ``BasicDescription`` sample rate types conform to.
    nonisolated
    public protocol BasicDescriptionSampleRate: Equatable, Hashable, Sendable, CustomStringConvertible {
        /// Returns the raw Core Audio sample rate value.
        nonisolated
        var audioStreamSampleRate: Double { get }

        /// Construct from a raw Core Audio sample rate value.
        nonisolated
        init?(audioStreamSampleRate: Double)
    }
}

// MARK: - Inits

extension AudioStream.BasicDescriptionSampleRate {
    /// Same as ``init(audioStreamSampleRate:)`` but throws an error instead of returning `nil` when the init fails.
    nonisolated
    public init(tryingAudioStreamSampleRate rawValue: Double) throws(SwiftCoreAudioError) {
        guard let match = Self(audioStreamSampleRate: rawValue) else {
            throw .notYetImplemented(message: "Unhandled/unrecognized audio stream sample rate value: \(rawValue)")
        }
        self = match
    }
}

#endif
