//
//  AudioStreamProperties+Convenience.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// MARK: - Channels

extension AudioStream {
    /// Convenience to return the channel count contained in the stream's the virtual format.
    nonisolated
    public var channelCount: Int {
        get throws(SwiftCoreAudioError) {
            try Int(virtualFormat.channelsPerFrame)
        }
    }
}

#endif
