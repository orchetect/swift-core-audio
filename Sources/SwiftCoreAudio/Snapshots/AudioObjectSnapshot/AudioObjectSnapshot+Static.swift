//
//  AudioObjectSnapshot+Static.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

// MARK: - Static Constructors

extension AudioObjectSnapshot {
    /// Creates a full Core Audio system snapshot.
    public static func system() -> AudioObjectSnapshot {
        self.init(of: AudioSystem.shared)
    }
    
    // This method is functionally identical to the one above it, except it uses concurrency for improved performance.
    /// Creates a full Core Audio system snapshot.
    public static func system() async -> AudioObjectSnapshot {
        await self.init(of: AudioSystem.shared)
    }
}

#endif
