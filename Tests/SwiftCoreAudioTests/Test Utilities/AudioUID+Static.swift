//
//  AudioUID+Static.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import Foundation
import SwiftCoreAudio

extension AudioUID {
    // MARK: - Random

    /// Random UID useful for testing an object UID that is guaranteed to not exist.
    static var random: Self {
        Self(UUID().uuidString)
    }
}

#endif
