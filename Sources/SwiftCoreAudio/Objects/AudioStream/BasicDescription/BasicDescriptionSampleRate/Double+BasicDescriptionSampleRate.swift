//
//  Double+BasicDescriptionSampleRate.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import Foundation

extension Double: AudioStream.BasicDescriptionSampleRate {
    nonisolated
    public var audioStreamSampleRate: Double {
        self
    }

    nonisolated
    public init?(audioStreamSampleRate: Double) {
        self = audioStreamSampleRate
    }
}

#endif
